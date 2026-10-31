# Marketing Campaign Performance Analysis with SQL

Using SQL, I analysed a marketing campaign dataset of 200,005 campaigns to answer questions about campaign reach, return on investment (ROI), audience engagement, click-through rate (CTR), cost efficiency and channel performance. I wrote 8 queries covering aggregation, sorting, filtering, calculated metrics and window functions.

## Table of Contents

- [Introduction](#introduction)
- [How to Explore This Project](#how-to-explore-this-project)
- [Data Overview and Dataset Structure](#data-overview-and-dataset-structure)
- [SQL Queries and Analysis](#sql-queries-and-analysis)
- [Key Findings](#key-findings)
- [Recommendations](#recommendations)
- [Limitations](#limitations)
- [Skills Demonstrated](#skills-demonstrated)
- [Repository Structure](#repository-structure)

## Introduction

Companies spend heavily on online advertising across channels such as Google Ads, email, social media and video. Not every campaign pays off: some earn strong engagement and returns, while others waste budget. Reading campaign data well helps marketers decide where to spend, who to target and which channels to invest in.

This project uses SQL to turn a campaign dataset into answers to practical questions. The analysis aims to:

- Check the reach of each campaign through impressions.
- Find the campaign with the highest ROI.
- Find the locations with the most impressions.
- Compare engagement across target audiences.
- Measure the overall click-through rate and find campaigns with a strong CTR.
- Find the most cost-effective campaign.
- Rank marketing channels by estimated conversions.

## How to Explore This Project

- **Quick look:** see the query screenshots in [SQL Queries and Analysis](#sql-queries-and-analysis).
- **PDF:** [Download the analysis as PDF](Marketing%20Campaign%20Performance.pdf)
- **Walkthrough:** [Watch the query demo on Loom](TODO-your-loom-link)
- **Full script:** download [`SQL Queries.zip`](SQL%20Queries.zip), which holds the 8 query files (`1.sql` to `8.sql`).
- **Run it yourself:** load the dataset into a table called `campaigndata` in TODO-your-database (for example PostgreSQL or MySQL), then run each query file in a SQL client such as pgAdmin, DBeaver or MySQL Workbench.

## Data Overview and Dataset Structure

The analysis uses one table, `campaigndata`, with **200,005 rows**. Each row is a single marketing campaign, and `Campaign_ID` is the primary key. The data has no missing values. It covers 5 companies, 6 channels, 5 target audiences and 5 locations.

| Group | Column | Description |
|---|---|---|
| Campaign details | Campaign_ID | Unique identifier for each campaign (primary key) |
| | Company | Company running the campaign |
| | Campaign_Type | Type of campaign, such as Email, Display or Influencer |
| | Target_Audience | Demographic group the campaign was aimed at |
| | Duration | Length of the campaign, for example "30 days" |
| | Channel_Used | Platform used: Email, Website, Google Ads, YouTube, Instagram or Facebook |
| | Date | Date of the campaign |
| | Customer_Segment | Customer interest group, such as Health & Wellness |
| Performance | Impressions | Number of times the ad was displayed (1,000 to 10,000) |
| | Clicks | Number of times users clicked the ad (100 to 1,000) |
| | Engagement_Score | Score from 1 to 10 for user interaction |
| | Conversion_Rate | Share of clicks that led to the desired action, stored as a fraction (0.01 to 0.15) |
| Financial | Acquisition_Cost | Cost of acquiring customers through the campaign (5,000 to 20,000) |
| | ROI | Return on investment of the campaign (2.0 to 8.0) |
| Geographic | Location | Region the campaign was aimed at |

## SQL Queries and Analysis

### 1. Total Impressions for Each Campaign

**Method:** `SUM` and `GROUP BY` to total the impressions for each campaign and sort them from highest to lowest.

```sql
SELECT campaign_id,
       SUM(impressions) AS totalimpressions
FROM campaigndata
GROUP BY campaign_id
ORDER BY totalimpressions DESC;
```

**Screenshot:**

![Query 1: total impressions for each campaign](images/q01_total_impressions.png)

**Result:** The campaigns at the top of the list each have 10,000 impressions, which is the highest value in the data. Across all 200,005 campaigns, impressions range from 1,000 to 10,000, with an average of about 5,500.

**Insight:** Because `Campaign_ID` is unique, this query lists each campaign's own impressions. Impressions only show reach, so they can't tell strong campaigns from weak ones. Clicks, conversions and ROI are needed for that.

### 2. Campaign with the Highest ROI

**Method:** `ORDER BY ... DESC` with `LIMIT 1` to find the campaign with the best return on investment.

```sql
SELECT Campaign_ID,
       Company,
       ROI
FROM campaigndata
ORDER BY ROI DESC
LIMIT 1;
```

**Screenshot:**

![Query 2: campaign with the highest ROI](images/q02_highest_roi.png)

**Result:** Campaign 168 from NexGen Systems is returned, with an ROI of 8.0.

**Insight:** The highest ROI in the data is 8.0, but **160 campaigns share it**, so campaign 168 is the first of many ties and not a clear winner. `LIMIT 1` hides ties, so a better question is what the 160 top campaigns have in common. Among them, NexGen Systems has the most (38), followed by Innovate Industries (33) and TechCorp (31).

### 3. Top 3 Locations by Impressions

**Method:** `SUM`, `GROUP BY` and `LIMIT 3` to total impressions for each location and keep the top three.

```sql
SELECT Location,
       SUM(Impressions) AS TotalImpressions
FROM campaigndata
GROUP BY Location
ORDER BY TotalImpressions DESC
LIMIT 3;
```

**Screenshot:**

![Query 3: top 3 locations by impressions](images/q03_top_locations.png)

**Result:**

| Rank | Location | Total impressions |
|---|---|---|
| 1 | New York | 221,359,756 |
| 2 | Miami | 221,347,726 |
| 3 | Chicago | 219,999,352 |

**Insight:** The gap between the locations is tiny. Each of the five locations ran about 40,000 campaigns, and New York leads Los Angeles, the fourth-ranked location, by under 1%. Total impressions here mostly reflect how many campaigns ran in each place, so no location clearly stands out.

### 4. Average Engagement Score by Target Audience

**Method:** `AVG` and `GROUP BY` to compare engagement across audiences.

```sql
SELECT target_audience,
       AVG(engagement_score) AS avgengagementscore
FROM campaigndata
GROUP BY target_audience
ORDER BY avgengagementscore DESC;
```

**Screenshot:**

![Query 4: average engagement score by target audience](images/q04_engagement_by_audience.png)

**Result:**

| Target audience | Average engagement score |
|---|---|
| Men 18-24 | 5.52 |
| Women 25-34 | 5.49 |
| Men 25-34 | 5.49 |
| All Ages | 5.49 |
| Women 35-44 | 5.49 |

**Insight:** Men aged 18-24 rank first, but the gap is only about 0.03 points on a 10-point scale. All five audiences engage at almost the same level, so audience choice alone doesn't explain engagement in this data.

### 5. Overall Click-Through Rate (CTR)

**Method:** `SUM` of clicks divided by `SUM` of impressions, multiplied by `100.0` so SQL works in decimals and not whole numbers.

```sql
SELECT (SUM(Clicks) * 100.0 / SUM(Impressions)) AS OverallCTR
FROM campaigndata;
```

**Screenshot:**

![Query 5: overall click-through rate](images/q05_overall_ctr.png)

**Result:** The overall CTR is about 9.98%.

**Insight:** Roughly 1 in 10 impressions leads to a click, which suggests the campaigns are fairly well targeted. There is still room to improve through better ad copy, visuals and calls to action.

### 6. Most Cost-Effective Campaign

**Method:** Cost per conversion is the acquisition cost divided by the number of conversions. Conversions are estimated as clicks multiplied by the conversion rate. Campaigns with no conversions are excluded to avoid dividing by zero, and results are sorted from lowest to highest cost.

```sql
SELECT campaign_id,
       company,
       ROUND(CAST(acquisition_cost / (clicks * conversion_rate) AS NUMERIC), 2) AS cost_per_conversion
FROM campaigndata
WHERE clicks * conversion_rate > 0
ORDER BY cost_per_conversion ASC
LIMIT 1;
```

**Screenshot:**

![Query 6: most cost-effective campaign](images/q06_cost_per_conversion.png)

**Result:** The most cost-effective campaign is **Alpha Innovations (Campaign ID 118451)**, at about **34.22** per conversion. It has a low acquisition cost (5,107) and a high number of clicks (995) with the top conversion rate (0.15).

**Insight:** Campaigns with a low cost per conversion get more customers for the same budget. This campaign combines a low cost with strong clicks and conversion rate, and no other campaign shares its exact value.

### 7. Campaigns with a CTR Above 5%

**Method:** A calculated CTR for each campaign (`clicks * 100.0 / impressions`) with a `WHERE` filter to keep only those above 5%.

```sql
SELECT campaign_id,
       company,
       (clicks * 100.0 / impressions) AS ctr
FROM campaigndata
WHERE (clicks * 100.0 / impressions) > 5;
```

**Screenshot:**

![Query 7: campaigns with a CTR above 5%](images/q07_ctr_above_5.png)

**Result:** 160,332 of the 200,005 campaigns (about 80%) have a CTR above 5%. For example, Innovate Industries (Campaign 1) has a CTR of 26.33%.

**Insight:** Most campaigns clear the 5% mark, so it is a low bar for this dataset. The highest CTRs are close to 99%, which is unrealistic for real ads and points to a simulated dataset. A higher cut-off would be more useful for picking out top performers.

### 8. Channels Ranked by Estimated Conversions

**Method:** Conversions for each campaign are estimated as clicks multiplied by the conversion rate, then added up for each channel. The `RANK()` window function orders the channels from most to fewest conversions.

```sql
SELECT channel_used,
       ROUND(CAST(SUM(clicks * conversion_rate) AS NUMERIC), 0) AS total_conversions,
       RANK() OVER (ORDER BY SUM(clicks * conversion_rate) DESC) AS channel_rank
FROM campaigndata
GROUP BY channel_used
ORDER BY channel_rank;
```

**Screenshot:**

![Query 8: channels ranked by estimated conversions](images/q08_channel_ranking.png)

**Result:**

| Rank | Channel | Estimated conversions |
|---|---|---|
| 1 | Email | 1,485,394 |
| 2 | Website | 1,477,746 |
| 3 | Google Ads | 1,468,814 |
| 4 | YouTube | 1,463,621 |
| 5 | Instagram | 1,462,864 |
| 6 | Facebook | 1,446,295 |

**Insight:** Email ranks first and Facebook last, but the ranking mostly follows the number of campaigns each channel ran (Email 33,599, Facebook 32,820). Per campaign, every channel averages about 44 conversions, and Website is marginally the highest. So the channels perform almost identically, and a total-conversions ranking alone can mislead.

## Key Findings

- The dataset has **200,005 campaigns**, with impressions from 1,000 to 10,000 each.
- The overall CTR is **9.98%**, and about 80% of campaigns have a CTR above 5%.
- The top ROI is 8.0, but **160 campaigns tie** for it, so campaign 168 (NexGen Systems) is not uniquely the best.
- **Alpha Innovations (Campaign 118451)** is the most cost-effective campaign, at about 34.22 per conversion.
- **Email** leads on total estimated conversions and **Facebook** is last, but this follows campaign volume. Average conversions per campaign are about 44 for every channel.
- Locations and audiences perform very similarly. **Men 18-24** have the highest engagement (5.52), but only 0.03 points ahead of the others.

## Recommendations

1. **Study the 160 campaigns that tie for the top ROI.** Look at what they share on company, channel, audience and duration before copying any single campaign.
2. **Compare channels per campaign, not in total.** Total conversions mostly reflect how many campaigns a channel ran, so use average conversions or cost per conversion when moving budget.
3. **Copy the approach of Campaign 118451.** Its low acquisition cost, high clicks and top conversion rate make it the strongest cost-efficiency example.
4. **Raise the CTR bar.** A 5% threshold includes 80% of campaigns, so use a stricter cut-off such as the top 10% to find real leaders.
5. **Test audiences before shifting budget.** Engagement differs by only 0.03 points across audiences, so run A/B tests before favouring Men 18-24.
6. **Check the data before acting.** Very high CTRs and evenly spread group sizes suggest simulated data, so confirm the source before large budget decisions.

## Limitations

- The group sizes and value ranges are very even, which suggests the dataset is synthetic, so results may not reflect real campaign behaviour.
- Differences between locations, audiences and channels are small, so rankings are weak evidence of real performance gaps.
- Conversions are **estimated** as clicks multiplied by the conversion rate, because the dataset has no conversion counts.
- Cost per conversion assumes `Acquisition_Cost` is the total cost of each campaign.
- Queries 2 and 6 use `LIMIT 1`, so ties for first place don't show. This matters for query 2, where 160 campaigns tie.

## Skills Demonstrated

`SELECT` · `GROUP BY` · `ORDER BY` · `WHERE` · `LIMIT` · `SUM` / `AVG` · `CAST` · `ROUND` · calculated metrics (CTR, cost per conversion) · `RANK() OVER`

**Tool:** TODO-your-database and SQL client

## Repository Structure

```
.
├── README.md
├── Marketing Campaign Performance.pdf
├── SQL Queries.zip            # the 8 query files
└── images/                    # screenshots of query results
```

## Author

**Aisha Hamza** | [LinkedIn](TODO-your-linkedin-link) | [Email](mailto:TODO-your-email)
