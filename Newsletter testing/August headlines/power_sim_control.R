suppressMessages({library(dplyr)})
set.seed(42)
PERSON_SD <- sqrt(482.6); HEAD_SD <- sqrt(105); RESID_SD <- sqrt(605.2)

# V = total arms = 1 control + (V-1) variants.
# control = 0; non-best variants = +lift; best variant = +lift+sep.
sim_once <- function(N, K, V, lift, sep) {
  nvar <- V - 1                       # number of active variants
  head_int <- rnorm(K,0,HEAD_SD)
  best <- sample(1:nvar, K, replace=TRUE)  # which variant is truly best, per headline
  pers_int <- rnorm(N,0,PERSON_SD)
  rows <- expand.grid(person=1:N, headline=1:K)
  rows$arm <- ((rows$person + rows$headline) %% V) + 1   # arm 1 = control
  eff <- function(h, arm) {
    if (arm==1) return(0)
    v <- arm-1
    lift + ifelse(v==best[h], sep, 0)
  }
  rows$mu <- head_int[rows$headline] + pers_int[rows$person] +
             mapply(eff, rows$headline, rows$arm)
  rows$y <- rows$mu + rnorm(nrow(rows),0,RESID_SD)
  pick<-0; best_ctrl<-0; lift_ctrl<-0
  for (k in 1:K) {
    sub <- rows[rows$headline==k,]
    pm <- tapply(rows$y[rows$headline!=k], rows$person[rows$headline!=k], mean)
    sub$padj <- sub$y - pm[as.character(sub$person)]
    means <- tapply(sub$padj, sub$arm, mean)
    ctrl_mean <- means["1"]
    var_means <- means[as.character(2:V)]
    # pick best among ACTIVE variants
    if (which.max(var_means) == best[k]) pick <- pick+1
    # sig test: best variant vs control (two-sample t on padj)
    barm <- best[k]+1
    tb <- t.test(sub$padj[sub$arm==barm], sub$padj[sub$arm==1])
    if (tb$p.value<.05 & diff(rev(tb$estimate))>0) best_ctrl<-best_ctrl+1
    # a lift-only variant (first non-best) vs control
    lonly <- setdiff(2:V, barm)[1]
    tl <- t.test(sub$padj[sub$arm==lonly], sub$padj[sub$arm==1])
    if (tl$p.value<.05 & diff(rev(tl$estimate))>0) lift_ctrl<-lift_ctrl+1
  }
  c(pick=pick/K, best_ctrl=best_ctrl/K, lift_ctrl=lift_ctrl/K)
}
run <- function(N,K,V,lift,sep,nsim=200){
  r<-replicate(nsim,sim_once(N,K,V,lift,sep))
  data.frame(N,per_cell=round(N/V),V,lift,sep,
    P_pick_best_variant=round(mean(r["pick",]),2),
    P_best_beats_ctrl=round(mean(r["best_ctrl",]),2),
    P_liftvar_beats_ctrl=round(mean(r["lift_ctrl",]),2))
}
grid <- expand.grid(N=c(360,480,600,800), V=c(3,4), sep=c(2,4))
out <- do.call(rbind, Map(function(N,V,sep) run(N,5,V,6,sep), grid$N,grid$V,grid$sep))
out <- out[order(out$V,out$sep,out$N),]
print(out, row.names=FALSE)
