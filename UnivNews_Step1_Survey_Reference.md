# UniversityNews Step 1 — Survey Question Reference

*Source: Cohorts 1–3 combined (N = 300) | Generated: 2026-05-20*

---

## How to use this document

Each section corresponds to a survey block. Variable names appear in `code` format. For matrix questions the stem is shown once, followed by a table of sub-items and their variable names.

---

## 1. Research Knowledge

### `research_1`
**Scale:** None at all / A little / A moderate amount / A lot / A great deal

> How much do you, personally, know about research at colleges and universities?

---

## 2. Trust in Science

### `research_2`
**Scale:** Strongly disagree / Somewhat disagree / Neither agree nor disagree / Somewhat agree / Strongly agree

> To what extent do you agree or disagree with the following statement?
> "Scientific research methods are the best way to find truth about the world."

---

## 3. Perceived Impact of University Research

### `research_3` — Matrix (13 items)
**Scale:** Extremely negative / Somewhat negative / Neither positive nor negative / Somewhat positive / Extremely positive

**Stem:** To what extent has research at colleges and universities had a positive or negative effect on:

| Variable | Sub-item |
|---|---|
| `research_3_1` | You personally |
| `research_3_2` | People you care about |
| `research_3_3` | People in your local community |
| `research_3_4` | People in the United States |
| `research_3_5` | Students at universities |
| `research_3_6` | Scientists at universities |
| `research_3_7` | Universities themselves |
| `research_3_8` | Pharmaceutical companies |
| `research_3_9` | Technology companies |
| `research_3_10` | The military |
| `research_3_11` | The US government |
| `research_3_12` | Wealthy individuals |
| `research_3_13` | Disadvantaged individuals |

### `research_3b` — Open-ended follow-up
**Format:** Free text (minimum 200 characters)

> Please describe the positive or negative effects that academic research has had on you personally.

---

## 4. Science Engagement & Beliefs

### `research_4` — Matrix (8 items)
**Scale:** Strongly disagree / Somewhat disagree / Neither agree nor disagree / Somewhat agree / Strongly agree

**Stem:** Rate your agreement with the following statements:

| Variable | Item |
|---|---|
| `research_4_1` | I usually understand academic research findings discussed online or in the news |
| `research_4_2` | I know where to look up information about academic research |
| `research_4_3` | It is clear how to apply findings from academic research in my own life |
| `research_4_4` | I often think about the impact of academic science on my everyday life |
| `research_4_5` | The benefits of scientific research outweigh harmful results |
| `research_4_6` | Science makes our way of life change too fast *(reverse-coded; excluded from network)* |
| `research_4_7` | Because of scientific research, there will be more opportunities for the next generation |
| `research_4_8` | Even if it brings no immediate benefits, scientific research that advances the frontiers of knowledge is necessary |

---

## 5. Research Importance & Efficacy

### `research_5.1` / `research_5.2` — Paired matrix (13 research areas × 2 ratings)

**Grid format:** Respondents rate each research area on two dimensions:
- **5.1 — Importance:** Not at all important / Slightly important / Moderately important / Very important / Extremely important
- **5.2 — Likelihood:** Very unlikely / Somewhat unlikely / Neutral / Somewhat likely / Very likely *(that academic research will achieve this)*

**Stem:** Below are some types of scientific research areas and outcomes. For each, please indicate:
- How important is this outcome to you?
- How likely is it that academic research will achieve this outcome?

| Variable (5.1 / 5.2) | Research area |
|---|---|
| `research_5.1_1` / `research_5.2_1` | Advancing social science (insights into human behavior, mental health, poverty, misinformation) |
| `research_5.1_2` / `research_5.2_2` | Developing new medicines to prevent or cure diseases (cancer, heart disease, dementia) |
| `research_5.1_3` / `research_5.2_3` | Identifying the best ways to protect the environment and ensure clean air and water |
| `research_5.1_4` / `research_5.2_4` | Developing new energy technologies to make America more energy independent |
| `research_5.1_5` / `research_5.2_5` | Developing advanced technologies to drive economic growth and increase wages |
| `research_5.1_6` / `research_5.2_6` | Developing innovative manufacturing processes to boost domestic production |
| `research_5.1_7` / `research_5.2_7` | Developing new defense capabilities and national security technologies |
| `research_5.1_8` / `research_5.2_8` | Advancing artificial intelligence and machine learning |
| `research_5.1_9` / `research_5.2_9` | Exploring space to understand the solar system and broader universe |
| `research_5.1_10` / `research_5.2_10` | Improvement in education and learning systems and structures |
| `research_5.1_11` / `research_5.2_11` | Development of better public policies |
| `research_5.1_12` / `research_5.2_12` | Better understanding for individuals about how to improve their lives |
| `research_5.1_13` / `research_5.2_13` | More awareness of others' experiences and perspectives |

