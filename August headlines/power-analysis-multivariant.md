# Power Analysis: Multi-Variant Headline Test

Planning notes for a follow-up to the Step 3 July Newsletter study. Design: each
participant sees multiple headlines (K = 4–6), each headline has 3–4 variants
(V), and each participant sees only one variant of a given headline. Goal: test
which variant of each headline is best at increasing self-relevance.

## Design structure

- Self-relevance outcome = 0–100 slider (same as July `relevant`).
- Each participant sees each headline once, in one variant (variant is
  **between-subjects** for a given headline; headline is within-subjects).
- Balanced variant assignment (rotation / Latin-square style) so each headline's
  variants are equally represented across participants.

## Parameters (anchored on July newsletter data, N=296)

| Component | Value |
|---|---|
| Overall SD of self-relevance | ~34 |
| Person random intercept SD | 22 (ICC = 0.40) |
| Headline random intercept SD | 10 (ICC = 0.09) |
| Residual SD | 24.6 |
| July framing effect (avg) | +1.9 pts on 0–100 |
| July per-headline effects | ranged −4.5 to +8.8 pts |

## Simulation results

Crossed design, V = 4 variants, K = 5 headlines, balanced rotation, person
random intercept. "Gap" = points by which the single best variant exceeds the
other (tied) variants. Two outcomes: correctly picking the best variant, and the
per-headline omnibus test reaching p < .05.

| Total N | Per cell (N/V) | Gap (best vs rest) | P(pick best) | P(omnibus p<.05) |
|--------:|-----:|-----:|-----:|-----:|
| 240 | 60 | 5 pts | .63 | .18 |
| 360 | 90 | 5 pts | .71 | .24 |
| 480 | 120 | 5 pts | .77 | .34 |
| 600 | 150 | 5 pts | .81 | .39 |
| 800 | 200 | 5 pts | .86 | .50 |
| 240 | 60 | 8 pts | .81 | .42 |
| 480 | 120 | 8 pts | .91 | .68 |
| 600 | 150 | 8 pts | .94 | .74 |
| 800 | 200 | 8 pts | .96 | .85 |

## How to read this

**The only quantity that drives power is participants per cell = N / V.** Each
person sees every headline once, so adding headlines (K) is nearly free — it just
gives you more independent replications of the "which variant wins" question.
Cost lives entirely in V, the number of variants, because n per cell = N/V. Going
from 4 variants to 3 buys you 33% more n per cell at the same N.

**"Pick the best" is far easier than "prove it's better."** Correctly identifying
the top variant (argmax) only needs it to land highest on average, which happens
well before the difference is significant. If you just want to rank variants and
carry the winner forward, that column is your target. If you need to defensibly
claim variant A beats B, use the omnibus column, which is much hungrier.

**The gap is the crux, and July says it's small.** The July framing rewrites
moved self-relevance +1.9 pts on average, with the best single headline at +8.8.
Variants that are all "active" rewrites (no plain control) will likely differ by
*less* than control-vs-rewrite did. Planning around a 5-point true gap is
realistic; 8 is optimistic.

## Scenario: gap = July's best significant headline (8.8 pts)

In July, only one headline moved self-relevance significantly: Article 4
("How the Media can Strengthen Our Community in Uncertain Times") at **B = +8.77,
p = .018**. The other three ranged −4.5 to +2.8 and were non-significant. If we
assume every headline has a best variant that strong (gap ≈ 8.8), K=5:

| Total N | Per cell | V | P(pick best) | P(omnibus p<.05) |
|--------:|-----:|:-:|-----:|-----:|
| 240 | 80 | 3 | .89 | .56 |
| 360 | 120 | 3 | .94 | .72 |
| 480 | 160 | 3 | .94 | .76 |
| 600 | 200 | 3 | .95 | .83 |
| 240 | 60 | 4 | .84 | .46 |
| 360 | 90 | 4 | .90 | .64 |
| 480 | 120 | 4 | .92 | .72 |
| 600 | 150 | 4 | .95 | .82 |

At this effect size, **selecting** the best variant is cheap — N ≈ 360 reaches
~90%+ regardless of V. But **confirming** it (omnibus p < .05) still wants
N ≈ 600 for 80% power.

