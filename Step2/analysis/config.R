# Step 2 analysis configuration
# Source this file at the top of each analysis script

# ── Data source ────────────────────────────────────────────────────────────────
USE_API       <- FALSE                         # set TRUE once API credentials are configured

SURVEY_ID     <- "SV_XXXXXXXXXXXXXXX"          # TODO: fill in Qualtrics survey ID
DATA_CENTER   <- "iad1"                        # TODO: fill in your Qualtrics data center

LOCAL_DATA_PATH <- here::here("data", "raw", "UnivNews_Step2_test.csv")

# ── Output paths ───────────────────────────────────────────────────────────────
ANALYSIS_DIR  <- here::here("Step2", "analysis")
EDA_DIR       <- file.path(ANALYSIS_DIR, "eda")
CLEANED_RDS   <- file.path(ANALYSIS_DIR, "step2_clean.rds")
RESULTS_RDS   <- file.path(ANALYSIS_DIR, "step2_results.rds")

# ── Condition settings ─────────────────────────────────────────────────────────
# Reference level for all models is "control"
CONDITION_LEVELS <- c("control", "relevance", "action")
