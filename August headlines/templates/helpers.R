# =============================================================================
# helpers.R  --  shared functions for the multi-variant headline pipeline
# Sourced by config.R. Do not edit for routine data swaps; edit config.R.
# =============================================================================

suppressWarnings(suppressMessages({
  library(tidyverse)
  library(qualtRics)
}))

# ---- Read raw data ----------------------------------------------------------

# Qualtrics export (handles the 3-row header via qualtRics::read_survey).
read_qualtrics <- function(path) {
  suppressWarnings(read_survey(path))
}

# Prolific export. Renames the stable Prolific columns to internal names and
# keeps everything else (demographics + the per-question authenticity checks,
# which are named "Authenticity check: QID....").
read_prolific <- function(path) {
  p <- suppressWarnings(read_csv(path, show_col_types = FALSE))
  rename(p,
         PROLIFIC_PID    = `Participant id`,
         submission_id   = `Submission id`,
         prolific_status = Status,
         prolific_time   = `Time taken`,
         completion_code = `Completion code`,
         prolific_bot    = `Authenticity check: Bots`)
}

# ---- Off-task time ----------------------------------------------------------
# worktimeArray is a comma-separated list of per-segment durations in seconds;
# negative values are time spent off the survey tab. Returns minutes off-task.
# (Mirrors the WiN base script exactly.)
parse_offtask_min <- function(v) {
  vapply(strsplit(as.character(v), ","), function(x) {
    num <- suppressWarnings(as.numeric(gsub("[^0-9.-]", "", x)))
    sum(abs(num[num < 0]), na.rm = TRUE)
  }, numeric(1)) / 60
}

