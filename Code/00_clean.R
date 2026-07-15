library(tidyverse)

path <- "~/Documents/GitHub/UniversityNews"

# ---- load and bind qualtrics data ----------------------------------------

load_qualtrics <- function(cohort) {
  read.csv(sprintf("%s/Data/Raw/UnivNews_Step1_Cohort%s.csv", path, cohort)) %>%
    tail(-2) %>%                                          # remove label rows
    filter(Status != "Survey Preview") %>%
    filter(consent == "I agree to participate in this study.") %>%
    mutate(cohort = cohort)
}

qualtrics <- map_dfr(1:3, load_qualtrics)

# ---- load prolific data (final approved export) --------------------------

prolific <- read.csv(sprintf("%s/Data/Raw/UnivNews_Step1_prolific_demographic_export_final.csv", path)) %>%
  select(any_of(c(
    "Participant.id", "Status", "Age", "Sex",
    "Authenticity.check..QID444",
    "Authenticity.check..Bots"
  ))) %>%
  rename(
    PROLIFIC_PID       = Participant.id,
    prolific_status    = Status,
    age                = Age,
    sex                = Sex,
    prolific_check_llm = Authenticity.check..QID444,
    prolific_check_bot = Authenticity.check..Bots
  ) %>%
  distinct(PROLIFIC_PID, .keep_all = TRUE)

approved_pids <- prolific %>% filter(prolific_status == "APPROVED") %>% pull(PROLIFIC_PID)

# ---- join and filter to approved participants only -----------------------

data <- qualtrics %>%
  filter(PROLIFIC_PID %in% approved_pids) %>%
  left_join(prolific, by = "PROLIFIC_PID")

# ---- timing variables ----------------------------------------------------

data <- data %>%
  mutate(
    time_list        = strsplit(as.character(worktimeArray), ","),
    time_numeric     = lapply(time_list, function(x) as.numeric(gsub("[^0-9.-]", "", x))),
    on_task_min      = sapply(time_numeric, function(x) round(sum(x[x > 0],  na.rm = TRUE) / 60, 2)),
    off_task_min     = sapply(time_numeric, function(x) round(sum(abs(x[x < 0]), na.rm = TRUE) / 60, 2)),
    duration_min     = round(as.numeric(Duration..in.seconds.) / 60, 2)
  ) %>%
  select(-time_list, -time_numeric)

# ---- quality flags -------------------------------------------------------

data <- data %>%
  mutate(
    flag_recaptcha  = as.numeric(Q_RecaptchaScore) < 0.5,   # Qualtrics reCAPTCHA / bot score
    flag_bot        = prolific_check_bot == "mixed",        # Prolific bot detection
    flag_attn       = coalesce(attention_1 != "Somewhat agree", FALSE) |   # failed ANY of the 3 attention checks
                      coalesce(attention_2 != "Disagree", FALSE) |
                      coalesce(attention_3 != "Somewhat disagree", FALSE),
    flag_offtask    = off_task_min > 15,                    # >15 min off-task (kept, NOT an exclusion criterion)

    # ---- Exclusion rule --------------------------------------------------
    # Exclude participants who failed MORE THAN ONE of the three quality tests:
    # attention check, Qualtrics bot detection, Prolific bot detection.
    # NA on a check is treated as "not failed" so missing data does not drive exclusion.
    n_quality_fail  = coalesce(flag_attn, FALSE) +
                      coalesce(flag_recaptcha, FALSE) +
                      coalesce(flag_bot, FALSE),
    exclude         = n_quality_fail >= 2,

    n_flags         = coalesce(flag_recaptcha, FALSE) + coalesce(flag_bot, FALSE) +
                      coalesce(flag_attn, FALSE) + coalesce(flag_offtask, FALSE),
    flag_any        = n_flags >= 2
  )

# ---- derived variables ---------------------------------------------------

data <- data %>%
  mutate(
    ses_ladder = case_when(
      ses_subjective_1  == "On" ~ 1L,  ses_subjective_2  == "On" ~ 2L,
      ses_subjective_3  == "On" ~ 3L,  ses_subjective_4  == "On" ~ 4L,
      ses_subjective_5  == "On" ~ 5L,  ses_subjective_6  == "On" ~ 6L,
      ses_subjective_7  == "On" ~ 7L,  ses_subjective_8  == "On" ~ 8L,
      ses_subjective_9  == "On" ~ 9L,  ses_subjective_10 == "On" ~ 10L,
      TRUE ~ NA_integer_
    )
  )

# ---- drop irrelevant columns ---------------------------------------------

data <- data %>%
  select(-condition, -activeweek)

# ---- apply exclusions & save ---------------------------------------------

# Pre-exclusion quality summary
cat("Before exclusions: N =", nrow(data), "\n")
cat("  flag_recaptcha (Qualtrics bot):", sum(data$flag_recaptcha, na.rm = TRUE), "\n")
cat("  flag_bot (Prolific bot):       ", sum(data$flag_bot, na.rm = TRUE), "\n")
cat("  flag_attn (any of 3 attn failed):", sum(data$flag_attn, na.rm = TRUE), "\n")
cat("  flag_offtask (>15 min, NOT an exclusion criterion):", sum(data$flag_offtask, na.rm = TRUE), "\n")
cat("  n_quality_fail distribution:\n"); print(table(data$n_quality_fail))
cat("  -> excluded (failed 2+ quality tests):", sum(data$exclude), "\n")

# Keep a full (pre-exclusion) copy for sensitivity checks
saveRDS(data, sprintf("%s/Data/Cleaned/UnivNews_Step1_combined_full.rds", path))

# Apply exclusion: drop participants who failed more than one quality test
data <- data %>% filter(!exclude)

saveRDS(data, sprintf("%s/Data/Cleaned/UnivNews_Step1_combined.rds", path))

cat("\nSaved (post-exclusion): N =", nrow(data), "(cohort 1 =",
    sum(data$cohort == 1), ", cohort 2 =", sum(data$cohort == 2),
    ", cohort 3 =", sum(data$cohort == 3), ")\n")
cat("Columns:", ncol(data), "\n")
