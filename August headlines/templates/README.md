# Multi-Variant Headline Study — Analysis Templates

Reusable cleaning + analysis + rejection pipeline for the follow-up to the Step 3
July Newsletter study (control + 2–3 self-relevance variants per headline). Built
so a new round of data collection is a **config-only** change.

## Files

| File | What it does |
|------|--------------|
| `config.R` | **The only file you edit.** Paths, design (headlines, measures, condition columns), and all quality/rejection thresholds. |
| `helpers.R` | Shared functions: reading data, `compute_flags()`, `reshape_long()`. Cleaning and rejection use identical flag logic. |
| `00_clean.Rmd` | Applies exclusions, reshapes, saves `output/clean.rds`. |
| `02_prolific_rejections.Rmd` | **Standalone** report: table of Prolific IDs to reject + a reason for each; writes `output/prolific_rejections.csv`. |
| `01_analysis.Rmd` | Per-headline variant-vs-control and variant-vs-variant (which wins), plus pooled mixed models. |

## Running a new round

1. Put the new Qualtrics `.csv` and Prolific `.csv` in a `Data/` folder.
2. In `config.R`, update the three paths (Section 1) and, if the survey's column
   names changed, Section 2.
3. Knit in order: `00_clean` → `02_prolific_rejections` → `01_analysis`.

Defaults point at the July data as a working example (a 2-arm special case).
Nothing in the code changes for 3–4 variants — only the values in the condition
columns.

## Rejection / exclusion rule (set in `config.R`)

A submission is rejected/excluded if **any standalone-reject flag** fires, **or**
it accumulates **2+** flags:

- `flag_bot_combined` — reCAPTCHA < 0.5 **and** Prolific bot ∈ {mixed, low}
- `flag_duplicate` — Qualtrics `Q_DuplicateRespondent == TRUE`
- `flag_auth_q` — any Prolific per-question authenticity check == "Fail"
- `flag_attention` — 2+ *seen* attention sliders wrong (unseen items never count)
- `flag_straightline` — identical value across all substantive outcome sliders (e.g. all 0, all 100)
- `flag_offtask` — off-task > 15 min (**standalone** auto-reject by default)

`CFG$standalone_reject_flags` controls which flags reject on their own. Off-task is
standalone; add `"flag_attention"` there to also auto-reject blatant attention
failures (in July that moves rejections from 0 to 32, mostly all-zero responders).

## Notes / gotchas

- **Attention scoring counts only sliders a participant actually saw.** The
  original July script treated NA as a failure, which — because block B was shown
  to only 43 people — flagged everyone and made the attention check inert. The
  corrected rule flags real failures only.
- `totalOffTask` in the Qualtrics export scales inconsistently; off-task time is
  computed from `worktimeArray` (sum of negative segments / 60), matching the WiN
  base script.
- Prolific rejections are **manual and hard to reverse** — review
  `02_prolific_rejections` output before actioning anything on Prolific.
