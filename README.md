# Company Layoffs Exploratory Data Analysis Project With SQL and Power BI
This project leverages SQL and Power BI to deliver a comprehensive analysis of competitor layoffs data with a total of **1000** records. Our analysis focuses on key north star metrics that highlight overall workforce reductions, the average impact per company, and detailed breakdowns by industry, geography, and time periods. The dashboards and queries reveal seasonal trends, patterns in company shutdowns, and ranking insights that are essential for understanding market dynamics and identifying areas of vulnerability and opportunity. These metrics provide a clear, strategic view of the evolving landscape and support data-driven decision-making. Note that the CSV file had to go though data cleaning before being considered eligible for the exploratory data analysis and then further visualization. For a detailed view of the **data cleaning** queries, [click here](./data_cleaning.sql). For further insights on the **EDA with SQL**, [click here](./analysis.sql).


## Table of Contents


1. [Executive Insights](#executive-insights)
2. [Dashboard Overview](#dashboard-overview)
3. [Time Series Trends](#time-series-trends)
4. [Industry Breakdown](#industry-breakdown)
5. [Geographic Distribution](#geographic-distribution)
6. [Company Rankings](#company-rankings)
7. [Conclusion](#conclusion)

---

## Executive Insights

The analysis of our competitor layoff data—covering the period from **March 2020 to December 2023**—reveals several important trends:

- **Overall Impact:**  
  During this period, a total of **386,379** employees were laid off. On average, each company reduced its workforce by **238** employees, approximately **25.92%** of their workforce. In extreme cases, layoffs reached up to **12,000** employees.

- **Complete Shutdowns:**  
  Notably, high-profile cases include **Katerra**, which laid off its entire staff of **2,434** despite having raised **$1,600 million**. Similarly, companies such as Britishvolt, Quibi, and Deliveroo Australia—each with over **$1,500 million** in funding—ended up shutting down completely.

- **Temporal Patterns:**  
  November 2022 saw the highest number of company shutdowns (11 in that month), and 2022 as a whole recorded the most shutdowns (58). Early 2023 already shows **127,277** layoffs, suggesting that the year's total may be even higher.

- **Industry and Geographic Trends:**  
  The consumer sector led the layoffs (47,082 employees, 12% of total layoffs), followed by retail (43,613, 11%), transportation (34,498, 9%), and finance (28,344, 7%). Geographically, the United States experienced 67% of layoffs (258,159 employees), while India accounted for 9% (35,993 employees).

- **Company Lifecycle and Funding:**  
  Post-IPO companies bore the brunt with 53% (204,882 employees) of the layoffs, while acquired companies were responsible for 7.5% (29,176 employees). Interestingly, seed-stage companies, on average, laid off 70% of their workforce; Series A and B companies followed at 38% and 32% respectively.

- **Seasonal Trends:**  
  Months like January, April, and June experienced higher layoff volumes (21%, 11%, and 9% respectively), whereas March, October, and December were lower (around 4–5%). In early 2023, January saw 63,378 layoffs (16%), compared to 29,678 in November 2022 (8%).

---

## Dashboard Overview

The main dashboard provides an at-a-glance view of key metrics such as total layoffs, average layoffs per company, and overall percentages. This visualization sets the context for the deeper analyses presented in subsequent sections.

![Dashboard Overview](images/dashboard_overview.png)

---

## Time Series Trends

The time series chart displays layoffs over the period from March 2020 to February 2023. The visualization reveals distinct peaks in certain months—such as January, April, and June—and lower volumes in months like March, October, and December. This temporal pattern supports the analysis of seasonal trends and highlights periods of significant workforce reductions.

![Time Series Trends](images/time_series_trends.png)

---

## Industry Breakdown

The dashboard includes visualizations that break down layoffs by industry. These charts highlight that the consumer, retail, and transportation sectors have experienced the highest impact. The percentage share of layoffs for each industry is also clearly represented, enabling a comparative analysis across different sectors.

![Industry Breakdown](images/industry_breakdown.png)

---

## Geographic Distribution

Map visuals illustrate the geographic concentration of layoffs. The United States dominates with 67% of layoffs, followed by India at 9%. This interactive map allows stakeholders to explore regional trends and understand the distribution of layoffs across various countries.

![Geographic Distribution](images/geographic_distribution.png)

---

## Company Rankings

The dashboard includes ranking visuals that identify top companies by layoffs on both a monthly and yearly basis. These charts highlight significant cases, such as major layoffs at Amazon, Google, Meta, and complete shutdowns like Katerra. Such rankings provide a clear picture of which companies and sectors are most impacted.

![Company Rankings](images/company_rankings.png)



## Conclusion

This competitor layoff data analysis—covering the period from **March 2020 to February 2023**—provides critical insights into market dynamics and workforce reductions. Nearly **386,379** employees were laid off during this period, with companies, on average, reducing their workforce by **238** employees (or **25.92%**). High-profile complete shutdowns, particularly among well-funded companies like Katerra, Britishvolt, Quibi, and Deliveroo Australia, highlight the unpredictable nature of the market.

Key findings indicate:
- **Temporal Variations:** Peaks in shutdowns occurred in November 2022 and throughout 2022, with early 2023 showing significant activity.
- **Industry and Geographic Concentration:** The consumer sector, along with the United States and India, bore the highest impact.
- **Lifecycle Vulnerabilities:** Post-IPO and seed-stage companies were particularly affected, suggesting that maturity and funding stage play a crucial role in workforce stability.
- **Seasonal Trends:** Strategic workforce planning is essential given the varying monthly layoff volumes.
- **High Overall Impact:**  
  Nearly **386,379** employees were laid off over the analyzed period, with an average layoff of **238 employees per company** (25.92%). The extreme cases, such as layoffs of up to **12,000** employees, highlight the market's volatility.
- **Sector & Geographic Insights:**  
  The consumer sector and the United States show the highest impact, while other regions and industries are relatively less affected. This concentration emphasizes the importance of targeted strategies in the most affected areas.
- **Critical Case Studies:**  
  The complete shutdowns of well-funded companies like Katerra, as well as significant layoffs at major tech giants, underscore the challenges across different segments of the market.
- **Actionable Trends:**  
  The clear seasonal patterns and year-over-year shifts observed in the dashboard support proactive workforce planning and strategic decision-making. Recognizing these trends allows stakeholders to better manage risk and optimize resource allocation.

Overall, the integration of Power BI visualizations with our data analysis not only validates the SQL insights but also provides a dynamic platform for continuous monitoring and deeper exploration of the layoffs data. Stakeholders can leverage these insights to build more resilient business strategies and adapt effectively to the evolving market landscape. These insights provide a roadmap for stakeholders to build more resilient business strategies, optimize workforce planning, and adapt to ongoing market challenges.

