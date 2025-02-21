-- Retrieve all records from the final layoffs table
SELECT *
FROM layoffs_final;

-- ***************************************************************
-- Analyze the date range of the dataset
-- (This analysis is done for dates between 2020-01-04 and 2023-12-02)
-- ***************************************************************

-- Find the minimum and maximum dates in the dataset
SELECT min(`date`), max(`date`)
FROM layoffs_final;

-- ***************************************************************
-- Basic Aggregate Metrics for Total and Percentage Laid Off
-- ***************************************************************

-- Retrieve maximum and average values for total_laid_off and percentage_laid_off
SELECT max(total_laid_off), avg(total_laid_off), max(percentage_laid_off), avg(percentage_laid_off)
FROM layoffs_final;

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


-- Company Shutdowns by Month and Year
-- Calculate the number of companies that experienced a complete shutdown
SELECT MONTH(`date`) AS month, 
       YEAR(`date`) AS year, 
       COUNT(company) AS company_shutdown
FROM layoffs_final
WHERE percentage_laid_off = 1       
GROUP BY month, year                 
ORDER BY company_shutdown DESC;

SELECT 
       YEAR(`date`) AS year, 
       COUNT(company) AS company_shutdown
FROM layoffs_final
WHERE percentage_laid_off = 1       
GROUP BY year                 
ORDER BY company_shutdown DESC;

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

-- ***************************************************************
-- Aggregations by Company
-- ***************************************************************

-- Sum the total layoffs per company, ordered by the highest sum first
SELECT company, sum(total_laid_off)
FROM layoffs_final
GROUP BY company
ORDER BY 2 DESC;

-- For each company, calculate:
-- - the total layoffs per company,
-- - the overall total layoffs (via a scalar subquery),
-- - and the percentage share of total layoffs.
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

-- Retrieve the 5 companies with the smallest non-null sum of layoffs
SELECT company, sum(total_laid_off)
FROM layoffs_final
GROUP BY company
HAVING sum(total_laid_off) IS NOT NULL
ORDER BY 2
LIMIT 5;

-- ***************************************************************
-- Aggregations by Industry
-- ***************************************************************

-- Sum the total layoffs per industry, ordered by the highest sum first
SELECT industry, sum(total_laid_off)
FROM layoffs_final
GROUP BY industry
ORDER BY 2 DESC;

-- For each industry, calculate:
-- - the total layoffs per industry,
-- - the overall total layoffs,
-- - and the percentage share of total layoffs.
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

-- Sum total layoffs per non-null industry, ordered in ascending order (limit 5)
SELECT industry, sum(total_laid_off)
FROM layoffs_final
WHERE industry IS NOT NULL
GROUP BY industry
ORDER BY 2
LIMIT 5;

-- ***************************************************************
-- Aggregations by Country
-- ***************************************************************

-- Sum the total layoffs per country, ordered by highest sum first
SELECT country, sum(total_laid_off)
FROM layoffs_final
GROUP BY country
ORDER BY 2 DESC;

-- For each country, calculate:
-- - the total layoffs per country,
-- - the overall total layoffs,
-- - and the percentage share of total layoffs.
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

-- Sum total layoffs per country with non-null values, ordered in ascending order (limit 5)
SELECT country, sum(total_laid_off)
FROM layoffs_final
GROUP BY country
HAVING sum(total_laid_off) IS NOT NULL
ORDER BY 2
LIMIT 5;

-- ***************************************************************
-- Aggregations by Stage
-- ***************************************************************

-- For each stage, calculate:
-- - the total layoffs,
-- - the overall total layoffs,
-- - and the percentage share of total layoffs.
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

-- For each stage, calculate:
-- the average percemtage of layoffs,

SELECT stage, avg(percentage_laid_off)
FROM layoffs_final
WHERE percentage_laid_off IS NOT NULL
GROUP BY stage
ORDER BY 2 DESC
LIMIT 5;

-- Sum total layoffs per stage, filtering out null stage values (limit 5)
SELECT stage, sum(total_laid_off)
FROM layoffs_final
GROUP BY stage
HAVING sum(total_laid_off) AND stage IS NOT NULL
ORDER BY 2
LIMIT 5;

-- ***************************************************************
-- Aggregations by Date
-- ***************************************************************

-- Sum total layoffs for each date, filtering out null dates, ordered by highest sum first (limit 10)
SELECT `date`, sum(total_laid_off)
FROM layoffs_final
GROUP BY `date`
HAVING sum(total_laid_off) AND `date` IS NOT NULL
ORDER BY 2 DESC
LIMIT 10;

-- Sum total layoffs for each date, filtering out null dates, ordered by sum in ascending order (limit 5)
SELECT `date`, sum(total_laid_off)
FROM layoffs_final
GROUP BY `date`
HAVING sum(total_laid_off) AND `date` IS NOT NULL
ORDER BY 2
LIMIT 5;

-- ***************************************************************
-- Aggregations by Year and Month
-- ***************************************************************

-- Sum total layoffs per year, filtering out null years, ordered by highest sum first
-- - and the percentage share of total layoffs.
SELECT YEAR(`date`) AS year, sum(total_laid_off),
(sum(total_laid_off) / (
  SELECT sum(total_laid_off)
  FROM layoffs_final
) * 100) AS perc_of_total_layoff
FROM layoffs_final
GROUP BY year
HAVING year IS NOT NULL
ORDER BY 2 DESC;

-- For each month, calculate:
-- - the total layoffs,
-- - the overall total layoffs,
-- - and the percentage share of total layoffs.
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

-- For each year and month combination, calculate:
-- - the total layoffs,
-- - the overall total layoffs,
-- - and the percentage share of total layoffs.
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

-- ***************************************************************
-- Aggregations and Rolling Totals by Company and Month
-- ***************************************************************

-- Calculate monthly layoffs per company along with a rolling total (using a subquery/CTE)
WITH SUB AS (
    SELECT company, MONTH(`date`) AS month, YEAR(`date`) AS year,
           SUM(total_laid_off) AS monthly_layoff,
           (SELECT SUM(total_laid_off) FROM layoffs_final) AS total_layoff
    FROM layoffs_final
    GROUP BY company, year, month
    HAVING SUM(total_laid_off) IS NOT NULL
    ORDER BY 4 DESC
)
SELECT company, month, year, monthly_layoff,
       SUM(monthly_layoff) OVER(ORDER BY monthly_layoff DESC) AS rolling_total,
       total_layoff
FROM SUB;

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


-- Top 5 Industries by Yearly Layoffs
-- Rank industries based on their total layoffs each year and selects the top 5 industries per year.

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
    -- Next, rank the industries within each year using DENSE_RANK.
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


-- Top 5 Countries by Yearly Layoffs
-- Rank countries based on their total layoffs each year and selects the top 5 countries per year.

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


