# University and Climate News: Evidence-Based Research Communications

A proof-of-concept initiative to identify the message frames that most effectively increase public understanding of, and support for, university research, with an emphasis on climate-related work.

**Status:** Step 0 complete. Step 1 complete (N = 300, data collected April–May 2026). Step 2 in preparation.

---

## Project Goals

This pilot has two goals:

1. **Substantive** — Identify message frames that measurably increase public support for university research.
2. **Structural** — Develop a scalable model for integrating faculty expertise, trainees, and communications professionals to strengthen the societal impact of Penn's research.

The work is designed to lay the groundwork for a broader campus-wide initiative in evidence-based research communications, with initial focus on climate research given Penn's interdisciplinary strengths and institutional priorities.

---

## Proposed Plan

| Step | Description | Timeline | Status |
|------|-------------|----------|--------|
| **Step 0** | Formative survey: open-ended beliefs and experiences with academic research and government funding | Early 2026 | ✅ Complete |
| **Step 1** | Cross-sectional survey to map public beliefs and identify attitudes most amenable to change | End of April 2026 | ✅ Complete |
| **Step 2** | A/B testing of message frames using real ASC/APPC research stories; up to 10 frames tested with ~3,000 participants | TBD | 🔄 In preparation |
| **Step 3** | Real-world deployment of top-performing frames in ASC newsletter; post-publication engagement tracking | TBD | ⏳ Pending |

---

## Step 0: Formative Survey

*[Placeholder — details to be added.]*

Step 0 was a formative survey collecting open-ended responses about people's beliefs and experiences with academic research and government funding of research. Findings informed the belief constructs and item wording used in the Step 1 survey instrument.

---

## Step 1: Cross-Sectional Survey

### What We Did

We fielded a 30-minute cross-sectional survey with **300 U.S. adults** recruited via Prolific (April–May 2026). The survey measured:

- Public understanding of how universities generate and apply knowledge
- Perceptions of the societal functions of university research
- Beliefs about the value and impact of federally funded research
- Four behavioral intentions: talking to others about funding cuts, sharing information online, contacting representatives to oppose cuts, and contacting representatives to support funding

The goal was to identify which beliefs are most strongly associated with supportive attitudes and intentions — the psychological leverage points most worth targeting in Step 2 messaging.

---

### Sample Description

| Characteristic | Value |
|---|---|
| N | 300 |
| Age | M = 37.5, SD = 12 (range 18–77) |
| Gender | 57% women, 42% men, 1% non-binary or other |
| Race/ethnicity | 65% White (any), 22% Black or African American (any), 13% other/multiracial/unlisted |
| Education | 61% bachelor's degree or higher |
| Political ideology | 45% liberal leaning, 20% moderate, 34% conservative leaning |

The sample overrepresents women and college-educated adults relative to the U.S. population, consistent with typical Prolific samples. Political ideology skews more liberal than the national average.

→ *Full descriptives:* [02_descriptives_step1_pilot.html](Code/02_descriptives_step1_pilot.html) · [.Rmd](Code/02_descriptives_step1_pilot.Rmd)

---

### Behavioral Intentions

Participants rated four behavioral intentions on a 7-point scale (1 = *Definitely will not*, 7 = *Definitely will*):

| Outcome | Mean |
|---|---|
| Talk to others about cuts | 4.77 |
| Share information online about cuts | 4.02 |
| Contact reps to support funding | 3.79 |
| Contact reps to oppose cuts | 3.54 |

Talking to others is the most commonly endorsed intention; contacting representatives is least common. The two representative-contact behaviors (oppose cuts, support funding) are highly correlated with each other (r = .81), suggesting they largely reflect the same underlying motivation. A composite of all four outcomes was used as the primary analysis target.

→ *Outcome intercorrelations and descriptives:* [03_correlations_intent.html](Code/03_correlations_intent.html) · [.Rmd](Code/03_correlations_intent.Rmd)

---

### Top Correlates of Support Intentions

The table below shows the ten beliefs most strongly correlated with the composite intent score (Spearman r, N = 300), along with correlations for each individual outcome. Full results are in `Code/03_correlations_intent.html`.

