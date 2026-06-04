# Step 2 analysis configuration
# Source this file at the top of each analysis script

# ── Data source ────────────────────────────────────────────────────────────────
USE_API       <- TRUE

SURVEY_ID     <- "SV_cRReDnnOiDdlnDg"
DATA_CENTER   <- "iad1"

LOCAL_DATA_PATH <- here::here("Data", "Raw", "UnivNews_Step2_Cohort1.csv")

# ── Output paths ───────────────────────────────────────────────────────────────
ANALYSIS_DIR  <- here::here("Step2", "analysis")
EDA_DIR       <- file.path(ANALYSIS_DIR, "eda")
CLEANED_RDS   <- file.path(ANALYSIS_DIR, "step2_clean.rds")
RESULTS_RDS   <- file.path(ANALYSIS_DIR, "step2_results.rds")

# ── Cohort cutoffs ─────────────────────────────────────────────────────────────
COHORT1_START <- as.POSIXct("2026-06-04 00:00:00", tz = "America/New_York")

# ── Condition settings ─────────────────────────────────────────────────────────
# Reference level for all models is "control"
CONDITION_LEVELS <- c("control", "relevance", "action")