**Caveat:** 8.8 was the single best of four July headlines and the only
significant one (average across all four was +1.9). Assuming every headline lands
an 8.8-point winner is a best-case plan, not the expected case. Treat N ≈ 360 as
a floor and N ≈ 600 as the safe target.

## Scenario: control arm + 2–3 variants

Updated design: each headline has a **control** plus 2–3 self-relevance variants.
Two comparisons of interest — (a) each variant vs control, and (b) variant vs
variant to pick the winner. Control is just another arm, so V (arms per headline)
= 1 control + (2 or 3) variants. This splits the problem into two effect sizes:

- **Lift** = variant advantage over control (July: 5–9 pts for a good rewrite).
  Powers comparison (a). The *easy* question.
- **Separation** = best variant minus runner-up. Likely smaller (2–4 pts) since
  all variants are active attempts. Powers comparison (b). The *hard* question,
  and the true sample-size driver.

Simulation: lift = 6 pts, separation = 2 or 4 pts, K = 5.

| N | Per cell | V (arms) | Sep | P(pick best variant) | P(best beats control) | P(lift-only var beats control) |
|--:|--:|:--:|--:|--:|--:|--:|
| 360 | 120 | 3 | 2 | .68 | .76 | .55 |
| 480 | 160 | 3 | 2 | .68 | .82 | .66 |
| 600 | 200 | 3 | 2 | .73 | .89 | .72 |
| 360 | 120 | 3 | 4 | .82 | .84 | .55 |
| 480 | 160 | 3 | 4 | .85 | .93 | .66 |
| 600 | 200 | 3 | 4 | .89 | .96 | .72 |
| 360 | 90 | 4 | 2 | .54 | .63 | .45 |
| 600 | 150 | 4 | 2 | .58 | .83 | .62 |
| 360 | 90 | 4 | 4 | .71 | .76 | .46 |
| 600 | 150 | 4 | 4 | .79 | .94 | .62 |

**Beating control is easy and well-powered.** A real 6-pt lift clears
significance per headline at ~80–95% by N≈480–600 (V=3). Pooling across headlines
in a mixed model makes the overall "rewrites work" claim easier still.

**Picking the best variant is hard, and separation is the binding constraint.**
At ~4-pt separation, N≈480–600 (V=3) reaches 85–89%. At ~2-pt separation you're
near 70% even at N=800 — you effectively cannot separate near-tied variants at any
realistic N. That is a practical-equivalence result, not a fixable power problem.

**A third variant is expensive.** Every row is worse at V=4 than V=3 because the
control plus an extra variant thins each cell. If selecting the winner matters
most, run **control + 2 variants**, not control + 3.

Recommendation for this design: **control + 2 variants (V=3), K=5–6, N≈480–600.**
Pre-register the two comparisons separately; the variant-vs-variant contrast is
the one that may return inconclusive.

## Recommendation (best-vs-rest framing)

If the goal is to reliably **select** the best variant per headline (80%+), plan
for ~150 per cell:

- V=4, K=5–6 → **N ≈ 600**
- V=3, K=5–6 → **N ≈ 450**

If you need statistical **confirmation** that the winner beats the field for a
5-point gap, you're looking at N=800+ and it still only clears ~50% per headline.
That pushes toward a two-stage design: a larger screening wave to rank variants
(select), then a focused confirmation wave on the 1–2 survivors per headline
(2-arm, high power).

Three levers to decide before finalizing N:

1. **V=3 vs 4** — dropping to 3 is the cheapest power gain if you can cut the
   weakest variant a priori.
2. **Select vs confirm** — changes the target N by nearly 2×.
3. **Scale** — keep the 0–100 slider (what these estimates use) vs a 7-point
   Likert, which compresses variance and shifts the numbers.

## Reproducibility

Simulation script: `August headlines/power_sim.R` (run with `Rscript`; requires
`lme4` and `dplyr`). Variance components are hardcoded at the top of the script,
originally pulled from
`Step3_JulyNewsletter/Data/july_newsletter_clean.rds` via a person + headline
random-intercept model on `relevant`.
