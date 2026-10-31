CREATE DATABASE MarketingCampaign;
GO
USE MarketingCampaign;
GO
--Creating the table 
DROP TABLE IF EXISTS campaigndata;

CREATE TABLE campaigndata (
    Campaign_ID      INT PRIMARY KEY,
    Company          NVARCHAR(50),
    Campaign_Type    NVARCHAR(50),
    Target_Audience  NVARCHAR(50),
    Duration         NVARCHAR(20),
    Channel_Used     NVARCHAR(50),
    Conversion_Rate  FLOAT,
    Acquisition_Cost INT,
    ROI              DECIMAL(4,2),
    Location         NVARCHAR(50),
    Date             DATE,
    Clicks           INT,
    Impressions      INT,
    Engagement_Score INT,
    Customer_Segment NVARCHAR(50)
);

BULK INSERT campaigndata
FROM 'C:\temp\marketing_campaign_dataset.csv'
WITH (FORMAT = 'CSV', FIRSTROW = 2, FIELDTERMINATOR = ',', ROWTERMINATOR = '0x0a', CODEPAGE = '65001');

--Checking my dataset
SELECT * 
FROM campaigndata;

--Checking the status of my dataset 
SELECT COUNT(*) AS total_count
FROM campaigndata;

-- 1. Check the reach of each campaign through impressions
SELECT campaign_id, SUM(impressions) AS totalimpressions
FROM campaigndata
GROUP BY campaign_id
ORDER BY totalimpressions DESC;

-- 2. Find the campaign with the highest ROI.
SELECT TOP 1 Campaign_ID, Company, ROI
FROM campaigndata
ORDER BY ROI DESC;

-- 3. Find the locations with the most impressions
SELECT TOP 3 Location, SUM(Impressions) AS TotalImpressions
FROM campaigndata
GROUP BY Location
ORDER BY TotalImpressions DESC;

-- 4. Compare engagement across target audiences.
SELECT target_audience, AVG(engagement_score) AS avgengagementscore
FROM campaigndata
GROUP BY target_audience
ORDER BY avgengagementscore DESC;

-- 5. Measure the overall click-through rate and find campaigns with a strong CTR.
SELECT (SUM(Clicks) * 100.0 / SUM(Impressions)) AS OverallCTR
FROM campaigndata;

-- 6
SELECT TOP 1 campaign_id, company,
       ROUND(CAST(acquisition_cost / (clicks * conversion_rate) AS DECIMAL(18,4)), 2) AS cost_per_conversion
FROM campaigndata
WHERE clicks * conversion_rate > 0
ORDER BY cost_per_conversion ASC;

-- 7. Find the most cost-effective campaign.
SELECT campaign_id, company, (clicks * 100.0 / impressions) AS ctr
FROM campaigndata
WHERE (clicks * 100.0 / impressions) > 5;

-- 8. Rank marketing channels by estimated conversions.
SELECT channel_used,
       ROUND(CAST
                (SUM(clicks * conversion_rate) AS DECIMAL(18,2)), 0) AS total_conversions,
       RANK() OVER (ORDER BY SUM(clicks * conversion_rate) DESC) AS channel_rank
FROM campaigndata
GROUP BY channel_used
ORDER BY channel_rank;