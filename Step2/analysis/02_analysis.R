library(tidyverse)
library(broom)
library(effectsize)
library(here)

source(here("Step2", "analysis", "config.R"))

d <- readRDS(CLEANED_RDS)

# Outcome variables and display labels
outcomes <- c(
  share_direct      = "Share directly",
  share_social      = "Share on social media",
  read_more         = "Want to read more",
  govtfund_general  = "Govt funding attitude (general)",
  govtfund_cuts     = "Disapprove of funding cuts",
  behavior_intent   = "Behavioral intention",
  climate_composite = "Climate beliefs (composite)"
)

# condition is already factored with "control" as reference (from 00_clean.R)

# ── 1. Run models ──────────────────────────────────────────────────────────────
# One lm per outcome: outcome ~ condition
# Coefficients for conditionrelevance and conditionaction are the
# contrasts vs control.

models <- map(names(outcomes), function(var) {
  formula <- as.formula(paste(var, "~ condition"))
  lm(formula, data = d)
}) |>
  set_names(names(outcomes))

# ── 2. Extract coefficients ────────────────────────────────────────────────────
results <- map_dfr(names(outcomes), function(var) {
  tidy(models[[var]], conf.int = TRUE) |>
    filter(term %in% c("conditionrelevance", "conditionaction")) |>
    mutate(
      outcome = var,
      outcome_label = outcomes[[var]],
      contrast = str_remove(term, "^condition")
    )
}) |>
  select(outcome, outcome_label, contrast, estimate, std.error,
         statistic, p.value, conf.low, conf.high) |>
  mutate(across(where(is.numeric), ~round(., 3)))

cat("=== Contrasts vs Control ===\n")
print(results, n = Inf)

# ── 3. Effect sizes (Cohen's d) ────────────────────────────────────────────────
cohens_d_results <- map_dfr(names(outcomes), function(var) {
  bind_rows(
    cohens_d(d[[var]] ~ d$condition,
             data = d |> filter(condition %in% c("control", "relevance"))) |>
      as.data.frame() |>
      mutate(outcome = var, contrast = "relevance"),
    cohens_d(d[[var]] ~ d$condition,
             data = d |> filter(condition %in% c("control", "action"))) |>
      as.data.frame() |>
      mutate(outcome = var, contrast = "action")
  )
}) |>
  select(outcome, contrast, Cohens_d, CI_low, CI_high) |>
  mutate(across(where(is.numeric), ~round(., 3)))

cat("\n=== Cohen's d ===\n")
print(cohens_d_results, n = Inf)

# ── 4. Omnibus F-tests ────────────────────────────────────────────────────────
omnibus <- map_dfr(names(outcomes), function(var) {
  glance(models[[var]]) |>
    mutate(outcome = var, outcome_label = outcomes[[var]])
}) |>
  select(outcome, outcome_label, r.squared, adj.r.squared, statistic, p.value, df, df.residual) |>
  mutate(across(where(is.numeric), ~round(., 3)))

cat("\n=== Omnibus F-tests ===\n")
print(omnibus, n = Inf)

# ── 5. Summary table ──────────────────────────────────────────────────────────
# Condition means for context
condition_means <- d |>
  group_by(condition) |>
  summarise(across(all_of(names(outcomes)), ~round(mean(., na.rm = TRUE), 2))) |>
  pivot_longer(-condition, names_to = "outcome", values_to = "mean") |>
  pivot_wider(names_from = condition, values_from = mean, names_prefix = "m_")

summary_table <- results |>
  left_join(cohens_d_results |> rename(d = Cohens_d, d_low = CI_low, d_high = CI_high),
            by = c("outcome", "contrast")) |>
  left_join(condition_means, by = "outcome")

cat("\n=== Full summary table ===\n")
print(summary_table, n = Inf)

# ── 6. Save results ────────────────────────────────────────────────────────────
results_out <- list(
  models          = models,
  contrasts       = results,
  cohens_d        = cohens_d_results,
  omnibus         = omnibus,
  summary_table   = summary_table
)

saveRDS(results_out, RESULTS_RDS)
cat("\nResults saved to", RESULTS_RDS, "\n")
