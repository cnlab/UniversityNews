# UniversityNews — Todo

## Prolific actions (do before next session)
- [ ] Approve 405 AWAITING REVIEW participants (origcontrol1/2 batch — 0 rejections)
- [ ] Reject — 2+ auth flags (all claudecontrol):
  - `69cf17d1a963b681aed752bc` (reCAPTCHA + bot mixed)
  - `69da76fcc8125b750510d7db` (reCAPTCHA + bot mixed)
  - `69e7ccb245d5adb5a70cf6f1` (reCAPTCHA + bot mixed)

## Analysis
- [ ] Confirm behavioral intention item labels — which loop slots (2, 3, 4) map to which behaviors
- [ ] Confirm `climate_3_1/2/3` scale anchors (assumed 7-point agree/disagree)
- [ ] Update believers section interpretation (currently a placeholder — review output and fill in)
- [ ] Decide: top up origcontrol1/2 to ~200 each to replace the 90 FL_76 slots, or keep N=153/152?

## Completed (2026-06-04)
- [x] Restructured coalesce for new separate-block format (relevance1_1_1 etc.)
- [x] Updated exclusion logic: hard exclusions + 2+ auth flag rule + flag_any_auth
- [x] Renamed article_agree_1/2 → article_self_relev / article_social_relev
- [x] Moved climate_1/2 to covariate_vars
- [x] Fixed govtfund_cuts label
- [x] Deleted stale 01_eda.R
- [x] Full EDA rewrite (Step 1 style, demographics section, means by condition in each tab)
- [x] Full analysis rewrite (tabsets, reactable, moderation section, interpretation section)
- [x] Ran cleaning + EDA + analysis on N=895 Cohort 1 sample

## Completed (2026-06-09)
- [x] Diagnosed and fixed 3 Qualtrics survey flow bugs (FL_76 in randomizer, missing condition embedded data, 3-branch randomizer)
- [x] Added condition imputation (FL_75_DO columns) for pre- and post-fix batches
- [x] Renamed "control" → "claudecontrol"; added FL_76 bug exclusion step
- [x] Updated Prolific file to UnivNews_Step2_prolific_demographic_060926.csv
- [x] Final cleaned N=1,211: origcontrol1 (153), origcontrol2 (152), claudecontrol (302), relevance (306), action (298)
- [x] Rewrote EDA + analysis scripts for 5-condition design with origcontrol1 as reference
- [x] Full interpretation rewrite: relevance positive on 5 outcomes, no backfire, claudecontrol confirmed inflated