# ---- Quality flags ----------------------------------------------------------
# Takes a merged (Qualtrics + Prolific) one-row-per-participant data frame and
# the CFG list. Returns the same data frame with flag columns, n_flags, off_task_min,
# reject (logical), and reject_reason (human-readable string). Missing columns
# degrade gracefully to FALSE with a warning, so the template survives surveys
# that lack a given check.
compute_flags <- function(d, CFG) {

  has_col <- function(nm) nm %in% names(d)
  warn_missing <- function(nm, flag) {
    if (!has_col(nm)) warning(sprintf("Column '%s' not found; %s set to FALSE.", nm, flag))
  }

  # --- attention: count only sliders the participant actually SAW (non-NA)
  #     and got wrong. A participant is never penalised for an item they were
  #     not shown (blocks can be shown to different subsets), and all-NA
  #     (saw no checks) yields 0 wrong. ---
  attn <- CFG$attn_cols[CFG$attn_cols %in% names(d)]
  if (length(attn) == 0) {
    warning("No attention columns found; attention flag set to FALSE.")
    n_attn_wrong <- rep(0, nrow(d)); n_attn_shown <- rep(0, nrow(d))
  } else {
    wrong_mat    <- vapply(d[attn], function(x) !is.na(x) & x != CFG$attn_correct,
                           logical(nrow(d)))
    shown_mat    <- vapply(d[attn], function(x) !is.na(x), logical(nrow(d)))
    n_attn_wrong <- rowSums(wrong_mat)
    n_attn_shown <- rowSums(shown_mat)
  }
  flag_attention <- n_attn_wrong >= CFG$attn_nfail

  # --- reCAPTCHA ---
  warn_missing(CFG$recaptcha_col, "reCAPTCHA fail")
  rc <- if (has_col(CFG$recaptcha_col)) suppressWarnings(as.numeric(d[[CFG$recaptcha_col]])) else rep(NA_real_, nrow(d))
  flag_recaptcha <- !is.na(rc) & rc < CFG$recaptcha_threshold

  # --- Prolific bot (mixed/low) ---
  pb <- if (has_col("prolific_bot")) tolower(as.character(d[["prolific_bot"]])) else rep(NA_character_, nrow(d))
  flag_prolific_bot <- pb %in% CFG$prolific_bot_fail

  # --- combined bot flag (conjunctive: BOTH signals) ---
  flag_bot_combined <- flag_recaptcha & flag_prolific_bot

  # --- duplicate respondent ---
  warn_missing(CFG$duplicate_col, "duplicate flag")
  dup_raw <- if (has_col(CFG$duplicate_col)) d[[CFG$duplicate_col]] else rep(NA, nrow(d))
  flag_duplicate <- tolower(as.character(dup_raw)) %in% c("true", "1")

  # --- Prolific per-question authenticity checks (any == "Fail") ---
  authq_cols <- grep("^Authenticity check:", names(d), value = TRUE)  # Bots already renamed away
  if (length(authq_cols) == 0) {
    flag_auth_q <- rep(FALSE, nrow(d))
  } else {
    fail_mat <- vapply(d[authq_cols], function(x) tolower(as.character(x)) == "fail",
                       logical(nrow(d)))
    flag_auth_q <- rowSums(fail_mat, na.rm = TRUE) > 0
  }

  # --- straightlining: identical value across the substantive outcome sliders ---
  sl_cols <- CFG$straightline_cols
  if (is.null(sl_cols)) {
    sl_cols <- as.vector(t(outer(
      seq_len(CFG$n_headlines), CFG$measures,
      function(i, m) sprintf("%s%d_%s_1", CFG$headline_prefix, i, m))))
  }
  sl_cols <- sl_cols[sl_cols %in% names(d)]
  if (length(sl_cols) == 0) {
    warning("No straightline columns found; straightline flag set to FALSE.")
    flag_straightline <- rep(FALSE, nrow(d)); sl_n <- rep(0, nrow(d)); sl_value <- rep(NA_real_, nrow(d))
  } else {
    sl_mat  <- as.matrix(vapply(d[sl_cols], as.numeric, numeric(nrow(d))))
    sl_n    <- rowSums(!is.na(sl_mat))
    sl_sd   <- apply(sl_mat, 1, sd, na.rm = TRUE)
    sl_value <- apply(sl_mat, 1, function(x) { v <- x[!is.na(x)]; if (length(v)) v[1] else NA_real_ })
    flag_straightline <- sl_n >= CFG$straightline_min_items &
                         !is.na(sl_sd) & sl_sd <= CFG$straightline_sd_thresh
  }

  # --- off-task time ---
  warn_missing(CFG$worktime_col, "off-task flag")
  off_task_min <- if (has_col(CFG$worktime_col)) parse_offtask_min(d[[CFG$worktime_col]]) else rep(0, nrow(d))
  flag_offtask <- !is.na(off_task_min) & off_task_min > CFG$offtask_threshold_min

  # --- combine ---
  flags <- tibble(
    flag_bot_combined = flag_bot_combined,
    flag_duplicate    = flag_duplicate,
    flag_auth_q       = flag_auth_q,
    flag_attention    = flag_attention,
    flag_straightline = flag_straightline,
    flag_offtask      = flag_offtask
  )
  n_flags <- rowSums(flags)
  standalone <- intersect(CFG$standalone_reject_flags, names(flags))
  standalone_hit <- if (length(standalone) == 0) rep(FALSE, nrow(flags)) else
    rowSums(flags[standalone]) > 0
  reject <- standalone_hit | (n_flags >= CFG$reject_nflags)

  # --- human-readable reason per participant ---
  # Each entry: a logical vector and a reason string (scalar = recycled, or per-row).
  reason_parts <- list(
    list(flag_offtask,      sprintf("Off-task %.1f min (> %d)", off_task_min, CFG$offtask_threshold_min)),
    list(flag_attention,    sprintf("Failed %d of %d attention checks seen", n_attn_wrong, n_attn_shown)),
    list(flag_straightline, sprintf("Straightlined: same value (%g) across all %d sliders", sl_value, sl_n)),
    list(flag_bot_combined, "Bot: reCAPTCHA < 0.5 AND Prolific bot flag"),
    list(flag_duplicate,    "Duplicate respondent (Qualtrics)"),
    list(flag_auth_q,       "Prolific authenticity-question fail")
  )
  reason <- vapply(seq_len(nrow(d)), function(i) {
    bits <- character(0)
    for (rp in reason_parts) {
      if (isTRUE(rp[[1]][i])) {
        bits <- c(bits, if (length(rp[[2]]) == 1) rp[[2]] else rp[[2]][i])
      }
    }
    if (length(bits) == 0) NA_character_ else paste(bits, collapse = "; ")
  }, character(1))

  bind_cols(
    d,
    flags,
    tibble(n_attn_wrong = n_attn_wrong,
           n_attn_shown = n_attn_shown,
           n_sliders_same = sl_n,
           off_task_min = round(off_task_min, 2),
           n_flags      = n_flags,
           reject       = reject,
           reject_reason = reason)
  )
}

# ---- Reshape wide -> long for analysis --------------------------------------
# Produces one row per participant x headline, with a column per measure and an
# `arm` factor (control as reference). Generalises to any number of variants.
reshape_long <- function(d, CFG) {
  prefix   <- CFG$headline_prefix
  measures <- CFG$measures
  cond_cols <- paste0(CFG$condition_prefix, seq_len(CFG$n_headlines))
  cond_cols <- cond_cols[cond_cols %in% names(d)]

  out_pat <- sprintf("^%s[0-9]+_(%s)_1$", prefix, paste(measures, collapse = "|"))

  long <- d |>
    pivot_longer(
      cols = matches(out_pat),
      names_to = c("h", ".value"),
      names_pattern = sprintf("%s([0-9]+)_([a-z]+)_1", prefix)
    ) |>
    mutate(h = as.character(h))

  cond_long <- d |>
    select(PROLIFIC_PID, all_of(cond_cols)) |>
    pivot_longer(all_of(cond_cols), names_to = "h", values_to = "arm") |>
    mutate(h = sub(CFG$condition_prefix, "", h))

  long |>
    left_join(cond_long, by = c("PROLIFIC_PID", "h")) |>
    mutate(
      headline = factor(paste0("headline_", h)),
      arm      = relevel(factor(arm), ref = CFG$control_label)
    ) |>
    select(-h)   # drop helper key so it can't shadow loop vars named `h`
}
