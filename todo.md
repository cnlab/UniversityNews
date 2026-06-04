# UniversityNews — Todo

## Prolific actions (do before next session)
- [ ] Approve on Prolific — missing completion code (data valid):
  - `69d7bcec0d1f7e101d5e5013`
  - `5c309bb410677f0001dda0ed`
- [ ] Do NOT approve — incomplete (40% progress, no data):
  - `6a1f8232ff8838320bad8997`
  - `6a1f2fd53bf12f4cee457754`
- [ ] Reject on Prolific — 2+ auth flags:
  - `69cf17d1a963b681aed752bc` (reCAPTCHA + bot mixed)
  - `69da76fcc8125b750510d7db` (reCAPTCHA + bot mixed)
  - `69d3c90bc7bc3c12fd6d3d26` (reCAPTCHA + off-task)
  - `6a20d4cfb34a97243d116fb3` (reCAPTCHA + off-task)
  - `69e7ccb245d5adb5a70cf6f1` (reCAPTCHA + bot mixed)

## Analysis
- [ ] Confirm behavioral intention item labels — which loop slots (2, 3, 4) map to which behaviors
- [ ] Confirm `climate_3_1/2/3` scale anchors (assumed 7-point agree/disagree)
- [ ] Decide next steps given null/backfire results — new stimuli, pre-registration revision, write-up?

## Completed this session (2026-06-04)
- [x] Restructured coalesce for new separate-block format (relevance1_1_1 etc.)
- [x] Updated exclusion logic: hard exclusions + 2+ auth flag rule + flag_any_auth
- [x] Renamed article_agree_1/2 → article_self_relev / article_social_relev
- [x] Moved climate_1/2 to covariate_vars
- [x] Fixed govtfund_cuts label
- [x] Deleted stale 01_eda.R
- [x] Full EDA rewrite (Step 1 style, demographics section, means by condition in each tab)
- [x] Full analysis rewrite (tabsets, reactable, moderation section, interpretation section)
- [x] Ran cleaning + EDA + analysis on N=895 Cohort 1 sample
