# Comms

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
