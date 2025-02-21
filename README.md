# Company Layoffs Exploratory Data Analysis Project With SQL

## Executive Insights

The analysis of our competitor layoff data—covering the period from **March 2020 to February 2023**—reveals several important trends:

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

## Table of Contents

1. [Data Analysis Queries](#data-analysis-queries)
   - [Basic Data Exploration](#basic-data-exploration)
   - [Analysis of 100% Layoffs (Complete Shutdowns)](#analysis-of-100-layoffs-complete-shutdowns)
   - [Aggregations by Different Dimensions](#aggregations-by-different-dimensions)
     - [By Company](#by-company)
     - [By Industry](#by-industry)
     - [By Country](#by-country)
     - [By Stage](#by-stage)
     - [By Date, Year, and Month](#by-date-year-and-month)
   - [Rolling Totals Analysis](#rolling-totals-analysis)
   - [Ranking Analyses](#ranking-analyses)
2. [How to Run This Project](#how-to-run-this-project)
3. [Future Enhancements](#future-enhancements)
4. [Conclusion](#conclusion)

---

## Data Analysis Queries

### Basic Data Exploration

Retrieve all records and check the overall date range.

```sql
-- Retrieve all records from the final layoffs table
SELECT *
FROM layoffs_final;

-- ***************************************************************
-- Analyze the date range of the dataset
-- (This analysis is done for dates between March 2020 and February 2023)
-- ***************************************************************

-- Find the minimum and maximum dates in the dataset
SELECT min(`date`), max(`date`)
FROM layoffs_final;
```

Compute aggregate metrics such as maximum and average layoffs.

```sql
-- ***************************************************************
-- Basic Aggregate Metrics for Total and Percentage Laid Off
-- ***************************************************************

-- Retrieve maximum and average values for total_laid_off and percentage_laid_off
SELECT max(total_laid_off), avg(total_laid_off), max(percentage_laid_off), avg(percentage_laid_off)
FROM layoffs_final;
```

---

### Analysis of 100% Layoffs (Complete Shutdowns)

Focus on companies that experienced complete layoffs (100%).

```sql
-- ***************************************************************
-- Top Records Where 100% of Employees Were Laid Off
-- ***************************************************************

-- Retrieve the top 10 records where 100% of employees (percentage_laid_off = 1) were laid off,
-- ordering by the highest total_laid_off first
SELECT *
FROM layoffs_final
WHERE percentage_laid_off = 1
ORDER BY total_laid_off DESC
LIMIT 10;
```

Calculate shutdown counts by month and year.

```sql
SELECT MONTH(`date`) AS month, YEAR(`date`) AS year, COUNT(company) as company_shutdown
FROM layoffs_final
WHERE percentage_laid_off = 1
GROUP BY month, year
ORDER BY company_shutdown DESC;
```

Expanded version with inline commentary:

```sql
-- Company Shutdowns by Month and Year
-- Calculate the number of companies that experienced a complete shutdown
SELECT MONTH(`date`) AS month, 
       YEAR(`date`) AS year, 
       COUNT(company) AS company_shutdown
FROM layoffs_final
WHERE percentage_laid_off = 1        -- Filter for 100% layoffs
GROUP BY month, year                 -- Group by month and year
ORDER BY company_shutdown DESC;      -- Order by number of shutdowns
```

Additional analysis based on funds raised:

```sql
-- Retrieve records where 100% of employees were laid off, ordered by funds_raised_millions
SELECT *
FROM layoffs_final
WHERE percentage_laid_off = 1
ORDER BY funds_raised_millions DESC;

-- Retrieve top 10 companies (with location and country) where 100% of employees were laid off,
-- ordered by funds_raised_millions in descending order
SELECT company, location, country, funds_raised_millions
FROM layoffs_final
WHERE percentage_laid_off = 1
ORDER BY funds_raised_millions DESC
LIMIT 10;
```

---

### Aggregations by Different Dimensions

#### By Company

Aggregate layoffs data at the company level.

```sql
-- ***************************************************************
-- Aggregations by Company
-- ***************************************************************

-- Sum total layoffs per company, ordered by highest sum first
SELECT company, sum(total_laid_off)
FROM layoffs_final
GROUP BY company
ORDER BY 2 DESC;

-- Calculate each company's layoffs, overall total layoffs, and percentage share
SELECT company, sum(total_laid_off),
(
  SELECT sum(total_laid_off)
  FROM layoffs_final
) AS total_layoff,
(sum(total_laid_off) / (
  SELECT sum(total_laid_off)
  FROM layoffs_final
) * 100) AS perc_of_total_layoff
FROM layoffs_final
GROUP BY company
ORDER BY 2 DESC
LIMIT 10;

-- Retrieve 5 companies with the smallest non-null layoffs totals
SELECT company, sum(total_laid_off)
FROM layoffs_final
GROUP BY company
HAVING sum(total_laid_off) IS NOT NULL
ORDER BY 2
LIMIT 5;
```

#### By Industry

Aggregate layoffs by industry to identify trends.

```sql
-- ***************************************************************
-- Aggregations by Industry
-- ***************************************************************

-- Sum total layoffs per industry, ordered by highest sum first
SELECT industry, sum(total_laid_off)
FROM layoffs_final
GROUP BY industry
ORDER BY 2 DESC;

-- For each industry, calculate total layoffs, overall total, and percentage share
SELECT industry, sum(total_laid_off),
(
  SELECT sum(total_laid_off)
  FROM layoffs_final
) AS total_layoff,
(sum(total_laid_off) / (
  SELECT sum(total_laid_off)
  FROM layoffs_final
) * 100) AS perc_of_total_layoff
FROM layoffs_final
GROUP BY industry
ORDER BY 2 DESC
LIMIT 5;

-- Sum layoffs per non-null industry, in ascending order (limit 5)
SELECT industry, sum(total_laid_off)
FROM layoffs_final
WHERE industry IS NOT NULL
GROUP BY industry
ORDER BY 2
LIMIT 5;
```

#### By Country

Analyze layoffs distribution across countries.

```sql
-- ***************************************************************
-- Aggregations by Country
-- ***************************************************************

-- Sum total layoffs per country, ordered by highest sum first
SELECT country, sum(total_laid_off)
FROM layoffs_final
GROUP BY country
ORDER BY 2 DESC;

-- For each country, compute total layoffs, overall total, and percentage share
SELECT country, sum(total_laid_off),
(
  SELECT sum(total_laid_off)
  FROM layoffs_final
) AS total_layoff,
(sum(total_laid_off) / (
  SELECT sum(total_laid_off)
  FROM layoffs_final
) * 100) AS perc_of_total_layoff
FROM layoffs_final
GROUP BY country
ORDER BY 2 DESC
LIMIT 5;

-- Sum layoffs per country with non-null values, in ascending order (limit 5)
SELECT country, sum(total_laid_off)
FROM layoffs_final
GROUP BY country
HAVING sum(total_laid_off) IS NOT NULL
ORDER BY 2
LIMIT 5;
```

#### By Stage

Determine how layoffs vary by the company stage.

```sql
-- ***************************************************************
-- Aggregations by Stage
-- ***************************************************************

-- For each stage, calculate total layoffs, overall total, and percentage share
SELECT stage, sum(total_laid_off),
(
  SELECT sum(total_laid_off)
  FROM layoffs_final
) AS total_layoff,
(sum(total_laid_off) / (
  SELECT sum(total_laid_off)
  FROM layoffs_final
) * 100) AS perc_of_total_layoff
FROM layoffs_final
GROUP BY stage
ORDER BY 2 DESC
LIMIT 5;

-- Sum layoffs per stage, filtering out null stage values (limit 5)
SELECT stage, sum(total_laid_off)
FROM layoffs_final
GROUP BY stage
HAVING sum(total_laid_off) AND stage IS NOT NULL
ORDER BY 2
LIMIT 5;
```

#### By Date, Year, and Month

Time-based breakdowns help identify trends over days, months, and years.

```sql
-- ***************************************************************
-- Aggregations by Date
-- ***************************************************************

-- Sum layoffs per date, ordered by highest totals first (limit 10)
SELECT `date`, sum(total_laid_off)
FROM layoffs_final
GROUP BY `date`
HAVING sum(total_laid_off) AND `date` IS NOT NULL
ORDER BY 2 DESC
LIMIT 10;

-- Sum layoffs per date, in ascending order (limit 5)
SELECT `date`, sum(total_laid_off)
FROM layoffs_final
GROUP BY `date`
HAVING sum(total_laid_off) AND `date` IS NOT NULL
ORDER BY 2
LIMIT 5;
```

Breakdown by year and month:

```sql
-- ***************************************************************
-- Aggregations by Year and Month
-- ***************************************************************

-- Sum total layoffs per year, filtering out null years, ordered by highest sum
SELECT YEAR(`date`) AS year, sum(total_laid_off)
FROM layoffs_final
GROUP BY year
HAVING year IS NOT NULL
ORDER BY 2 DESC;

-- For each month, calculate totals and percentage share
SELECT MONTH(`date`) AS month, sum(total_laid_off),
(
  SELECT sum(total_laid_off)
  FROM layoffs_final
) AS total_layoff,
(sum(total_laid_off) / (
  SELECT sum(total_laid_off)
  FROM layoffs_final
) * 100) AS perc_of_total_layoff
FROM layoffs_final
GROUP BY month
HAVING month IS NOT NULL
ORDER BY 2 DESC;

-- For each year and month combination, calculate totals and percentage share
SELECT MONTH(`date`) AS month, YEAR(`date`) AS year, sum(total_laid_off),
(
  SELECT SUM(total_laid_off)
  FROM layoffs_final
) AS total_layoff,
(SUM(total_laid_off) / (
  SELECT SUM(total_laid_off)
  FROM layoffs_final
) * 100) AS perc_of_total_layoff
FROM layoffs_final
GROUP BY year, month
HAVING month IS NOT NULL AND year IS NOT NULL
ORDER BY 3 DESC;
```

---

### Rolling Totals Analysis

Compute a rolling (cumulative) total of layoffs over time.

```sql
-- ***************************************************************
-- Rolling Total Calculation by Month and Year
-- ***************************************************************

-- Calculate monthly totals and a rolling (cumulative) total ordered by year and month
SELECT 
    month, 
    year, 
    monthly_total,
    SUM(monthly_total) OVER (ORDER BY year, month) AS rolling_total,
    total_layoff
FROM (
    SELECT 
        MONTH(`date`) AS month, 
        YEAR(`date`) AS year,
        SUM(total_laid_off) AS monthly_total,
        (SELECT SUM(total_laid_off) FROM layoffs_final) AS total_layoff
    FROM layoffs_final
    WHERE `date` IS NOT NULL
    GROUP BY YEAR(`date`), MONTH(`date`)
) AS sub
ORDER BY year, month;
```

---

### Ranking Analyses

#### Ranking Companies by Monthly Layoffs

Rank companies based on their monthly layoffs overall.

```sql
-- ***************************************************************
-- Ranking Companies by Monthly Layoffs (Overall)
-- ***************************************************************

-- Rank companies based on their monthly layoffs (not partitioned by month)
WITH SUB AS (
    SELECT company, MONTH(`date`) AS month, YEAR(`date`) AS year,
           SUM(total_laid_off) AS monthly_layoff,
           (SELECT SUM(total_laid_off) FROM layoffs_final) AS total_layoff
    FROM layoffs_final
    GROUP BY company, year, month
    HAVING SUM(total_laid_off) IS NOT NULL
    ORDER BY 4 DESC
)
SELECT
    DENSE_RANK() OVER(ORDER BY monthly_layoff DESC) AS rankings, 
    company, month, year, monthly_layoff
FROM SUB;
```

#### Ranking Companies by Yearly Layoffs

Rank companies based on total layoffs in a year.

```sql
-- ***************************************************************
-- Ranking Companies by Yearly Layoffs
-- ***************************************************************

-- Rank companies based on yearly layoffs overall
WITH SUB AS (
    SELECT company, YEAR(`date`) AS year,
           SUM(total_laid_off) AS yearly_layoff,
           (SELECT SUM(total_laid_off) FROM layoffs_final) AS total_layoff
    FROM layoffs_final
    GROUP BY company, year
    HAVING SUM(total_laid_off) IS NOT NULL
    ORDER BY 3 DESC
)
SELECT
    DENSE_RANK() OVER(ORDER BY yearly_layoff DESC) AS rankings, 
    company, year, yearly_layoff
FROM SUB;
```

#### Top-Ranked Companies by Year (Top 5 per Year)

Identify the top 5 companies each year based on layoffs.

```sql
-- ***************************************************************
-- Ranking Companies by Yearly Layoffs Per Year (Top 5 per Year)
-- ***************************************************************

-- Rank companies by yearly layoffs for each year, and select the top 5 companies per year
WITH SUB AS (
    SELECT company, YEAR(`date`) AS year,
           SUM(total_laid_off) AS yearly_layoff,
           (SELECT SUM(total_laid_off) FROM layoffs_final) AS total_layoff
    FROM layoffs_final
    GROUP BY company, year
    HAVING SUM(total_laid_off) IS NOT NULL
    ORDER BY 3 DESC
), company_rank AS (
    SELECT
        DENSE_RANK() OVER(PARTITION BY year ORDER BY yearly_layoff DESC) AS rankings, 
        company, year, yearly_layoff
    FROM SUB
    WHERE year IS NOT NULL
)
SELECT *
FROM company_rank
WHERE rankings <= 5;

-- If a pre-defined CTE named 'company_rank' exists, you can also retrieve:
SELECT *
FROM company_rank
WHERE rankings <= 5;
```

#### Ranking Industries by Yearly Layoffs (Top 5 per Year)

Rank industries on an annual basis.

```sql
-- ***************************************************************
-- Top 5 Industries by Yearly Layoffs
-- ***************************************************************

-- Rank industries based on their total layoffs each year and select the top 5 industries per year.
WITH SUB AS (
    SELECT industry, 
           YEAR(`date`) AS year,
           SUM(total_laid_off) AS yearly_layoff,
           (SELECT SUM(total_laid_off) FROM layoffs_final) AS total_layoff 
    FROM layoffs_final
    GROUP BY industry, year             
    HAVING SUM(total_laid_off) IS NOT NULL  
), 
ind_rank AS (
    SELECT DENSE_RANK() OVER (PARTITION BY year ORDER BY yearly_layoff DESC) AS rankings, 
           industry, 
           year, 
           yearly_layoff
    FROM SUB
    WHERE year IS NOT NULL             
)
SELECT *
FROM ind_rank
WHERE rankings <= 5;
```

#### Ranking Countries by Yearly Layoffs (Top 5 per Year)

Rank countries annually by layoffs.

```sql
-- ***************************************************************
-- Top 5 Countries by Yearly Layoffs
-- ***************************************************************

-- Rank countries based on their total layoffs each year and select the top 5 countries per year.
WITH SUB AS (
    SELECT country, 
           YEAR(`date`) AS year,
           SUM(total_laid_off) AS yearly_layoff,
           (SELECT SUM(total_laid_off) FROM layoffs_final) AS total_layoff  
    FROM layoffs_final
    GROUP BY country, year             
    HAVING SUM(total_laid_off) IS NOT NULL  
    ORDER BY yearly_layoff DESC        
), 
coun_rank AS (
    SELECT DENSE_RANK() OVER (PARTITION BY year ORDER BY yearly_layoff DESC) AS rankings, 
           country, 
           year, 
           yearly_layoff
    FROM SUB
    WHERE year IS NOT NULL             
)
SELECT *
FROM coun_rank
WHERE rankings <= 5;
```

---

## How to Run This Project

1. **Clone the Repository:**  
   Download or clone this repository to your local machine.

2. **Set Up Your SQL Environment:**  
   Ensure you are using MySQL 8.0 or later (for CTE and window function support). Create and populate the `layoffs_final` table with the prepared data.

3. **Execute the SQL Script:**  
   Run the complete SQL script (for example, in a file named `layoffs_analysis.sql`) using your preferred SQL client. The queries will generate various result sets that provide insights into the layoffs data.

---

## Future Enhancements To Consider

- **Advanced Visualizations:**  
  Integrate outputs with visualization tools such as Tableau or Power BI to create interactive dashboards.

- **Enhanced Metrics:**  
  Incorporate additional KPIs or predictive analytics to forecast future layoff trends.

---

## Conclusion

This competitor layoff data analysis—covering the period from **March 2020 to February 2023**—provides critical insights into market dynamics and workforce reductions. Nearly **386,379** employees were laid off during this period, with companies, on average, reducing their workforce by **238** employees (or **25.92%**). High-profile complete shutdowns, particularly among well-funded companies like Katerra, Britishvolt, Quibi, and Deliveroo Australia, highlight the unpredictable nature of the market.

Key findings indicate:
- **Temporal Variations:** Peaks in shutdowns occurred in November 2022 and throughout 2022, with early 2023 already showing significant activity.
- **Industry and Geographic Concentration:** The consumer sector, along with the United States and India, bore the highest impact.
- **Lifecycle Vulnerabilities:** Post-IPO and seed-stage companies were particularly affected, suggesting that maturity and funding stage play a crucial role in workforce stability.
- **Seasonal Trends:** Strategic workforce planning is essential given the varying monthly layoff volumes.

These insights provide a roadmap for stakeholders to build more resilient business strategies, optimize workforce planning, and adapt to ongoing market challenges.
