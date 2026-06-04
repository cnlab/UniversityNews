# Current State — 2026-06-04

## What we were working on
Step 2 Cohort 1 data cleaning, EDA, and analysis. Full pipeline from raw Qualtrics/Prolific data to cleaned RDS (N=895) and interpreted results.

## Where we stopped
Analysis complete and interpreted. All three scripts (00_clean, 01_eda, 02_analysis) knit cleanly. Results saved to `step2_results.rds`. Session ended before deciding next steps given the null/backfire pattern.

## What's next (ordered by priority)
1. **Prolific actions** — approve 2, reject 5, do not approve 2 (see todo.md for PIDs)
2. **Confirm two label questions:**
   - Behavioral intention items: which loop slots 2/3/4 map to which behaviors
   - climate_3_1/2/3 scale anchors (assumed 7-point agree/disagree, unconfirmed)
3. **Decide direction** — given that no variant outperformed control, discuss whether to revise stimuli, update pre-registration, or move toward write-up

## Key results
- **Action frame backfires** on engagement: read_more (B=−7.8, p=.001, d=−0.27), self-relevance (B=−0.36, p=.010), social relevance (B=−0.28, p=.034), share directly (marginal)
- **Relevance frame is null** across all 13 outcomes
- **No variant outperformed control** on any outcome (30 positive Bs, 0 significant)
- **Variant heterogeneity**: action1 drives most backfire; action2 looks like control; relevance3 mildly backfires; relevance1 is the best relevance variant (marginal positive on 1 item)
- **No demographic moderation**: 130 interaction tests, 0 survive FDR correction
- **Theoretical read**: backfire driven by implied obligation, not relevance-vs-action distinction per se

## Blockers / non-obvious context
- `fetch_survey` must use `label=FALSE`; attention check comparison uses numeric code `4` (= "Somewhat agree") not text
- Cleaned CSV saved with `write_csv` breaks `read_survey` — always use API (`USE_API=TRUE` in config.R) or the original Qualtrics export format
- `COHORT1_START` in config.R is `2026-06-04 00:00:00 ET` — filters out 30 pilot responses from June 3
- Prolific export has `DATA_EXPIRED` for ~85 student status rows and ~83 employment status rows (normal for older accounts)

## Key files touched this session
- `Step2/analysis/config.R` — COHORT1_START, LOCAL_DATA_PATH, PROLIFIC_EXPORT path
- `Step2/analysis/00_clean.Rmd` — exclusions, coalesce, flags, variable renames
- `Step2/analysis/01_eda.Rmd` — full rewrite (Step 1 style)
- `Step2/analysis/02_analysis.Rmd` — full rewrite + moderation + interpretation
- `Step2/analysis/step2_clean.rds` — cleaned data, N=895
- `Step2/analysis/step2_results.rds` — model results, cohens d, variant tests, moderation
- `Data/Raw/UnivNews_Step2_Cohort1.csv` — raw Qualtrics export (untracked)
- `Data/Raw/UnivNews_Step2_prolific_demographic.csv` — Prolific demographic export (untracked)
