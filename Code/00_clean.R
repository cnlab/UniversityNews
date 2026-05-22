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
    flag_recaptcha  = as.numeric(Q_RecaptchaScore) < 0.5,
    flag_bot        = prolific_check_bot == "mixed",
    flag_attn       = attention_1 != "Somewhat agree" &
                      attention_2 != "Disagree" &
                      attention_3 != "Somewhat disagree",
    flag_offtask    = off_task_min > 15,
    n_flags         = flag_recaptcha + flag_bot + flag_attn + flag_offtask,
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

# ---- save ----------------------------------------------------------------

saveRDS(data, sprintf("%s/Data/Cleaned/UnivNews_Step1_combined.rds", path))

cat("Saved:", nrow(data), "participants (cohort 1 =",
    sum(data$cohort == 1), ", cohort 2 =", sum(data$cohort == 2),
    ", cohort 3 =", sum(data$cohort == 3), ")\n")
cat("Columns:", ncol(data), "\n")
cat("flag_recaptcha:", sum(data$flag_recaptcha, na.rm = TRUE), "\n")
cat("flag_bot:", sum(data$flag_bot, na.rm = TRUE), "\n")
cat("flag_attn (all 3 failed):", sum(data$flag_attn, na.rm = TRUE), "\n")
cat("flag_offtask (>15 min):", sum(data$flag_offtask, na.rm = TRUE), "\n")
cat("flag_any (2+ flags):", sum(data$flag_any, na.rm = TRUE), "\n")