---

## 6. Perceived Problems with Research

### `research_6.1` / `research_6.2` — Paired matrix (11 outcomes × 2 ratings)

**Grid format:** Respondents rate each negative outcome on two dimensions:
- **6.1 — Severity:** Not at all problematic / Slightly problematic / Moderately problematic / Very problematic / Extremely problematic
- **6.2 — Likelihood:** Very unlikely / Somewhat unlikely / Neutral / Somewhat likely / Very likely *(that academic research will produce this outcome)*

**Stem:** Below are potential negative outcomes from academic research. For each, please indicate:
- How problematic is this outcome?
- How likely is it that academic research will produce this outcome?

| Variable (6.1 / 6.2) | Negative outcome |
|---|---|
| `research_6.1_1` / `research_6.2_1` | Researchers make mistakes and results are incorrect |
| `research_6.1_2` / `research_6.2_2` | Research is slow, and it takes a long time to have an impact |
| `research_6.1_3` / `research_6.2_3` | Few people are able to access or understand the results of research |
| `research_6.1_4` / `research_6.2_4` | Findings are specific to certain groups of individuals and don't apply to others |
| `research_6.1_5` / `research_6.2_5` | Studies fail to yield impactful results |
| `research_6.1_6` / `research_6.2_6` | Research is conducted inefficiently and wastes money |
| `research_6.1_7` / `research_6.2_7` | New technology resulting from research harms the general public by eliminating jobs |
| `research_6.1_8` / `research_6.2_8` | New technology resulting from research invades our privacy |
| `research_6.1_9` / `research_6.2_9` | Research can create new technology that causes widespread damage (such as nuclear weapons) |
| `research_6.1_10` / `research_6.2_10` | Research findings are misused |
| `research_6.1_11` / `research_6.2_11` | The way that results are reported is biased by news outlets |

---

## 7. Government Funding Attitudes

### `govtfund_1`
**Scale:** Strongly disapprove / Somewhat disapprove / Somewhat approve / Strongly approve

> Do you approve or disapprove of the federal government using taxpayer funds to invest in research at colleges and universities?

### `govtfund_1b` — Open-ended follow-up
**Format:** Free text (minimum 200 characters)

> Please describe your viewpoint on federal funding of academic research — why do you approve or disapprove?

### `govtfund_2`
**Format:** Forced choice (two options)

> Which statement comes closer in your view, even if neither is exactly right?

| Code | Option |
|---|---|
| 1 | Government investment in research is ESSENTIAL for scientific progress |
| 0 | Private investment will ensure that enough progress is made, even without government investment |

### `govtfund_3`
**Scale:** None at all / A little / A moderate amount / A lot / A great deal

> How much do you currently know about cuts to government funding for academic research?

---

## 8. Perceived Stakeholder Support for Government Research Funding

### `govtfund_4` — Matrix (13 items)
**Scale:** Strongly disapprove / Somewhat disapprove / Neither approve nor disapprove / Somewhat approve / Strongly approve

**Stem:** How do you think each of these groups of people feel about the government financially supporting academic research?

| Variable | Stakeholder group |
|---|---|
| `govtfund_4_1` | People who will directly benefit from the research |
| `govtfund_4_2` | Students at universities |
| `govtfund_4_3` | Scientists at universities |
| `govtfund_4_4` | The general public |
| `govtfund_4_5` | People in the military |
| `govtfund_4_6` | People who identify as liberals |
| `govtfund_4_7` | People who identify as conservatives |
| `govtfund_4_8` | People who favor minimal government spending |
| `govtfund_4_9` | Politicians |
| `govtfund_4_10` | People who don't believe in mainstream science |
| `govtfund_4_11` | Medical and mental health professionals |
| `govtfund_4_12` | Pharmaceutical companies |
| `govtfund_4_13` | Technology companies |

---

## 9. Perceived Outcomes of Government Research Funding

### `govtfund_5` — Matrix (10 items)
**Scale:** Extremely unlikely / Somewhat unlikely / Neither likely nor unlikely / Somewhat likely / Extremely likely

