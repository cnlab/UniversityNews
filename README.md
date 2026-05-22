# UniversityNews: Evidence-Based Research Communications

A six-month proof-of-concept initiative to identify the message frames that most effectively increase public understanding of, and support for, university research.

**Status:** Step 1 complete (N = 300, data collected April 2026). Step 2 in preparation.

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
| **Step 1** | Cross-sectional survey to map public beliefs and identify attitudes most amenable to change | End of April 2026 | ✅ Complete |
| **Step 2** | A/B testing of message frames using real ASC/APPC research stories; up to 10 frames tested with ~3,000 participants | End of May 2026 | 🔄 In preparation |
| **Step 3** | Real-world deployment of top-performing frames in ASC newsletter; post-publication engagement tracking | June–August 2026 | ⏳ Pending |

---

## Step 1: What We Did

We fielded a 20-minute cross-sectional survey with **300 U.S. adults** recruited via Prolific (April 2026). The survey measured:

- Public understanding of how universities generate and apply knowledge
- Perceptions of the societal functions of university research
- Beliefs about the value and impact of federally funded research
- Four behavioral intentions: talking to others about funding cuts, sharing information online, contacting representatives to oppose cuts, and contacting representatives to support funding

The goal was to identify which beliefs are most strongly associated with supportive attitudes and intentions — that is, the psychological leverage points most worth targeting in Step 2 messaging.

---

## Step 1: What We Found

### Promising belief targets

We used the [Hornik & Woolf (1999)](https://doi.org/10.1080/10410239909374661) percentage-to-gain (PTG) method to rank beliefs by their potential as messaging targets. A high PTG belief is one where (a) most people do not currently hold the desired position, and (b) those who do are substantially more likely to report supportive intentions. The analysis identified four thematic clusters of high-priority targets:

**1. Personal relevance** — Beliefs that research affects people you care about, your local community, and disadvantaged groups are the strongest and most consistent targets across all four outcomes. These beliefs are not widely held at the desired level and show the largest gains when they are. Framing research in terms of proximate personal stakes — not abstract societal benefit — appears to be the most effective lever.

**2. Science salience** — Beliefs about how often one thinks about the impact of science on daily life, and how clear it is how to apply research findings, are the top targets for motivating representative contact (the highest-effort behaviors). These suggest that making science more present and applicable in people's mental lives may be especially important for civic action.

**3. Researcher integrity** — Beliefs about whether researchers are honest about their findings and how research funds are spent consistently rank among the top targets, particularly for online sharing. This cluster suggests that trust-building narratives — addressing skepticism about research integrity — may be effective for spreading information.

**4. Government funding benefits** — Beliefs that federal funding advances important goals (job creation, competitiveness, discovery) are reliable secondary targets. These respond well to economic framing.

The full ranked analysis, with percentage-to-gain estimates and lower bounds for all beliefs × outcomes, is in the analysis files below.

### Belief network

We estimated a partial correlation network across 58 belief nodes using EBIC-GLASSO regularization (N/p = 5.17, 11 communities). The network identifies which beliefs are most structurally central — connected to many other influential beliefs — and therefore most likely to produce downstream effects if shifted.

Personal relevance beliefs (community 3) are both high-PTG and high-centrality: shifting them may move adjacent beliefs as well, amplifying message impact beyond the direct effect.

### Implications for Step 2 framing

| Frame priority | Belief cluster | Rationale |
|---|---|---|
| **Tier 1 — lead frames** | Personal relevance | Highest PTG across all outcomes; high network centrality |
| **Tier 1 — lead frames** | Science salience | Top targets for representative contact; high centrality |
| **Tier 2 — supporting frames** | Researcher integrity | Strong for sharing; addresses trust skepticism |
| **Tier 2 — supporting frames** | Govt funding benefits | Reliable secondary effect; economic framing |

Step 2 will develop and test up to 10 message frames built around these clusters, applied to real climate research stories from ASC and APPC.

---

## Analysis Files

> **Note:** HTML files can be downloaded and opened in any browser. Click a filename in the `Code/` folder, then click **Download**.

| File | Description |
|------|-------------|
| `Code/04_ptg_interim_summary.html` | **Start here.** Cross-outcome summary table, top targets by outcome, and centrality × PTG prioritization — the main deliverable for Step 1 |
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

## Team

Falk Lab, Annenberg School for Communication, University of Pennsylvania
