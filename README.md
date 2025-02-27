# Company Layoffs Exploratory Data Analysis Project With SQL and Power BI
This project leverages SQL and Power BI to deliver a comprehensive analysis of competitor layoffs data with a total of **1000** records. Our analysis focuses on key north star metrics that highlight overall workforce reductions, the average impact per company, and detailed breakdowns by industry, geography, and time periods. The dashboards and queries reveal seasonal trends, patterns in company shutdowns, and ranking insights that are essential for understanding market dynamics and identifying areas of vulnerability and opportunity. These metrics provide a clear, strategic view of the evolving landscape and support data-driven decision-making. Note that the CSV file had to go though data cleaning before being considered eligible for the exploratory data analysis and then further visualization. *To explore further details on the data cleaning queries and the comprehensive EDA, please see the following links:*

- [Click here for the Data Cleaning SQL file](./data_cleaning.sql)
- [Click here for the Analysis SQL file](./analysis.sql)


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

### Dashboard Overview

The main dashboard consolidates all key metrics, offering an at-a-glance view of the overall layoff landscape. It displays total layoffs, average layoffs per company, and overall percentages across multiple dimensions. This high-level snapshot provides immediate context, setting the stage for more in-depth analyses that explore temporal trends, industry impacts, geographic distributions, and company-specific rankings. - [Click here for the Power BI Visualization](./layoffs.pbix)

### Time Series Trends

The time series chart covers the period from March 2020 to February 2023, mapping the evolution of layoffs over time. It reveals distinct peaks during critical months—such as January, April, and June—indicating periods of significant restructuring and market pressure, while also showing lower activity in months like March, October, and December. This visualization not only captures seasonal variations but also reflects broader economic shifts and pivotal events that drive workforce adjustments.
![Power BI Dashboard Screenshot](images/Screenshot%2025-02-24%182054.png)

### Industry Breakdown

The dashboard features detailed visualizations that break down layoffs by industry, highlighting which sectors are most affected. It clearly illustrates that sectors such as consumer, retail, and transportation consistently experience the highest impact. These charts also depict the percentage share of total layoffs for each industry, enabling stakeholders to perform comparative analyses and identify trends over multiple time periods—such as the recurring impact on consumer industries and emerging pressures in tech sectors.
![Power BI Dashboard Screenshot](images/Screenshot%202025-02-24%20182142.png)

### Geographic Distribution

Interactive map visuals detail the geographic concentration of layoffs, providing a spatial perspective on the data. The maps show that the United States is the dominant region affected, with a significant proportion of layoffs occurring there, while countries like India also register a notable impact. This geographical breakdown helps stakeholders understand regional market dynamics and identify localized trends that may influence strategic planning and resource allocation.
![Power BI Dashboard Screenshot](images/Screenshot%2025-02-24%182113.png)

### Company Rankings

Ranking visualizations offer insights into which companies bear the brunt of layoffs on both monthly and yearly bases. These charts highlight major cases—such as significant workforce reductions at industry giants like Amazon, Google, and Meta—and spotlight extreme instances of complete shutdowns, as seen with companies like Katerra. The rankings are interactive, allowing users to filter and drill down into specific periods or sectors, thereby providing a clear view of the competitive landscape and strategic vulnerabilities.
![Power BI Dashboard Screenshot](images/Screenshot%202025-02-24%20182142.png)

---



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