| Belief | Block | r (composite) | Oppose | Talk | Share | Support |
|---|---|---|---|---|---|---|
| Think about impact of science on daily life | Research Beliefs | .46 | .39 | .36 | .37 | .50 |
| Knowledge of funding cuts | Govt Funding | .44 | .39 | .44 | .31 | .42 |
| Benefits of university research to you personally | Univ. Perceptions | .41 | .36 | .39 | .29 | .41 |
| Research affects people you care about | Research Beliefs | .39 | .32 | .37 | .33 | .37 |
| Universities improve international relations | Univ. Perceptions | .39 | .32 | .38 | .32 | .35 |
| Universities increase compassion and tolerance | Univ. Perceptions | .38 | .33 | .37 | .33 | .34 |
| Research affects you personally | Research Beliefs | .37 | .27 | .41 | .25 | .39 |
| Approve of federal funding for university research | Govt Funding | .36 | .28 | .32 | .33 | .33 |
| Federal funding boosts the economy | Govt Funding | .36 | .25 | .35 | .28 | .39 |
| Priority: advance knowledge and benefit society | Govt Funding | .35 | .27 | .37 | .29 | .34 |

Several themes emerge: science salience (thinking about the impact of science), personal and social relevance of research, perceived benefits of universities, and economic framing of government funding are the strongest cross-outcome predictors. Correlations are modest in magnitude — consistent with attitude-behavior relationships in survey data — but directionally consistent across outcomes.

→ *Full correlation tables and plots:* [03_correlations_intent.html](Code/03_correlations_intent.html) · [.Rmd](Code/03_correlations_intent.Rmd)

---

### Promising Belief Targets

