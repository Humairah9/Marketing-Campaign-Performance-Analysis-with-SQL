# Marketing Campaign Performance Analysis with SQL

Using SQL, I analysed a marketing campaign dataset to answer questions about campaign reach, return on investment (ROI), audience engagement, click-through rate (CTR), cost efficiency and channel performance. I wrote 8 queries covering aggregation, sorting, filtering, calculated metrics and window functions.

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

The analysis uses one table, `campaigndata`, where each row is a single marketing campaign. `Campaign_ID` is the primary key.

| Group | Column | Description |
|---|---|---|
| Campaign details | Campaign_ID | Unique identifier for each campaign (primary key) |
| | Company | Company running the campaign |
| | Campaign_Type | Type of campaign, such as Email, Display or Influencer |
| | Duration | Length of the campaign, for example "30 days" |
| | Channel_Used | Platform used, such as Google Ads or YouTube |
| | Target_Audience | Demographic group the campaign was aimed at |
| Performance | Impressions | Number of times the ad was displayed |
| | Clicks | Number of times users clicked the ad |
| | Engagement_Score | Score from 1 to 10 for user interaction |
| | Conversion_Rate | Share of users who took the desired action |
| Financial | Acquisition_Cost | Cost of acquiring customers through the campaign |
| | ROI | Return on investment of the campaign |
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

**Result:** Every campaign has exactly 10,000 impressions.

**Insight:** Identical impressions suggest a controlled experiment or a data recording issue, since real campaigns vary with budget and targeting. Impressions only show reach, so they can't separate strong campaigns from weak ones. Clicks, conversions and ROI are needed for that.

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

**Result:** Campaign 168 from NexGen Systems has the highest ROI, at 8.0.

**Insight:** This campaign turned spend into returns more efficiently than any other, which makes it the best candidate to study and copy. `LIMIT 1` shows only one row, so if two campaigns tied for the top ROI, only one would appear.

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

**Result:** New York, Miami and Chicago have the most impressions.

**Insight:** Every campaign has exactly 10,000 impressions (query 1), so a location's total reflects how many campaigns ran there, not how well they performed. These three cities simply had the most campaigns.

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

**Result:** Men aged 18-24 have the highest average engagement, followed by Women aged 25-34 and Men aged 25-34.

**Insight:** Younger audiences interact most with these campaigns, and campaigns aimed at all ages also engage well, so broad targeting can work too.

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

**Result:** The most cost-effective campaign is **TODO-company (Campaign ID TODO-id)**, at **TODO-value** per conversion.

**Insight:** Campaigns with a low cost per conversion get more customers for the same budget. Their approach is worth copying, and the most expensive campaigns are worth reviewing.

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

**Result:** Only campaigns with a CTR above 5% are shown, so every row here is a strong performer. For example, Innovate Industries (Campaign 1) has a CTR of 26.33%.

**Insight:** Campaigns with a high CTR drew users in through good targeting, design or messaging. Campaigns missing from this list fall at or below 5% and are the ones to optimise.

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

**Result:** **TODO-channel** ranks first with about **TODO-number** conversions, followed by **TODO-channel** and **TODO-channel**. **TODO-channel** ranks last.

**Insight:** This ranking shows which channels deserve more budget and which need a rethink.

## Key Findings

- Every campaign has the same 10,000 impressions, so reach doesn't separate strong campaigns from weak ones.
- **NexGen Systems (Campaign 168)** has the highest ROI, at 8.0.
- **New York, Miami and Chicago** had the most impressions, because they had the most campaigns.
- **Men aged 18-24** are the most engaged audience.
- The overall CTR is **9.98%**.
- **TODO-company** has the lowest cost per conversion.
- **TODO-channel** leads on estimated conversions and **TODO-channel** is last.

## Recommendations

1. **Study and copy the highest-ROI campaign.** Look at what NexGen Systems did on targeting, channel and creative, and apply it to weaker campaigns.
2. **Prioritise engaged audiences.** Men aged 18-24 engage the most, so give them more of the budget and test what drives that response in other groups.
3. **Improve CTR.** Test ad copy, visuals and calls to action, especially in campaigns below the 5% mark.
4. **Reduce cost per conversion.** Copy the approach of TODO-company, the most cost-effective campaign, in higher-cost campaigns.
5. **Shift budget toward the top channels** (TODO-channel and TODO-channel) and review the creative and targeting of the lowest-ranked channel.
6. **Check the data before acting.** The identical impressions need explaining before major budget decisions rest on this dataset.

## Limitations

- Every campaign has the same impressions, which suggests the data is synthetic or was recorded in a simplified way.
- Conversions are **estimated** as clicks multiplied by the conversion rate, because the dataset has no conversion counts.
- Cost per conversion assumes `Acquisition_Cost` is the total cost of each campaign.
- Location rankings reflect the number of campaigns in each place, not performance.
- Queries 2 and 6 use `LIMIT 1`, so ties for first place would not show.

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
