# =============================================================================
# config.R  --  THE ONLY FILE YOU NEED TO EDIT FOR A NEW DATA COLLECTION
# =============================================================================
# Every script (00_clean, 01_prolific_rejections, 02_analysis)
# sources this file, so change paths / design here in ONE place.
#
# To run a new round of collection:
#   1. Drop the new Qualtrics .csv and Prolific .csv into a Data/ folder.
#   2. Update the three paths in SECTION 1.
#   3. Update SECTION 2 if the survey's column naming changed.
#   4. Knit 00_clean.Rmd, then 01_prolific_rejections.Rmd, then 02_analysis.Rmd.
# =============================================================================

suppressWarnings(suppressMessages({
  library(here)
}))

CFG <- list()

# ---- SECTION 1: FILE PATHS (edit every round) -------------------------------
# Drop the fielded
# Qualtrics + Prolific exports into August headlines/Data/ and update the names.
# Each path may be a single file OR a vector of files to combine (e.g. a pilot
# plus the full launch). Multiple files are row-bound and de-duplicated
# (Qualtrics by ResponseId, Prolific by Participant id). List every wave:
CFG$qualtrics_path <- c(
  here("Newsletter testing", "August headlines", "Data", "UnivNews_Newsletter.csv")  # <-- fielded export(s) (TBD)
)
CFG$prolific_path  <- c(
  here("Newsletter testing", "August headlines", "Data", "prolific_export.csv")      # <-- Prolific export(s) (TBD)
)
CFG$cleaned_rds    <- here("Newsletter testing", "templates", "output",
                           "newsletter_clean.rds")
CFG$reject_csv     <- here("Newsletter testing", "templates", "output",
                           "prolific_rejections.csv")

# ---- SECTION 2: SURVEY DESIGN (edit if column names change) -----------------
# Outcome columns are expected as: <prefix><i>_<measure>_1
#   Newsletter template: news1_read_1, news1_share_1, news1_relevant_1, ...
CFG$headline_prefix <- "news"          # stem before the article number
CFG$n_headlines     <- 6               # K: number of articles each person sees
CFG$measures        <- c("relevant", "read", "share")  # slider outcomes (0-100)
CFG$primary_measure <- "relevant"      # main DV for the analysis writeup

# Per-article condition (arm) columns: <condition_prefix><i>, set by the survey's
# balanced randomizer. The final template codes these as "A" / "B", where
# A = control and B = self-relevant for every article. `arm_labels` maps those
# raw codes to readable labels for the analysis output (set to NULL to keep the
# raw values); `control_label` is the resulting reference arm.
CFG$condition_prefix <- "condition_"
CFG$arm_labels       <- c(A = "control", B = "selfrel")  # raw survey value -> display label
CFG$control_label    <- "control"      # reference arm for all contrasts, every article

# Research-attitude items (7-pt Likert, measured once per person). Newsletter
# template block "Research Relevance": research_relevance_1 / _2.
CFG$research_cols   <- c("research_relevance_1", "research_relevance_2")
CFG$research_labels <- c("Apply findings in own life", "Research relevant to me personally")

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
# regardless of the 2+ count.
CFG$standalone_reject_flags <- c("flag_offtask","flag_bot_combined","flag_duplicate")


# ---- Source shared helper functions -----------------------------------------
source(here("Newsletter testing", "templates", "helpers.R"))
