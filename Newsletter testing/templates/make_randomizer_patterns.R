# =============================================================================
# make_randomizer_patterns.R
# Generate the balanced condition-assignment patterns for the newsletter
# randomizer, and write them to randomizer_patterns_<K>articles.csv.
#
# Design goal: each participant sees a mix of control / self-relevant articles,
# every article splits ~50/50 across the sample, and article-to-article
# assignments are as decorrelated as possible.
#
# Method: enumerate EVERY way to choose `n_control` of the K articles to be
# control (choose(K, n_control) patterns). Assign participants evenly across
# these patterns with a single "Evenly Present Elements" randomizer in Qualtrics.
# With the full set, each article is control in exactly half the patterns and the
# article assignments are near-orthogonal.
#
# Usage:  Rscript make_randomizer_patterns.R          # defaults: K=6, 3 controls
#         Rscript make_randomizer_patterns.R 5 2       # K=5, 2 controls
# =============================================================================

args        <- commandArgs(trailingOnly = TRUE)
K           <- if (length(args) >= 1) as.integer(args[1]) else 6   # number of articles
n_control   <- if (length(args) >= 2) as.integer(args[2]) else floor(K / 2)
CONTROL     <- "control"
SELFREL     <- "selfrel"

# one pattern: control at positions `ci`, self-relevant elsewhere
mk <- function(ci) { x <- rep(SELFREL, K); x[ci] <- CONTROL; x }

# all choose(K, n_control) balanced patterns
patterns <- t(sapply(combn(K, n_control, simplify = FALSE), mk))
colnames(patterns) <- paste0("condition_", seq_len(K))

# ---- diagnostics ------------------------------------------------------------
controls_per_pattern <- rowSums(patterns == CONTROL)
control_per_article  <- colSums(patterns == CONTROL)
numeric_mat <- apply(patterns, 2, function(c) as.numeric(c == CONTROL))
pair_cor <- abs(cor(numeric_mat))
max_pair_cor <- max(pair_cor[upper.tri(pair_cor)])

cat(sprintf("K = %d articles | %d controls per participant | %d patterns\n",
            K, n_control, nrow(patterns)))
cat(sprintf("Controls per pattern: all == %d? %s\n",
            n_control, all(controls_per_pattern == n_control)))
cat(sprintf("Per-article control share: %s (of %d patterns)\n",
            paste(control_per_article, collapse = " "), nrow(patterns)))
cat(sprintf("Max |correlation| between article assignments: %.2f\n", max_pair_cor))

# ---- write CSV --------------------------------------------------------------
out <- file.path(dirname(sub("--file=", "", grep("--file=", commandArgs(FALSE),
                                                 value = TRUE)[1])),
                 sprintf("randomizer_patterns_%darticles.csv", K))
if (is.na(out) || out == "") out <- sprintf("randomizer_patterns_%darticles.csv", K)
df <- data.frame(pattern = seq_len(nrow(patterns)), patterns, check.names = FALSE)
write.csv(df, out, row.names = FALSE)
cat("Wrote", nrow(df), "patterns to", out, "\n")
