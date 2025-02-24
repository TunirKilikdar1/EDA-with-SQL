-- Select all records from the 'layoffs' table
SELECT * 
FROM layoffs;

-- Create a backup table 'layoffs_bk' with the same structure as 'layoffs'
CREATE TABLE layoffs_bk
LIKE layoffs;

-- Insert all records from 'layoffs' into 'layoffs_bk'
INSERT INTO layoffs_bk
SELECT * 
FROM layoffs;

-- Remove duplicate records based on specific columns
WITH dupl_cte AS (
    SELECT *,
           ROW_NUMBER() OVER(PARTITION BY company, location, industry, total_laid_off, 
                             percentage_laid_off, `date`, stage, country, funds_raised_millions 
                             ORDER BY (SELECT NULL)) AS row_num
    FROM layoffs_bk
)
-- Select duplicate records (row_num > 1) for review
SELECT *
FROM dupl_cte
WHERE row_num > 1;

-- Create a new table 'layoffs_bk2' with an additional 'row_num' column
CREATE TABLE layoffs_bk2 (
  company TEXT,
  location TEXT,
  industry TEXT,
  total_laid_off INT DEFAULT NULL,
  percentage_laid_off TEXT,
  `date` TEXT,
  stage TEXT,
  country TEXT,
  funds_raised_millions INT DEFAULT NULL,
  row_num INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Insert records into 'layoffs_bk2' with a row number for each partition of duplicates
INSERT INTO layoffs_bk2
SELECT *,
       ROW_NUMBER() OVER(PARTITION BY company, location, industry, total_laid_off, 
                         percentage_laid_off, `date`, stage, country, funds_raised_millions 
                         ORDER BY (SELECT NULL)) AS row_num
FROM layoffs_bk;

-- Delete duplicate records, keeping only the first occurrence
DELETE
FROM layoffs_bk2
WHERE row_num > 1;

-- Verify the contents of 'layoffs_bk2' after deletion
SELECT *
FROM layoffs_bk2;

-- Standardize data by trimming whitespace from the 'company' column
UPDATE layoffs_bk2
SET company = TRIM(company);

-- Review distinct 'industry' values to identify inconsistencies
SELECT DISTINCT industry
FROM layoffs_bk2
ORDER BY industry;

-- Identify records where 'industry' starts with 'Crypto'
SELECT *
FROM layoffs_bk2
WHERE industry LIKE 'Crypto%';

-- Standardize 'industry' values by removing the word 'Currency' and trimming whitespace
UPDATE layoffs_bk2
SET industry = TRIM(REPLACE(industry, 'Currency', ''));

-- Review distinct 'country' values and their trimmed versions
SELECT DISTINCT country, TRIM(TRAILING '.' FROM country) AS trimmed_country
FROM layoffs_bk2
ORDER BY country;

-- Standardize 'country' names by removing trailing periods for entries starting with 'United states'
UPDATE layoffs_bk2
SET country = TRIM(TRAILING '.' FROM country)
WHERE country LIKE 'United states%';

-- Convert 'date' values from 'MM/DD/YYYY' format to 'YYYY-MM-DD' format
UPDATE layoffs_bk2
SET `date` = CASE 
    WHEN `date` LIKE '%/%/%' THEN STR_TO_DATE(`date`, '%m/%d/%Y')
    ELSE `date`
END;

-- Modify the 'date' column to enforce DATE data type
ALTER TABLE layoffs_bk2
MODIFY COLUMN `date` DATE;

-- Identify records with NULL 'total_laid_off' and 'percentage_laid_off' values
SELECT *
FROM layoffs_bk2
WHERE total_laid_off IS NULL
  AND percentage_laid_off IS NULL;

-- Delete records where both 'total_laid_off' and 'percentage_laid_off' are NULL
DELETE 
FROM layoffs_bk2
WHERE total_laid_off IS NULL
  AND percentage_laid_off IS NULL;

-- Identify records with NULL or empty 'industry' values
SELECT *
FROM layoffs_bk2
WHERE industry IS NULL
   OR industry = '';

-- Review records for specific companies to determine appropriate 'industry' values
SELECT *
FROM layoffs_bk2
WHERE company = 'Airbnb';

SELECT *
FROM layoffs_bk2
WHERE company = "Bally's Interactive";

SELECT *
FROM layoffs_bk2
WHERE company = 'Carvana';

SELECT *
FROM layoffs_bk2
WHERE company = 'Juul';

-- Update 'industry' values based on 'company' names for specific cases
UPDATE layoffs_bk2
SET industry = CASE 
    WHEN company = 'Carvana' AND (industry = '' OR industry IS NULL) THEN 'Transportation'
    WHEN company = 'Juul' AND (industry = '' OR industry IS NULL) THEN 'Consumer'
    WHEN company = 'Airbnb' AND (industry = '' OR industry IS NULL) THEN 'Travel'
    ELSE industry
END
WHERE company IN ('Carvana', 'Juul', 'Airbnb');

-- Rename the cleaned and processed table to 'layoffs_final'
RENAME TABLE layoffs_bk2 TO layoffs_final;

-- Verify the contents of 'layoffs_final' after renaming
SELECT *
FROM layoffs_final;

-- Remove the 'row_num' column as it's no longer needed
ALTER TABLE layoffs_final
DROP COLUMN row_num;
