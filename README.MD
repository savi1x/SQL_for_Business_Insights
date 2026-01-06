# Brazilian E-Commerce Analytics

## Overview
Analysis of supply chain logistics, customer satisfaction, and retention for a Brazilian e-commerce platform (Brazilian Olist E-Commerce dataset 2016–2018) to quantify the impact of delivery delays on churn and maximize customer lifetime value.
## Business Questions

1. Logistics Analysis: How strictly does delivery time correlate with customer dissatisfaction and review scores?
2. Customer Segmentation: Who are our "Power Users" (VIPs) versus one-time buyers based on RFM (Recency, Frequency, Monetary) scores?
3. Cohort Retention: Are customers acquired during major holiday seasons (e.g., Black Friday) loyal, or do they churn immediately?
## Analysis Approuch

### 1. Logistics & Satisfaction Analysis

Query: [1_logistics_analysis.sql](/1_logistics_analysis.sql)

- Calculated delivery speed performance by comparing estimated deadlines against actual arrival dates

- Correlated delivery delays with customer review scores

- Grouped orders by delay severity (e.g., On Time vs. Late)

Vizualisation:

![Logistics Analysis](/images/1_logistics_analysis.png)

📊 Key Findings:

- Immediate Satisfaction Drop: Average review score declines by 23% (4.29 → 3.29) within the first 1-3 days of delay.

- High-Volume Failure Mode: Extreme delays (7+ days) account for 3.4% of all orders (3,253), exceeding the volume of minor 1-6 day delays combined (3,129).

- Terminal Sentiment: Orders delayed beyond one week reach a saturation point of dissatisfaction at 1.73 stars, maximizing churn risk

💡Business Insights:

- Operational Triage: Implement "Stuck Package Alerts" at the 48-hour mark to intervene before orders drift into the high-volume "7+ Day" category.

- Retention Threshold: Trigger automated compensation (shipping refunds/credits) before Day 4, preventing the critical sentiment drop from 3.29 to 2.17.

- Root Cause Audit: Investigate the specific carriers or routes responsible for the 3.4% of extreme delays, as this minority segment drives the majority of severe detractors.

### 2. Customer Segmentation Analysis

Query: [2_customer_segmentation.sql](2_customer_segmentation.sql)

- Ranked customers into quartiles based on their LTV 

- Segmented the user base into High, Mid, and Low-value groups 

- Calculated key metrics like total revenue

Vizualisation:

![Logistics Analysis](/images/2_customer_segmentation.png)

📊 Key Findings:

- High-Value Dominance: the top 25% of customers (High-Value) drive 62.7% of total revenue ($8.5M)

- The "Mass Market" Core: the Mid-Value segment (50% of users) remains statistically significant, contributing 32.2% of revenue ($4.4M)

- Low-Value Efficiency Gap: the bottom 25% of customers generate only 5.1% of revenue ($695k)

💡 Business Insights:

- High-Value: since losing just a fraction of these 23,855 VIPs would drastically hurt the bottom line, implement a "Velvet Rope" retention strategy (exclusive early access, dedicated support) to lock them in.

- Mid-Value: this group is the primary growth lever. Launch Average Order Value (AOV) boosters—such as "Spend $50 more for free shipping" or product bundles—to migrate these users into the High-Value tier.

- Low-Value: minimize ad spend on this segment. Shift to low-cost automated channels (email/push notifications) for re-engagement, as high-touch marketing here yields a negative ROI.

## Techical Details
- Database
- Analysis tools
- Visualisation