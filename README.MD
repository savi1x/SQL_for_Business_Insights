# Brazilian E-Commerce Analytics
## Overview
Analysis of supply chain logistics, customer satisfaction, and retention for a Brazilian e-commerce platform (Brazilian Olist E-Commerce dataset 2016–2018) to quantify the impact of delivery delays on churn and maximize customer lifetime value.
## Business Questions
1. Logistics Analysis. How strictly does delivery time correlate with customer dissatisfaction and review scores?

2. Customer Segmentation. Who are our "Power Users" (VIPs) versus one-time buyers based on RFM (Recency, Frequency, Monetary) scores?
3. Cohort Retention. Are customers acquired during major holiday seasons (e.g., Black Friday) loyal, or do they churn immediately?
## Analysis Approuch
### 1. Logistics & Satisfaction Analysis
🖥️ Query: [1_logistics_analysis.sql](/1_logistics_analysis.sql)
- Calculated delivery speed performance by comparing estimated deadlines against actual arrival dates

- Correlated delivery delays with customer review scores
- Grouped orders by delay severity (e.g., On Time vs. Late)

📈 Vizualisation:

![Logistics Analysis](/images/1_logistics_analysis.png)

📊 Key Findings:
- Immediate Satisfaction Drop: average review score declines by 23% (4.29 → 3.29) within the first 1-3 days of delay.

- High-Volume Failure Mode: extreme delays (7+ days) account for 3.4% of all orders (3,253), exceeding the volume of minor 1-6 day delays combined (3,129).
- Terminal Sentiment: orders delayed beyond one week reach a saturation point of dissatisfaction at 1.73 stars, maximizing churn risk

💡Business Insights:

- Operational Triage: implement "Stuck Package Alerts" at the 48-hour mark to intervene before orders drift into the high-volume "7+ Day" category.

- Retention Threshold: trigger automated compensation (shipping refunds/credits) before Day 4, preventing the critical sentiment drop from 3.29 to 2.17.

- Root Cause Audit: investigate the specific carriers or routes responsible for the 3.4% of extreme delays, as this minority segment drives the majority of severe detractors.

### 2. Customer Segmentation Analysis

🖥️ Query: [2_customer_segmentation.sql](2_customer_segmentation.sql)

- Ranked customers into quartiles based on their LTV 

- Segmented the user base into High, Mid, and Low-value groups 

- Calculated key metrics like total revenue

📈 Vizualisation:

![Customer Segmentation](/images/2_customer_segmentation.png)

📊 Key Findings:

- High-Value Dominance: the top 25% of customers drive 62.7% of total revenue ($8.5M)

- The "Mass Market" Core: the Mid-Value segment (50% of users) remains statistically significant, contributing 32.2% of revenue ($4.4M)

- Low-Value Efficiency Gap: the bottom 25% of customers generate only 5.1% of revenue ($695k)

💡 Business Insights:

- High-Value: since losing just a fraction of these 23,855 VIPs would drastically hurt the bottom line, implement a "Velvet Rope" retention strategy (exclusive early access, dedicated support) to lock them in.

- Mid-Value: this group is the primary growth lever. Launch Average Order Value (AOV) boosters—such as "Spend $50 more for free shipping" or product bundles—to migrate these users into the High-Value tier.

- Low-Value: minimize ad spend on this segment. Shift to low-cost automated channels (email/push notifications) for re-engagement, as high-touch marketing here yields a negative ROI.

### 3. Cohort Retention Analysis

🖥️ Query: [3_cohort_retention_analysis.sql](/3_cohort_retention_analysis.sql)

- Grouped customers into time-based cohorts according to the month of their very first purchase.

- Tracked long-term engagement by measuring how many users returned for a second purchase after 3, 6, and 12 months.

- Compared retention rates across different acquisition periods to see if holiday shoppers are less loyal than organic customers.

📈 Vizualisation:

![Cohort Retention Analysis](/images/3_cohort_retention_analysis.png)

📊 Key Findings:

- The "One-and-Done" Problem: retention rates collapse immediately after the first purchase. For the Oct 2016 cohort, less than 1% of customers returned for a second purchase within 6 months

- Lack of Loyalty: across all visible cohorts, the "1 month sinse fisrt purchase" count is consistently negligible, indicating that users treat the platform as a transactional marketplace rather than a go-to shopping destination.

- Long-Term Dormancy: even after 1+ years, reactivations are virtually non-existent, suggesting that once a user churns, they are gone forever.

💡 Business Insights:

- Shift Strategy to Acquisition: since retention is naturally low (likely due to the business model of selling durable goods like furniture/electronics), marketing should double down on Customer Acquisition Cost (CAC) optimization rather than fighting a losing battle for retention.

- Introduce "Lock-In" Mechanisms: to break this cycle, the company must launch a Subscription Model (like Amazon Prime) or a "Subscribe & Save" feature for consumable goods (Health/Beauty category) to manufacture artificial retention.

- Post-Purchase Automation: the drop from Lag 0 to Lag 1 is too steep. Implement an automated "30-Day Replenishment" email flow or "Cross-Sell" campaign immediately after delivery to trigger that elusive second purchase.

## Strategic Recommendations
1. Supply Chain & Logistics Optimization
- Implement automated "Stuck Package Alerts" at the 48-hour delay mark to intervene before orders drift into the high-volume "7+ Days Late" failure zone.
- Trigger proactive compensation (credits/refunds) before Day 4 of a delay to prevent customer satisfaction scores from collapsing below the 2.2-star threshold.
- Immediately investigate the specific logistics routes responsible for the 3.4% of extreme delays, as this minority segment drives the vast majority of negative brand sentiment.

2. Customer Value Optimization
- Launch an exclusive retention program for the top 25% of users (High-Value) who drive 63% of revenue, as losing these customers poses a disproportionate risk to the bottom line.
- Target the Mid-Value segment (32% revenue) with Average Order Value (AOV) boosters, such as bundle discounts, to push them into the High-Value tier.
- Restrict paid ad spend on Low-Value users (5% revenue) and shift to low-cost automated email channels to maintain profitability on these lower-margin customers.

3. Retention & Lifecycle Strategy
- Introduce a "Subscribe & Save" model for consumable categories (Health & Beauty) to manufacture artificial loyalty, since organic retention is near 0% after Month 1.
- Deploy aggressive cross-sell campaigns within 7 days of delivery, as the data proves that if a user does not return immediately, they are statistically unlikely to ever return.
- Shift budget towards Customer Acquisition Cost (CAC) optimization rather than fighting a losing battle for dormant user reactivation, given the systemic lack of long-term retention.

## Techical Details
- Database: PostgreSQL
- Analysis Tools: PostgreSQL, Dbeaver
- Visualization: ChatGPT