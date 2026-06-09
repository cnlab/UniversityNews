# Step 2 analysis configuration
# Source this file at the top of each analysis script

# ── Data source ────────────────────────────────────────────────────────────────
USE_API       <- TRUE

SURVEY_ID     <- "SV_cRReDnnOiDdlnDg"
DATA_CENTER   <- "iad1"

LOCAL_DATA_PATH <- here::here("Data", "Raw", "UnivNews_Step2_Cohort1_updated.csv")

# ── Output paths ───────────────────────────────────────────────────────────────
ANALYSIS_DIR  <- here::here("Step2", "analysis")
EDA_DIR       <- file.path(ANALYSIS_DIR, "eda")
CLEANED_RDS   <- file.path(ANALYSIS_DIR, "step2_clean.rds")
RESULTS_RDS   <- file.path(ANALYSIS_DIR, "step2_results.rds")

# ── Cohort cutoffs ─────────────────────────────────────────────────────────────
COHORT1_START <- as.POSIXct("2026-06-04 00:00:00", tz = "America/New_York")

# ── Condition settings ─────────────────────────────────────────────────────────
# Reference level for all models is "control"
# origcontrol1 is the reference level (corrected control, variant 1)
# origcontrol2 = corrected control variant 2; claudecontrol = old flawed control (kept for comparison)
# "origcontrol" (FL_76 bug — no article shown) retained through imputation but excluded in 00_clean.Rmd
CONDITION_LEVELS <- c("origcontrol1", "origcontrol2", "claudecontrol", "relevance", "action", "origcontrol")
