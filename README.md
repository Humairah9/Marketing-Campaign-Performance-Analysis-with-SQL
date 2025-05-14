# Marketing-Campaign-Performance-Analysis-with-SQL
Using SQL, I analyzed a marketing campaign dataset to uncover insights on campaign reach, ROI, engagement, and conversion performance. I wrote targeted queries to identify top campaigns, effective marketing channels, and responsive demographics.

# Table of Content 
- [Introduction](https://github.com/Humairah9/Marketing-Campaign-Performance-Analysis-with-SQL/blob/main/README.md#introduction)

![images (9)](https://github.com/user-attachments/assets/e7a3be68-18c0-4b6d-b1e0-655ea7c1eb50)

#  Introduction
 In today’s digital landscape, marketing campaigns play a pivotal role in shaping brand visibility,
 driving customer engagement, and ultimately increasing conversions. Companies invest heavily
 in online advertising, leveraging various channels such as Google Ads, social media, email
 marketing, and influencer partnerships to reach their target audiences. However, not all
 campaigns deliver the desired results; some generate significant traction, while others
 underperform, leading to inefficient spending and lost opportunities.
 To maximize return on investment (ROI), businesses must adopt a data-driven approach to
 campaign analysis. This involves evaluating key performance indicators (KPIs) such as
 impressions, clicks, conversion rate, engagement score, cost per conversion, return on
 investment (ROI).
This study focuses on analyzing a marketing campaign dataset using Structured Query
 Language (SQL) to extract actionable insights. By running targeted SQL queries, we aim to:
  - Identify the campaigns with the highest impressions to assess audience reach.
  - Determine which campaign delivered the highest ROI, helping businesses allocate
 budgets more effectively.
  - Analyze top-performing locations to guide regional marketing strategies.
  - Evaluate the average engagement score by target audience, ensuring marketing efforts
 are tailored to responsive demographics.
  - Calculate the overall Click-Through Rate (CTR) to measure how well ads convert views
 into interactions.
  - Find the most cost-effective campaigns, ensuring optimized ad spend.
  - Rank marketing channels by total conversions, highlighting the most effective platforms
 for future investment.

By answering these questions, this analysis will provide valuable insights that help marketers
 make data-driven decisions, optimize campaign strategies, and improve overall marketing
 efficiency. Businesses can use these findings to fine-tune ad placements, enhance audience
 targeting, and maximize conversion potential, ensuring higher profitability and reduced
 wasted ad spend.

 # Data Overview and Dataset Structure
 
 To effectively analyze the performance of marketing campaigns, we use a structured dataset
 containing key performance indicators (KPIs) and campaign-specific attributes. This dataset
 enables businesses to evaluate engagement levels, cost efficiency, and overall campaign
 effectiveness, helping them optimize future marketing strategies.

 # Key Variables
 
The dataset captures crucial details about various marketing campaigns, including company
 information, advertising channels, and financial performance metrics. Below is a breakdown of
 the key variables:
 
 # Campaign Details
 
 - Campaign_ID (Integer): A unique identifier assigned to each campaign. (Primary Key)
 - Company (String): The name of the company running the campaign.
 - Campaign_Type (String): Specifies the type of marketing campaign (e.g., Email,
 Display, Influencer).
 - Duration (String): The total length of the campaign (e.g., "30 days").
 - Channel_Used (String): The platform where the campaign was executed (e.g., Google
 Ads, YouTube).
 
 # Performance Metrics

 - Impressions (Integer): The total number of times the advertisement was displayed to
 users.
 - Clicks (Integer): The number of times users clicked on the advertisement.
 - Engagement_Score (Integer): A score (ranging from 1 to 10) that measures user
interaction and engagement with the campaign.
 - Conversion_Rate (Float): The percentage of users who took a desired action (e.g.,
 purchase, sign-up) after interacting with the campaign.

 # Financial Metrics
 
 - Acquisition_Cost (Float): The cost incurred by the company to acquire a new customer
 through the campaign.
 - ROI (Return on Investment) (Float): A profitability metric that measures the
 effectiveness of a campaign relative to its cost.

 # Geographic Targeting
Location (String): The geographic region where the campaign was targeted.
 
 # Dataset Structure
 The dataset is structured in a tabular format, where each row represents a unique marketing
 campaign. This ensures that the dataset maintains data integrity and uniqueness while enabling
 efficient querying and analysis.

 #  Data Organization:
 
 - The primary key is Campaign_ID, ensuring each campaign is uniquely identifiable.
 - Categorical variables include Company, Campaign_Type, Channel_Used, and Location.
 - Numerical variables (e.g., Impressions, Clicks, Conversion_Rate, ROI) capture key
 performance metrics.
 - The dataset is optimized for SQL-based queries,allowing for easy filtering, aggregation,
 and performance analysis.

 This structured format enables efficient data retrieval for insights related to campaign
 performance, audience engagement, and cost-effectiveness. By leveraging SQL queries, we
 can uncover trends, rank top-performing campaigns, and optimize marketing spend.
 
 # SQLQueries and Analysis
 This section provides a detailed breakdown of the SQL queries used to analyze the dataset,
 along with the methods, results, insights, and visual representations.
 
 # 1. Total Impressions for Each Campaign
 Method: The goal is to determine the total impressions each campaign received. This helps in
 understanding which campaigns had the broadest reach

 ![1 Sqloutput](https://github.com/user-attachments/assets/1ff46da8-b892-47ad-bc13-1073337ea5e9)

 The query results reveal that every campaign has exactly 10,000 impressions, suggesting either a
 controlled marketing experiment or a possible data recording issue. In real-world scenarios,
 impressions typically fluctuate based on factors like budget, targeting, and engagement. Since
 impressions only indicate reach and not effectiveness, they do not help in distinguishing high
performing campaigns from low-performing ones. To gain meaningful insights, further analysis
 of CTR, conversions, and ROI is necessary to determine which campaigns successfully drive user
 engagement and business impact. Additionally, verifying the dataset’s integrity would help ensure
 accurate conclusions.
 
 # 2. Campaign with the Highest ROI
 Method: ROI (Return on Investment) measures the profitability of a campaign. The goal is to
 identify which campaign had the best financial returns.

 ![2 Sql - Copy](https://github.com/user-attachments/assets/e8498918-13c5-4a61-b944-d1449a415f27)

 The query identifies the most profitable campaign by selecting the one with the highest ROI. The
 results show that campaign ID 168 from NexGen Systems had the best financial return, with an
 ROI of 8.0. This suggests that the campaign was highly efficient in converting marketing spend
 into revenue. Factors like effective targeting, high conversions, and cost efficiency likely
 contributed to its success. Businesses can use this insight to replicate successful strategies and
 optimize lower-performing campaigns for better profitability.

# 3. Top 3Locations with the Most Impressions
 Method: To determine the geographic regions where campaigns were most visible, we calculate
 total impressions per location.

 ![3 Sql](https://github.com/user-attachments/assets/3f67c425-7361-44a2-b7f0-895e964a40da)

 The query identifies the top three locations with the highest ad impressions, showing where
 marketing campaigns had the most visibility. New York, Miami, and Chicago recorded the
 highest impressions, suggesting strong advertising efforts in these regions. This could be due to
 larger target audiences, higher budgets, or greater engagement potential. While high
 impressions indicate strong visibility, further analysis is needed to assess actual engagement and
 conversions. Businesses can use this insight to optimize regional marketing strategies and
 allocate budgets more effectively.

 #  4. Average Engagement Score by Target Audience
 Method: Engagement Score reflects user interaction levels. By grouping this by Target_Audience,
 we can see which demographics engage the most.

 ![4 Sql](https://github.com/user-attachments/assets/dd4ba258-42aa-42a0-bf9a-5c033d15e705)

  The query identifies which target audiences engage the most with marketing campaigns by
 calculating the average engagement score per demographic. The results show that Men aged 18
24 have the highest engagement, followed by Women 25-34 and Men 25-34, indicating that
 younger audiences interact more with campaigns. The high engagement for all-age campaigns
 suggests that broad targeting can also be effective. These insights help businesses refine their
 marketing efforts by focusing on highly engaged demographics and adjusting strategies for less
 responsive groups.

 # 5. Overall Click-Through Rate (CTR)
 Method: The Click-Through Rate (CTR) measures how effectively a campaign converts
 impressions into clicks, indicating audience interest and engagement.

 ![5 Sql](https://github.com/user-attachments/assets/1ea22307-aa5e-4686-ab44-e819d306b286)

  This query sums up all clicks and impressions across the dataset and computes the overall CTR,
 which is approximately 9.98%. A high CTR suggests that the campaigns are well-targeted and
 compelling, while a low CTR could indicate poor ad relevance, ineffective messaging, or weak
 call-to-action elements. This insight is valuable for assessing overall campaign performance.
 Businesses can improve CTR by refining their ad copy, visuals, and targeting strategies to
 attract more engagement from users.
 
 # 6. Most Cost-Effective Campaign
 Method: This query calculates the Cost per Conversion, which indicates how much money is
 spent on acquiring a single conversion (such as a purchase or sign-up).

 ![6 Sql](https://github.com/user-attachments/assets/b264058a-8cca-4d7a-976b-7ce1cb9e2a83)

 The results are sorted in ascending order to identify the campaign with the lowest cost per
 conversion, meaning it is the most cost-effective. According to the output, the most efficient
 campaign belongs to Alpha Innovations (Campaign ID: 101103) with a cost per conversion of
 33,346.67. This insight helps businesses optimize their marketing spend by focusing on campaigns
 that deliver high conversions at a lower cost, while re-evaluating or discontinuing less efficient
 campaigns.
 
 # 7. Campaigns with CTR Above a Threshold (5%)
 Method: This query calculates the Click-Through Rate (CTR) for each marketing campaign.
 CTRmeasures how often users clicked on an ad after seeing it and is an important metric for
 evaluating campaign effectiveness.

 ![7 Sql](https://github.com/user-attachments/assets/8f5790f7-5ed8-4191-ad26-f67c72a4ce96)

The table displays CTR values for different campaigns and companies. Higher CTR values
 indicate that the campaign successfully engaged the audience, leading to more clicks. For example,
 Innovate Industries (CampaignID:1)achievedaCTRof26.33%,whichissignificantlyhigher
 than some other campaigns. This suggests that the campaign was highly engaging, possibly due to
 better targeting, ad design, or messaging. On the other hand, some campaigns have much lower
 CTRs, indicating the need for optimization in terms of audience targeting, ad creatives, or
 placement. This insight helps businesses identify high-performing campaigns and adjust strategies for
 lower-performing ones to improve overall engagement and return on investment.
 
 # 8. Channels by Total Conversions
 This query analyzes the total conversions generated by different marketing channels and ranks
 them based on their performance. The SUM(conversion_rate) function calculates the total
 number of conversions for each channel, while the RANK() function assigns a rank based on the
 highest to lowest conversion totals.

 ![8 Sql](https://github.com/user-attachments/assets/5cb6cbff-e6cb-424d-ae5d-4f247b4beba8)

From the results:
 - Email ranks first with 2697.38 total conversions, making it the most effective channel in
 driving conversions.
 - Google Ads follows closely behind with 2681.24 conversions, suggesting that paid search
 is also a strong performer.
 - Website, YouTube, Instagram, and Facebook come next in descending order of
 effectiveness, with Facebook ranking last at 2625.27 conversions.

 This ranking helps businesses determine which marketing channels are driving the most
 conversions, allowing them to prioritize high-performing channels and optimize
 underperformingones.EmailandGoogleAdsappeartobethemosteffective,whilesocial media
 platforms like Facebook and Instagram generate fewer conversions in comparison.

# Conclusions:
 The SQL queries provide valuable insights into campaign performance across multiple
 dimensions, including impressions, engagement, conversions, and cost efficiency. From the
 analysis, several key takeaways emerge:
- CampaignReach&Visibility: Certain locations (e.g., New York, Miami, and Chicago)
 generated the highest total impressions, indicating strong audience exposure.
- Engagement Trends: Men aged 18-24 exhibited the highest engagement scores,
 suggesting they are the most responsive demographic.
- Click-Through Rate (CTR): The overall CTR of the campaigns is 9.98%, indicating a
 reasonable level of ad effectiveness in driving user clicks.
- ReturnonInvestment (ROI): NexGen Systems' campaign had the highest ROI, making
 it the most profitable investment.
- Conversion Performance by Channel: Email and Google Ads generated the highest
 total conversions, while Facebook had the lowest performance, suggesting variations in
 effectiveness across different marketing channels.
- CostPerConversion: Alpha Innovations' campaign had the lowest cost per conversion,
 making it the most cost-effective campaign.

# Recommendations:
 Basedonthesefindings, the following strategies are recommended to optimize future campaigns:
- Invest in High-Performing Locations & Demographics: Since New York, Miami, and
 Chicago yielded the most impressions, increasing ad spend in these regions could
 maximize visibility. Additionally, campaigns targeting Men 18-24 should be prioritized,
 as they engage the most.
- Optimize Low-Performing Channels: Facebook and Instagram had the lowest total
 conversions. Revisiting ad creatives, targeting strategies, and budget allocations can help
 improve their effectiveness.
- Enhance Click-Through Rate (CTR): Despite a decent CTR, there is room for
 improvement. A/B testing ad creatives, refining CTAs, and improving audience targeting
 could increase click rates.
- Maximize High ROI Campaigns: Since NexGen Systems demonstrated the best ROI,
 analyzing its strategy and applying similar tactics to lower-performing campaigns can help
 improve profitability.
- Lower Cost Per Conversion: Since Alpha Innovations had the lowest cost per
 conversion, replicating its efficient cost strategies across other campaigns can improve
 cost-effectiveness.
- LeverageEmail&GoogleAds:Thesechannels drive the most conversions, so increasing
 investments in email marketing and paid search campaigns may lead to better overall
 results.