We used the [Hornik & Woolf (1999)](https://doi.org/10.1080/10410239909374661) percentage-to-gain (PTG) method to rank beliefs by their potential as messaging targets. PTG estimates how much the rate of a desired behavioral intention would increase among people who hold the desired belief position, compared to the overall rate. The analysis identified four thematic clusters of high-priority targets:

**1. Personal relevance** — Beliefs that research affects people you care about, your local community, and disadvantaged groups are the strongest and most consistent targets across all four outcomes. These beliefs are not widely held at the desired level and show the largest gains when they are. Framing research in terms of proximate personal stakes — not abstract societal benefit — appears to be the most effective lever.

**2. Science salience** — Beliefs about how often one thinks about the impact of science on daily life, and how clear it is how to apply research findings, are the top targets for motivating representative contact (the highest-effort behaviors). These suggest that making science more present and applicable in people's mental lives may be especially important for civic action.

**3. Researcher integrity** — Beliefs about whether researchers are honest about their findings and how research funds are spent consistently rank among the top targets, particularly for online sharing. This cluster suggests that trust-building narratives — addressing skepticism about research integrity — may be effective for spreading information.

**4. Government funding benefits** — Beliefs that federal funding advances important goals (job creation, competitiveness, discovery) are reliable secondary targets. These respond well to economic framing.

→ *PTG analysis:* [04_promising_beliefs.html](Code/04_promising_beliefs.html) · [.Rmd](Code/04_promising_beliefs.Rmd) · [04_ptg_interim_summary.html](Code/04_ptg_interim_summary.html) · [.Rmd](Code/04_ptg_interim_summary.Rmd)

→ *Attitude outcome:* [06_correlations_attitude.html](Code/06_correlations_attitude.html) · [07_promising_beliefs_attitude.html](Code/07_promising_beliefs_attitude.html)

→ *Intermediate outcomes (perceived benefits, costs, trust, tax relevance):* [08_promising_beliefs_intermediate.html](Code/08_promising_beliefs_intermediate.html)

---

### Belief Network

We estimated a partial correlation network across 58 belief nodes using EBIC-GLASSO regularization (N/p = 5.17, 11 communities). The network adds a layer of prioritization that PTG alone cannot provide: a high-centrality belief is embedded in the broader belief structure, so shifting it may move adjacent beliefs as well. A low-centrality belief may still have high PTG — it predicts behavior — but is unlikely to cascade.

**Personal relevance beliefs (community 3)** are both high-PTG and high-centrality: shifting them may move adjacent beliefs as well, amplifying message impact beyond the direct effect.

**Economic and tax investment beliefs (community 6)** form the most central cluster in the network. Beliefs that research boosts the economy, leads to breakthroughs, and saves lives are densely interconnected and highly influential. The "boosts economy" belief also has strong PTG for talking (11.5%) and supporting funding (9.3%), making it a candidate for both direct messaging and broader structural influence.

**Climate-related beliefs (community 2)** — importance of climate research and trust in climate scientists — are highly central and have strong PTG for talking (up to 14.6%) and sharing (up to 8.8%). This community is especially relevant for Step 2, which focuses on climate research stories.

**Researcher integrity beliefs (community 11)** — including whether taxpayer money is wasted and whether researchers are honest — have moderate centrality and strong PTG specifically for talking and sharing. Unlike the clusters above, these are unlikely to cascade through the network, but they are effective direct messaging targets, particularly for behaviors that involve spreading information to others.

→ *Network visualization and centrality tables:* [05_belief_network.html](Code/05_belief_network.html) · [.Rmd](Code/05_belief_network.Rmd)

→ *Centrality × PTG quadrant analysis:* [04_ptg_interim_summary.html](Code/04_ptg_interim_summary.html) · [.Rmd](Code/04_ptg_interim_summary.Rmd)

---

### Implications for Step 2

Combining PTG and network centrality, beliefs fall into two tiers. Tier 1 targets are both high-PTG and high-centrality — shifting them is likely to produce direct behavioral gains and may move adjacent beliefs. Tier 2 targets have strong PTG but lower centrality — effective for direct messaging but less likely to produce downstream structural change.

| Frame priority | Belief cluster | PTG strength | Centrality |
|---|---|---|---|
| **Tier 1** | Personal relevance | Highest across all outcomes | High |
| **Tier 1** | Economic framing / tax investment | Strong for talking and support | Highest in network |
| **Tier 1** | Climate-related beliefs | Strong for talking and sharing | High |
| **Tier 2** | Researcher integrity | Strong for sharing and talking | Moderate |
| **Tier 2** | Science salience | Top for representative contact | Moderate |

Step 2 will develop and test up to 10 message frames built around these clusters, applied to real climate research stories from ASC and APPC.

---

## Analysis Files

> **Note:** HTML files can be downloaded and opened in any browser. Click a filename in the `Code/` folder, then click **Download**.

| File | Description |
|------|-------------|
| `Code/04_ptg_interim_summary.html` | **Start here.** Cross-outcome summary table, top targets by outcome, and centrality × PTG prioritization |
| `Code/04_promising_beliefs.html` | Full Hornik & Woolf PTG analysis across all beliefs × 4 behavioral intentions |
| `Code/05_belief_network.html` | EBIC-GLASSO partial correlation belief network (58 nodes, 11 communities) |
| `Code/03_correlations_intent.html` | Spearman correlations, all beliefs × behavioral intentions |
| `Code/06_correlations_attitude.html` | Spearman correlations, all beliefs × attitude toward federal funding |
| `Code/07_promising_beliefs_attitude.html` | PTG analysis, beliefs × attitude outcome |
| `Code/08_promising_beliefs_intermediate.html` | PTG analysis, beliefs × intermediate outcomes (perceived benefits, costs, trust, tax relevance) |
| `Code/02_descriptives_step1_pilot.html` | Sample descriptives and open-ended responses |

---

## Repository Structure

```
UniversityNews/
├── Code/               # Analysis scripts (.Rmd) and rendered reports (.html)
├── Data/
│   ├── Raw/            # De-identified Qualtrics and Prolific exports
│   └── Cleaned/        # Combined analysis dataset (UnivNews_Step1_combined.rds)
├── Output/             # CSV outputs from each analysis script
├── SurveyDrafts/       # Survey instrument documents
└── Background/         # Supporting literature and reference materials
```

---

## Future Funding Opportunities

*[Placeholder — to be filled in.]*

---

## Team

Falk Lab, Annenberg School for Communication, University of Pennsylvania
