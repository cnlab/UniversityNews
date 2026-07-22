# August Newsletter Study — Analysis Templates

Cleaning + analysis + rejection pipeline for the August Newsletter study
(`UnivNews_NewsletterTemplate`): **6 articles, each control vs one self-relevant
variant**, balanced so every participant sees a mix (3 controls / 3 self-relevant).
Config-driven, so a new round of data collection is a **config-only** change. Built
on the July Newsletter code.

## Files

| File | What it does |
|------|--------------|
| `config.R` | **The only file you edit.** Paths, design (articles, measures, condition columns, research items), and all quality/rejection thresholds. |
| `helpers.R` | Shared functions: reading data, `compute_flags()`, `reshape_long()`. Cleaning and rejection use identical flag logic. |
| `00_clean.Rmd` | Applies exclusions, reshapes, saves the cleaned `.rds`. |
| `01_prolific_rejections.Rmd` | **Standalone** report: table of Prolific IDs to reject + a reason for each; writes a rejection CSV. |
| `02_analysis.Rmd` | Manipulation checks (self-relevant vs control per article + overall MLM, for relevance / read / share) and impact of perceived self-relevance on engagement and research attitudes. Modeled on the July analysis. |
| `make_randomizer_patterns.R` | Generates the balanced condition-assignment patterns for the Qualtrics randomizer. `Rscript make_randomizer_patterns.R [K] [n_control]` (defaults K=6, 3 controls) → `randomizer_patterns_<K>articles.csv`. |

## Running a round

1. Put the fielded Qualtrics `.csv` and Prolific `.csv` in `August headlines/Data/`.
2. In `config.R` Section 1, update the two file names.
3. Knit in order: `00_clean` → `01_prolific_rejections` → `02_analysis`.

The condition columns (`condition_1`–`condition_6`) must hold `control` /
`selfrel` (control is the reference for every article). 

## Rejection / exclusion rule (set in `config.R`)

A submission is rejected/excluded if **any standalone-reject flag** fires, **or**
it accumulates **2+** flags:

- `flag_bot_combined` — reCAPTCHA < 0.5 **and** Prolific bot ∈ {mixed, low} 
- `flag_duplicate` — Qualtrics `Q_DuplicateRespondent == TRUE`
- `flag_auth_q` — any Prolific per-question authenticity check == "Fail"
- `flag_attention` — 2+ *seen* attention sliders wrong (unseen items never count)
- `flag_straightline` — identical value across all substantive outcome sliders (e.g. all 0, all 100)
- `flag_offtask` — off-task > 15 min

`CFG$standalone_reject_flags` controls which flags reject on their own. 

## Notes / gotchas

- Attention scoring counts only sliders a participant actually saw.
- `totalOffTask` in the Qualtrics export scales inconsistently; off-task time is
  computed from `worktimeArray` (sum of negative segments / 60), matching the WiN
  base script.
- Prolific rejections are **manual and hard to reverse** — review
  `02_prolific_rejections` output before actioning anything on Prolific.
