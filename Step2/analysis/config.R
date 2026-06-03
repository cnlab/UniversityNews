# Step 2 analysis configuration
# Source this file at the top of each analysis script

# ── Data source ────────────────────────────────────────────────────────────────
USE_API       <- TRUE

SURVEY_ID     <- "SV_cRReDnnOiDdlnDg"
DATA_CENTER   <- "iad1"

LOCAL_DATA_PATH <- here::here("data", "raw", "UnivNews_Step2_test.csv")

# ── Output paths ───────────────────────────────────────────────────────────────
ANALYSIS_DIR  <- here::here("Step2", "analysis")
EDA_DIR       <- file.path(ANALYSIS_DIR, "eda")
CLEANED_RDS   <- file.path(ANALYSIS_DIR, "step2_clean.rds")
RESULTS_RDS   <- file.path(ANALYSIS_DIR, "step2_results.rds")

# ── Condition settings ─────────────────────────────────────────────────────────
# Reference level for all models is "control"
CONDITION_LEVELS <- c("control", "relevance", "action")
