# Comms

## Log Off — 2026-06-09

**Session summary:** Diagnosed and fixed Qualtrics survey flow bugs that were losing ~90 origcontrol participants, collected and cleaned new origcontrol1/2 data, renamed old control to claudecontrol, and rewrote the full analysis pipeline for the corrected 5-condition design. Results reversed: relevance frame is now reliably positive; no backfire; the prior backfire was an artifact of an inflated claudecontrol baseline.

**Completed:**
- Fixed 3 Qualtrics flow bugs; added condition imputation step to cleaning script
- Cleaned dataset: N=1,211 (origcontrol1=153, origcontrol2=152, claudecontrol=302, relevance=306, action=298)
- Identified 3 rejections (claudecontrol, reCAPTCHA + bot mixed); cleared 405 AWAITING REVIEW (0 rejections)
- Full pipeline rewrite: config.R, 00_clean, 01_eda, 02_analysis — all re-rendered
- Interpretation updated: relevance positive on 5 outcomes (d ≈ 0.25–0.31), action positive on sharing, conservative-concentrated effects, claudecontrol confirmed ~0.3–0.4d inflated

**Decisions:**
- "control" → "claudecontrol" (kept as comparison condition, not dropped)
- origcontrol1 is the reference level
- origcontrol (FL_76 bug, no article) excluded at cleaning stage
- Condition imputation uses FL_75_DO columns

**Next session should start with:**
- Prolific actions: approve 405 AWAITING REVIEW, reject 3 (see todo.md for PIDs)
- Decide whether to top up origcontrol1/2 to replace the 90 FL_76 slots
- Update believers section interpretation after reviewing output

## Log Off — 2026-06-04

**Session summary:** Full cleaning, EDA, and analysis pipeline built and run on Step 2 Cohort 1 (N=895). Results show action-frame backfire on engagement outcomes; relevance frame null across the board; no moderation by demographics.

**Completed:**
- Cohort 1 data pipeline (fetch, exclusions, cleaning, N=895 confirmed)
- EDA and analysis scripts fully rewritten to Step 1 style with interpretation
- Identified 9 Prolific participants requiring manual action (see todo.md)

**Decisions:**
- Off-task time is informational only (not an exclusion criterion)
- Prolific bot N/A is not flagged
- climate_1/2 are covariates, not outcomes
- API fetch uses label=FALSE; attention check comparison uses numeric code 4

**Next session should start with:**
- Handle the 9 Prolific participant actions (todo.md)
- Confirm behavioral intention item labels and climate_3 scale anchors
- Discuss next steps given null/backfire results
