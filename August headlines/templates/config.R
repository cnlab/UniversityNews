# =============================================================================
# config.R  --  THE ONLY FILE YOU NEED TO EDIT FOR A NEW DATA COLLECTION
# =============================================================================
# Multi-variant headline study (control + 2-3 self-relevance variants per
# headline). Every script (00_clean, 01_analysis, 02_prolific_rejections)
# sources this file, so change paths / design here in ONE place.
#
# To run a new round of collection:
#   1. Drop the new Qualtrics .csv and Prolific .csv into a Data/ folder.
#   2. Update the three paths in SECTION 1.
#   3. Update SECTION 2 if the survey's column naming changed.
#   4. Knit 00_clean.Rmd, then 02_prolific_rejections.Rmd, then 01_analysis.Rmd.
#
# The defaults below point at the Step 3 July Newsletter data so the whole
# pipeline runs out of the box as a worked example. July is a 2-arm special
# case (control + 1 variant); nothing changes for 3-4 variants except the
# values that appear in the condition columns.
# =============================================================================

suppressWarnings(suppressMessages({
  library(here)
}))

CFG <- list()

# ---- SECTION 1: FILE PATHS (edit every round) -------------------------------
CFG$qualtrics_path <- here("Step3_JulyNewsletter", "Data",
                           "UnivNews_JulyNewsletter_July 6, 2026_10.30.csv")
CFG$prolific_path  <- here("Step3_JulyNewsletter", "Data",
                           "prolific_demographic_export_6a4566994567f01b9f90d339.csv")
CFG$cleaned_rds    <- here("August headlines", "templates", "output",
                           "clean.rds")
CFG$reject_csv     <- here("August headlines", "templates", "output",
                           "prolific_rejections.csv")

# ---- SECTION 2: SURVEY DESIGN (edit if column names change) -----------------
# Outcome columns are expected as: <prefix><i>_<measure>_1
#   e.g. july1_relevant_1, july2_read_1, ...  (July uses prefix "july")
# For a new survey you might use prefix "h" -> h1_relevant_1, etc.
CFG$headline_prefix <- "july"          # stem before the headline number
CFG$n_headlines     <- 4               # K: number of headlines each person sees
CFG$measures        <- c("relevant", "read", "share")  # slider outcomes (0-100)
CFG$primary_measure <- "relevant"      # main DV for the analysis writeup

# Per-headline condition (arm) columns: <condition_prefix><i>
#   July: condition_1 ... condition_4, values "control" / "relevance"
#   New : condition_1 ... condition_K, values "control" / "v1" / "v2" / "v3"
CFG$condition_prefix <- "condition_"
CFG$control_label    <- "control"      # reference arm for all contrasts

# Attention-check slider columns (participants told to set each to 100).
# Only sliders a participant actually SAW (non-NA) are scored; an unseen item
# is never counted as a failure, and all-NA yields 0 wrong. List every possible
# attention column here even if some blocks are shown to only a subset.
CFG$attn_cols     <- c("attnA_1_1", "attnA_2_1", "attnA_3_1",
                       "attnB_1_1", "attnB_2_1", "attnB_3_1")
CFG$attn_correct  <- 100               # correct slider value
CFG$attn_nfail    <- 2                 # >= this many wrong (of those seen) => attention flag

# ---- SECTION 3: QUALITY / REJECTION THRESHOLDS (rarely change) --------------
CFG$recaptcha_col       <- "Q_RecaptchaScore"
CFG$recaptcha_threshold <- 0.5         # score < this = reCAPTCHA fail
CFG$duplicate_col       <- "Q_DuplicateRespondent"   # TRUE = duplicate
CFG$worktime_col        <- "worktimeArray"           # per-segment secs; negatives = off-task
CFG$offtask_threshold_min <- 15        # > this many minutes off-task = auto-reject
CFG$prolific_bot_fail   <- c("mixed", "low")         # Prolific Bots values that count as bad

# Straightlining: identical response to (nearly) every substantive slider, e.g.
# setting all outcome sliders to 0 (or all to the same value). Detected as
# near-zero variance across the outcome sliders the participant answered.
CFG$straightline_cols      <- NULL  # NULL = auto (all measures x headlines outcome sliders)
CFG$straightline_sd_thresh <- 0     # row SD <= this across those sliders => straightline (0 = exactly identical)
CFG$straightline_min_items <- 6     # require at least this many answered sliders to judge

# Flag logic (see helpers.R::compute_flags):
#   flag_bot_combined = reCAPTCHA fail AND Prolific bot fail   (conjunctive, WiN-style)
#   flag_duplicate    = Q_DuplicateRespondent == TRUE
#   flag_auth_q       = any Prolific per-question authenticity check == "Fail"
#   flag_attention    = >= attn_nfail sliders wrong (of those seen)
#   flag_straightline = identical value across the substantive sliders answered
#   flag_offtask      = off-task minutes > offtask_threshold_min
# REJECT / EXCLUDE if:  any standalone-reject flag  OR  (n_flags >= reject_nflags)
CFG$reject_nflags <- 2

# Standalone auto-reject flags: a participant is rejected if ANY of these fire,
# regardless of the 2+ count. Off-task is standalone by design (your abstract's
# "15-min threshold for rejection"). Add "flag_attention" here if you want
# failing 2+ attention checks to be sufficient on its own to reject (in the July
# data that would move rejections from 0 to 32, incl. 27 all-zero responders).
CFG$standalone_reject_flags <- c("flag_offtask")
# e.g. to also auto-reject blatant attention failures:
# CFG$standalone_reject_flags <- c("flag_offtask", "flag_attention")

# ---- Source shared helper functions -----------------------------------------
source(here("August headlines", "templates", "helpers.R"))
