library(tidyverse)
library(qualtRics)
library(here)

source(here("Step2", "analysis", "config.R"))

# ── 1. Load data ───────────────────────────────────────────────────────────────
if (USE_API) {
  qualtrics_api_credentials(
    api_key  = Sys.getenv("QUALTRICS_API_KEY"),
    base_url = paste0(DATA_CENTER, ".qualtrics.com")
  )
  raw <- fetch_survey(
    surveyID     = SURVEY_ID,
    label        = FALSE,
    convert      = FALSE,
    force_request = TRUE
  )
} else {
  raw <- read_survey(LOCAL_DATA_PATH)
}

# ── 2. Inspect column names ────────────────────────────────────────────────────
# Run this once to verify column names match the renaming map below.
# Comment out after confirming.
cat("Columns in raw data:\n")
print(names(raw))

# ── 3. Exclusions ──────────────────────────────────────────────────────────────
d <- raw |>
  # Remove Qualtrics preview/test responses
  filter(Status == 0 | is.na(Status)) |>
  # Remove unsubmitted or partial responses
  filter(Finished == TRUE | Finished == 1) |>
  # Remove Prolific template row (unfilled PID)
  filter(PROLIFIC_PID != "{{%PROLIFIC_PID%}}", !is.na(PROLIFIC_PID))

cat("\nN after exclusions:", nrow(d), "\n")

# ── 4. Rename outcome variables ────────────────────────────────────────────────
# TODO: verify these column names against your export using the printout above.
# qualtRics names MC/slider questions by export tag (default: Q + number).
# The QSF question IDs map as follows — cross-check the printed column names.
#
# ArticleRate block (same across all conditions):
#   QID1319 → share_direct   (slider: share directly with someone)
#   QID1320 → share_social   (slider: share on social media)
#   QID1306 → article_self_relev / article_social_relev (_1 = "relevant to me", _2 = "relevant to people I know")
#
# Condition-specific "want to read more" sliders (coalesced below):
#   QID1321 (Relevance), QID1322 (Action), QID1325 (Control) → read_more
#
# GovtFunding block:
#   QID1108 → govtfund_general  (MC: general attitude toward federal research funding)
#   QID1301 → govtfund_cuts     (MC: approve/disapprove of proposed cuts)
#
# BehaviorIntentions block:
#   QID1124 → behavior_intent   (MC: behavioral intention)
#
# Climate block (8 items — rename individually once column names confirmed):
#   QID1142, QID1188, QID1114, QID1189, QID1115, QID1190, QID1298, QID1300

d <- d |>
  rename(
    share_direct      = matches("^Q1319"),
    share_social      = matches("^Q1320"),
    read_more_rel     = matches("^Q1321"),   # Relevance condition only
    read_more_act     = matches("^Q1322"),   # Action condition only
    read_more_con     = matches("^Q1325"),   # Control condition only
    govtfund_general  = matches("^Q1108"),
    govtfund_cuts     = matches("^Q1301"),
    behavior_intent   = matches("^Q1124"),
    climate_1         = matches("^Q1142"),
    climate_2         = matches("^Q1188"),
    climate_3         = matches("^Q1114"),
    climate_4         = matches("^Q1189"),
    climate_5         = matches("^Q1115"),
    climate_6         = matches("^Q1190"),
    climate_7         = matches("^Q1298"),
    climate_8         = matches("^Q1300")
  )

# ── 5. Coalesce condition-specific read_more items ─────────────────────────────
d <- d |>
  mutate(
    read_more = coalesce(
      as.numeric(read_more_rel),
      as.numeric(read_more_act),
      as.numeric(read_more_con)
    )
  ) |>
  select(-read_more_rel, -read_more_act, -read_more_con)

# ── 6. Condition factor ────────────────────────────────────────────────────────
d <- d |>
  filter(condition %in% CONDITION_LEVELS) |>
  mutate(
    condition = factor(condition, levels = CONDITION_LEVELS)
    # "control" is the reference level
  )

cat("\nCondition counts:\n")
print(table(d$condition))

# ── 7. Numeric coercion ────────────────────────────────────────────────────────
outcome_vars <- c(
  "share_direct", "share_social", "read_more",
  "govtfund_general", "govtfund_cuts", "behavior_intent",
  "climate_1", "climate_2", "climate_3", "climate_4",
  "climate_5", "climate_6", "climate_7", "climate_8"
)

d <- d |>
  mutate(across(all_of(outcome_vars), as.numeric))

# ── 8. Climate scale composite ────────────────────────────────────────────────
# Average across 8 items if all items are on the same scale direction.
# TODO: confirm item directions before computing composite.
d <- d |>
  mutate(
    climate_composite = rowMeans(
      pick(climate_1:climate_8),
      na.rm = TRUE
    )
  )

# ── 9. Save ────────────────────────────────────────────────────────────────────
saveRDS(d, CLEANED_RDS)
cat("\nCleaned data saved to", CLEANED_RDS, "\n")
cat("N =", nrow(d), "\n")