**Stem:** How likely is it that these things happen when the government funds academic research?

| Variable | Outcome |
|---|---|
| `govtfund_5_1` | Researchers have enough resources to explore their ideas |
| `govtfund_5_2` | Research can focus on long-term projects instead of focusing on making an immediate profit |
| `govtfund_5_3` | Exciting research is sped up |
| `govtfund_5_4` | Results will become publicly available |
| `govtfund_5_5` | Government-funded researchers are held to higher standards than privately funded work |
| `govtfund_5_6` | Money is spent on research that should have been spent on more important things |
| `govtfund_5_7` | Taxpayer money is wasted |
| `govtfund_5_8` | Research is delayed by government oversight |
| `govtfund_5_9` | Political agendas influence what research gets funded |
| `govtfund_5_10` | Researchers lie about their results to get continued funding |

---

## 10. Research Objectivity & Public Benefit Beliefs

### `gotvfund_6` — Matrix (9 items)
**Scale:** Strongly disagree / Somewhat disagree / Neither agree nor disagree / Somewhat agree / Strongly agree

**Stem:** Rate your agreement with the following statements:

| Variable | Item |
|---|---|
| `gotvfund_6_1` | If the government funds research, there should be rules to ensure that the research is done well |
| `gotvfund_6_2` | University oversight committees protect against unethical research |
| `gotvfund_6_3` | Many everyday tools are the result of academic research |
| `gotvfund_6_4` | Research at universities benefits everyone's day to day lives in ways that are difficult to see |
| `gotvfund_6_5` | University researchers are motivated primarily by profit |
| `gotvfund_6_6` | Private companies conduct research primarily to benefit the public |
| `gotvfund_6_7` | Government-funded research is more likely to be objective than research funded by private companies |
| `gotvfund_6_8` | Research funded by private companies is more likely to be biased toward results that benefit that company |
| `gotvfund_6_9` | Results of research by private companies will become publicly accessible |

---

## 11. Perceived Priorities of Government-Funded Research

### `govtfund_7` — Matrix (4 items)
**Scale:** Not a priority / Low priority / Somewhat priority / Moderate priority / High priority

**Stem:** What are the priorities of government-funded research at colleges and universities? Rate how highly prioritized you think each of the following is:

| Variable | Priority |
|---|---|
| `govtfund_7_1` | Making a profit |
| `govtfund_7_2` | Advance knowledge and benefit society |
| `govtfund_7_3` | Develop products that can be sold |
| `govtfund_7_4` | Serve the interests of the government |

---

## 12. Tax Investment in Research — Beliefs

### `govtfund_8` — Matrix (7 items)
**Scale:** Strongly disagree / Somewhat disagree / Neither agree nor disagree / Somewhat agree / Strongly agree

**Stem:** Rate your agreement with the following statements: *Investing tax dollars in academic research…*

| Variable | Completion |
|---|---|
| `govtfund_8_1` | …boosts the economy |
| `govtfund_8_2` | …improves health and saves lives |
| `govtfund_8_3` | …drives industry investment |
| `govtfund_8_4` | …makes America a leader |
| `govtfund_8_5` | …protects national security |
| `govtfund_8_6` | …leads to scientific breakthroughs |
| `govtfund_8_7` | …benefits people like you |

---

## 13. Approval of Federal Funding Cuts

### `govtfund_9` — Matrix (5 items)
**Scale:** Strongly disapprove / Somewhat disapprove / Neither approve nor disapprove / Somewhat approve / Strongly approve

**Stem:** Would you approve or disapprove if the federal government took the following actions?

| Variable | Action |
|---|---|
| `govtfund_9_1` | Cutting funding for health research |
| `govtfund_9_2` | Cutting funding for education |
| `govtfund_9_3` | Cutting funding for science |
| `govtfund_9_4` | Cutting funding for the arts |
| `govtfund_9_5` | Cutting funding for the humanities |

---

## 14. Local Impact of Funding Cuts

### `govfund_10`
**Scale:** Strong negative impact / Somewhat negative impact / Neither positive nor negative impact / Somewhat positive impact / Strong positive impact

> Do you think your local area would be positively or negatively impacted by cuts to funding for scientific research?

---

## 15. Behavioral Intentions

**Scale:** Definitely will not / Probably will not / Maybe will not / Unsure / Maybe will / Probably will / Definitely will

> How likely are you to do each of the following in the next 3 months?

