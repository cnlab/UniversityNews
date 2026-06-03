library(tidyverse)
library(here)
library(patchwork)

source(here("Step2", "analysis", "config.R"))

d <- readRDS(CLEANED_RDS)

outcome_vars <- c(
  "share_direct", "share_social", "read_more",
  "govtfund_general", "govtfund_cuts", "behavior_intent",
  "climate_composite"
)

outcome_labels <- c(
  share_direct      = "Share directly",
  share_social      = "Share on social media",
  read_more         = "Want to read more",
  govtfund_general  = "Govt funding attitude (general)",
  govtfund_cuts     = "Disapprove of funding cuts",
  behavior_intent   = "Behavioral intention",
  climate_composite = "Climate beliefs (composite)"
)

# ── 1. Condition counts ────────────────────────────────────────────────────────
cat("=== Condition N ===\n")
d |> count(condition) |> print()

cat("\n=== Missing data per outcome ===\n")
d |>
  summarise(across(all_of(outcome_vars), ~sum(is.na(.)))) |>
  pivot_longer(everything(), names_to = "variable", values_to = "n_missing") |>
  print()

# ── 2. Means and SDs by condition ─────────────────────────────────────────────
cat("\n=== Means and SDs by condition ===\n")
d |>
  group_by(condition) |>
  summarise(across(
    all_of(outcome_vars),
    list(mean = ~mean(., na.rm = TRUE), sd = ~sd(., na.rm = TRUE)),
    .names = "{.col}__{.fn}"
  )) |>
  pivot_longer(-condition, names_to = c("variable", "stat"), names_sep = "__") |>
  pivot_wider(names_from = stat, values_from = value) |>
  mutate(across(c(mean, sd), ~round(., 2))) |>
  arrange(variable, condition) |>
  print(n = Inf)

# ── 3. Distributions by condition ─────────────────────────────────────────────
plots <- map(outcome_vars, function(var) {
  ggplot(d, aes(x = .data[[var]], fill = condition)) +
    geom_histogram(bins = 20, alpha = 0.7, position = "identity") +
    facet_wrap(~condition, ncol = 1) +
    scale_fill_manual(values = c(control = "#888888", relevance = "#011F5B", action = "#990000")) +
    labs(
      title = outcome_labels[[var]],
      x = NULL, y = "Count"
    ) +
    theme_minimal(base_size = 11) +
    theme(legend.position = "none")
})

walk2(plots, outcome_vars, function(p, var) {
  ggsave(
    file.path(EDA_DIR, paste0("dist_", var, ".png")),
    plot = p, width = 5, height = 6, dpi = 150
  )
})

# ── 4. Means plot across all outcomes ─────────────────────────────────────────
means_df <- d |>
  group_by(condition) |>
  summarise(across(all_of(outcome_vars), ~mean(., na.rm = TRUE))) |>
  pivot_longer(-condition, names_to = "variable", values_to = "mean") |>
  mutate(
    variable = factor(variable, levels = outcome_vars,
                      labels = outcome_labels[outcome_vars])
  )

p_means <- ggplot(means_df, aes(x = condition, y = mean, fill = condition)) +
  geom_col(width = 0.6) +
  facet_wrap(~variable, scales = "free_y", ncol = 3) +
  scale_fill_manual(values = c(control = "#888888", relevance = "#011F5B", action = "#990000")) +
  labs(x = NULL, y = "Mean", title = "Outcome means by condition") +
  theme_minimal(base_size = 10) +
  theme(legend.position = "none", axis.text.x = element_text(angle = 20, hjust = 1))

ggsave(file.path(EDA_DIR, "means_by_condition.png"), p_means,
       width = 10, height = 8, dpi = 150)

# ── 5. Correlation matrix of outcomes ─────────────────────────────────────────
cor_mat <- d |>
  select(all_of(outcome_vars)) |>
  cor(use = "pairwise.complete.obs") |>
  round(2)

cat("\n=== Outcome correlation matrix ===\n")
print(cor_mat)

# Save as a simple heatmap
cor_df <- as.data.frame(cor_mat) |>
  rownames_to_column("var1") |>
  pivot_longer(-var1, names_to = "var2", values_to = "r")

p_cor <- ggplot(cor_df, aes(x = var1, y = var2, fill = r)) +
  geom_tile() +
  geom_text(aes(label = r), size = 3) +
  scale_fill_gradient2(low = "#990000", mid = "white", high = "#011F5B",
                       midpoint = 0, limits = c(-1, 1)) +
  labs(title = "Outcome correlations", x = NULL, y = NULL) +
  theme_minimal(base_size = 10) +
  theme(axis.text.x = element_text(angle = 40, hjust = 1))

ggsave(file.path(EDA_DIR, "outcome_correlations.png"), p_cor,
       width = 7, height = 6, dpi = 150)

cat("\nEDA plots saved to", EDA_DIR, "\n")
