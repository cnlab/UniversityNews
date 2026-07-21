suppressMessages({library(lme4); library(dplyr)})
set.seed(42)

# Anchored on July newsletter data
PERSON_SD <- sqrt(482.6)   # person random intercept
HEAD_SD   <- sqrt(105)     # headline random intercept
RESID_SD  <- sqrt(605.2)   # residual

sim_once <- function(N, K, V, gap) {
  # gap = points by which the single BEST variant exceeds the other (tied) variants
  head_int <- rnorm(K, 0, HEAD_SD)
  # variant effects per headline: one winner at +gap, rest at 0 (centered later)
  # randomize which variant is the winner per headline
  winner <- sample(1:V, K, replace=TRUE)
  pers_int <- rnorm(N, 0, PERSON_SD)
  # balanced assignment: each person sees each headline once; variant via rotation
  # person i, headline k -> variant = ((i + k) mod V)+1  gives near-balance
  rows <- expand.grid(person=1:N, headline=1:K)
  rows$variant <- ((rows$person + rows$headline) %% V) + 1
  rows$mu <- head_int[rows$headline] + pers_int[rows$person] +
             ifelse(rows$variant == winner[rows$headline], gap, 0)
  rows$y <- rows$mu + rnorm(nrow(rows), 0, RESID_SD)
  rows$headline <- factor(rows$headline); rows$variant <- factor(rows$variant)
  rows$person <- factor(rows$person)

  m <- suppressMessages(suppressWarnings(
    lmer(y ~ headline + headline:variant + (1|person), data=rows, REML=FALSE)))
  # per-headline: estimate variant means, check if argmax == true winner,
  # and omnibus LRT that variants differ within that headline
  emm <- fixef(m)
  correct <- 0; omnibus_sig <- 0
  # refit per-headline OLS-in-mixed is heavy; use per-headline lm with person mean adj
  # Cheaper: per headline, fit lm(y ~ variant + person_mean_other) approximated:
  for (k in levels(rows$headline)) {
    sub <- rows[rows$headline==k,]
    # adjust each person's y by their mean on OTHER headlines (partial out person)
    pm <- tapply(rows$y[rows$headline!=k], rows$person[rows$headline!=k], mean)
    sub$padj <- sub$y - pm[as.character(sub$person)]
    fit <- lm(padj ~ variant, data=sub)
    est <- c(0, coef(fit)[-1]); names(est) <- levels(sub$variant)
    if (which.max(est) == winner[as.integer(k)]) correct <- correct + 1
    p <- anova(fit)$`Pr(>F)`[1]
    if (!is.na(p) && p < .05) omnibus_sig <- omnibus_sig + 1
  }
  c(prop_correct = correct/K, prop_omnibus_sig = omnibus_sig/K)
}

run <- function(N, K, V, gap, nsim=200) {
  res <- replicate(nsim, sim_once(N,K,V,gap))
  data.frame(N=N, per_cell=round(N/V), K=K, V=V, gap=gap,
             P_pick_best=round(mean(res["prop_correct",]),2),
             P_omnibus_detect=round(mean(res["prop_omnibus_sig",]),2))
}

# Main table: V=4, K=5, generic gaps of 5 and 8 points
grid <- expand.grid(N=c(240,360,480,600,800), gap=c(5,8), V=4, K=5)
out <- do.call(rbind, Map(function(N,gap,V,K) run(N,K,V,gap), grid$N,grid$gap,grid$V,grid$K))
cat("\n=== Generic gaps (V=4, K=5) ===\n"); print(out, row.names=FALSE)

# Scenario: gap = July's best significant headline (Article 4, B=+8.77), V=3 and 4
grid2 <- expand.grid(N=c(240,360,480,600,800), V=c(3,4), gap=8.8, K=5)
out2 <- do.call(rbind, Map(function(N,V,gap,K) run(N,K,V,gap), grid2$N,grid2$V,grid2$gap,grid2$K))
out2 <- out2[order(out2$V, out2$N),]
cat("\n=== July winner gap = 8.8 (V=3 and V=4, K=5) ===\n"); print(out2, row.names=FALSE)