| Variable | Behavior |
|---|---|
| `X1_intent` | Contact your representatives in Congress to ask them to **oppose cuts** to federal funding for research at universities |
| `X2_intent` | Talk to other people (like your friends and family) about the cuts to federal funding for scientific research |
| `X3_intent` | Share information online (including on social media) about the cuts to federal funding for scientific research |
| `X4_intent` | Contact your representatives in Congress to ask them to **support federal funding** for research at universities |

---

## 16. Past Engagement

### `past_engage_1` through `past_engage_7`
**Scale:** Never / Once or twice a year / Once or twice a month / Once or twice a week / Almost every day / Once or more per day

**Stem:** Over the past 12 months, how often have you done the following:

| Variable | Behavior |
|---|---|
| `past_engage_1` | Had conversations with friends, family, or co-workers about science-related topics (e.g., climate change, vaccination, nutrition, new technologies) |
| `past_engage_2` | Shared or commented on social media posts about scientific issues |
| `past_engage_3` | Attended public rallies or protests related to scientific issues (e.g., "Stand Up for Science", "March for Science", "Fridays for Future") |
| `past_engage_4` | Shared information online (including on social media) about the cuts to federal funding for scientific research |
| `past_engage_5` | Talked to other people (like your friends and family) about the cuts to federal funding for scientific research |
| `past_engage_6` | Contacted your representatives in Congress to ask them to oppose cuts to federal funding for research at universities |
| `past_engage_7` | Contacted your representatives in Congress to ask them to support federal funding for research at universities |

---

## 17. Higher Education Perceptions

### `highered_1` — Matrix (3 items)
**Scale:** Strongly disapprove / Somewhat disapprove / Neutral / Somewhat approve / Strongly approve

**Stem:** Overall, how much do you approve or disapprove of:

| Variable | Institution |
|---|---|
| `highered_1_1` | Private colleges and universities in the United States |
| `highered_1_2` | Your state's public university system |
| `highered_1_3` | Your local community college(s) |

### `highered_2` — Matrix (3 items)
**Scale:** None at all / A little / A moderate amount / A lot / A great deal

**Stem:** How much do you trust each type of institution to do what is right?

| Variable | Institution |
|---|---|
| `highered_2_1` | Private colleges and universities in the United States |
| `highered_2_2` | Your state's public university system |
| `highered_2_3` | Your local community college(s) |

### `highered_3` — Matrix (6 items)
**Scale:** None at all / A little / A moderate amount / A lot / A great deal

**Stem:** How much do each of the following contribute to scientific achievements in the US?

| Variable | Institution |
|---|---|
| `highered_3_1` | Private colleges and universities |
| `highered_3_2` | Private companies (pharmaceutical companies, technology companies) |
| `highered_3_3` | Federal government agencies |
| `highered_3_4` | Charitable foundations |
| `highered_3_5` | State colleges and universities |
| `highered_3_6` | Community colleges |

### `highered_4` — Matrix (6 items)
**Scale:** None / Less than half / About half / Most / All

**Stem:** What proportion of each type of institution do you think is nonprofit?

| Variable | Institution |
|---|---|
| `highered_4_1` | Private colleges and universities |
| `highered_4_2` | Public state colleges and universities |
| `highered_4_3` | Community colleges |
| `highered_4_4` | Private companies (e.g., pharmaceutical and tech companies) |
| `highered_4_5` | Federal government agencies |
| `highered_4_6` | Charitable foundations |

---

## 18. University Contributions to Society

### `univ_2` — Matrix (10 items)
**Scale:** Strongly disagree / Somewhat disagree / Neither agree nor disagree / Somewhat agree / Strongly agree

**Stem:** To what extent do you agree or disagree that colleges and universities contribute to each of the following outcomes in the US?

| Variable | Outcome |
|---|---|
| `univ_2_1` | Greater innovation, including new scientific, medical, and technological discoveries |
| `univ_2_2` | Better jobs, promotions, and career advancements |
| `univ_2_3` | Higher household incomes |
| `univ_2_4` | A more knowledgeable population |
| `univ_2_5` | A competitive advantage for the US over other countries |
| `univ_2_6` | More entrepreneurship and business creation |
| `univ_2_7` | Increased compassion for, and tolerance of, others |
| `univ_2_8` | Overall economic growth |
| `univ_2_9` | Better relationships with other countries |
| `univ_2_10` | Benefits to surrounding communities |

### `univ_4` — Matrix (3 items)
**Scale:** Strongly disagree / Somewhat disagree / Neither agree nor disagree / Somewhat agree / Strongly agree

**Stem:** Do you agree or disagree that colleges and universities:

| Variable | Item |
|---|---|
| `univ_4_1` | Discover new knowledge through original research |
| `univ_4_2` | Apply existing knowledge and connect ideas across contexts and disciplines |
| `univ_4_3` | Apply knowledge-based solutions to society's needs |

### `univ_5` — Matrix (7 items)
**Scale:** None at all / A little / A moderate amount / A lot / A great deal

**Stem:** How much do each of the following people benefit from colleges and universities?

| Variable | Beneficiary |
|---|---|
| `univ_5_1` | You personally |
| `univ_5_2` | People you care about |
| `univ_5_3` | Local communities |
| `univ_5_4` | Students who attend |
| `univ_5_5` | Students' families |
| `univ_5_6` | Employers and businesses |
| `univ_5_7` | Society as a whole |

### `univ_affiliate`
**Format:** Multi-select

> Are you currently affiliated with a college or university? Select all that apply.

---

## 19. Climate Beliefs

### `climate_1`
**Format:** Yes / No

> Do you think global warming is happening?

### `climate_2`
**Format:** Multiple choice

> Assuming global warming is happening, do you think it is…

| Code | Option |
|---|---|
| 1 | Caused mostly by human activities |
| 0 | Caused mostly by natural changes in the environment (or other non-human option) |

### `climate_3`
**Scale:** Not at all / Slightly / Moderately / Very strongly

> To what extent do you trust scientists who work on climate change?

### `climate_4` — Matrix (4 items)
**Scale:** Not at all important / Slightly important / Moderately important / Very important / Extremely important

**Stem:** How important do you think it is for colleges and universities to do research on the following climate-related topics?

| Variable | Topic |
|---|---|
| `climate_4_1` | Climate science and earth systems (such as tracking greenhouse gases, studying rising sea levels, and understanding past climate cycles) |
| `climate_4_2` | Climate mitigation approaches ("fixes" such as renewable energy, carbon capture, and sustainable agriculture) |
| `climate_4_3` | Climate adaptation and resilience ("adjustments" such as urban infrastructure, carbon-smart crops, and ecosystem management) |
| `climate_4_4` | Climate policy, economics, and human impact (such as environmental justice, climate finance, and psychology and communication) |

---

## 20. Demographics & Background

### `gender`
**Format:** Multiple choice (select one)

> Which best describes your gender identity?
*(Options include self-describe; free text captured in `gender_8_TEXT`)*

### `LGBTQ`
**Format:** Yes / No

> Do you identify as part of the LGBTQIA+ community?

### `race`
**Format:** Multi-select

> What race/ethnicity or races/ethnicities do you consider yourself to be?
*(Self-describe option in `race_self`)*

### `ses_degree`
**Format:** Multiple choice

> What is the highest degree or level of school you have completed? If currently enrolled, indicate highest degree completed.

### `ses_income_household`
**Format:** Multiple choice (income brackets)

> Which of these categories best describes your total combined household income for the past 12 months? (Before taxes, all sources)

### `ses_subjective_1` through `ses_subjective_10`
**Format:** Ladder scale (click a rung; `ses_ladder` derived variable = 1–10)

> Think of this ladder as representing where people stand in the United States. At the top are people with the most money, education, and respected jobs. At the bottom are people with the least.
> Relative to other people your age in the United States right now, where would you place yourself on this ladder?

### `politics_ideology`
**Format:** 7-point scale (Extremely liberal → Extremely conservative)

> Where would you place yourself on the political ideology scale?

### `urbanicity`
**Format:** Multiple choice

> Which of the following best describes the area where you live?

### `zipcode`
**Format:** Open text

> What is your zip code?

---

## 21. Attention Checks *(not scored in analysis)*

| Variable | Question | Correct answer |
|---|---|---|
| `attention_1` | Please select "Somewhat agree" below if you are paying attention. | Somewhat agree |
| `attention_2` | Please select "Disagree" below if you are paying attention. | Disagree |
| `attention_3` | Please select "Somewhat disagree" below if you are paying attention. | Somewhat disagree |

*Participants flagged (`flag_attn = TRUE`) only if they failed **all three** checks.*

---

## 22. Open-ended Feedback

### `end_feedback`
> Please type below any comments or suggestions you might have for the research team.
