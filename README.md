#Exploritary Data Analysis Project With SQL

Part 1: SQL Data Cleaning and Standardization

## Project Overview

This project focuses on cleaning and standardizing a dataset related to company layoffs. The primary objectives are to remove duplicate records, standardize data formats, handle missing values, and ensure consistency across the dataset. The process involves creating backup tables, identifying and removing duplicates, standardizing textual data, formatting date fields, and addressing null values.

## Table of Contents

1. [Project Overview](#project-overview)
2. [Dataset Description](#dataset-description)
3. [Objectives](#objectives)
4. [Process Breakdown](#process-breakdown)
   - [1. Creating Backup Tables](#1-creating-backup-tables)
   - [2. Removing Duplicate Records](#2-removing-duplicate-records)
   - [3. Standardizing Textual Data](#3-standardizing-textual-data)
   - [4. Formatting Date Fields](#4-formatting-date-fields)
   - [5. Handling Null Values](#5-handling-null-values)
5. [Conclusion](#conclusion)

## Dataset Description

The dataset, named `layoffs`, contains information about company layoffs with the following columns:

- `company`: Name of the company
- `location`: Location of the company
- `industry`: Industry sector of the company
- `total_laid_off`: Number of employees laid off
- `percentage_laid_off`: Percentage of the workforce laid off
- `date`: Date of the layoff event
- `stage`: Stage of the company (e.g., Startup, Established)
- `country`: Country where the company is located
- `funds_raised_millions`: Funds raised by the company in millions

## Objectives

The main objectives of this project are:

- **Data Integrity**: Ensure that the dataset is free from duplicate records.
- **Consistency**: Standardize textual data to maintain uniformity.
- **Accuracy**: Correctly format date fields and handle missing or null values appropriately.
- **Preparation**: Prepare the dataset for further analysis or reporting.

## Process Breakdown

### 1. Creating Backup Tables

**Thought Process**: Before making any modifications, it's crucial to create backup copies of the original data. This ensures that the original dataset remains intact and provides a fallback option if needed.

**SQL Queries**:

```sql
-- Create a backup table 'layoffs_bk' with the same structure as 'layoffs'
CREATE TABLE layoffs_bk LIKE layoffs;

-- Insert all records from 'layoffs' into 'layoffs_bk'
INSERT INTO layoffs_bk
SELECT * 
FROM layoffs;
```

### 2. Removing Duplicate Records

**Thought Process**: Duplicate records can skew analysis and insights. To identify duplicates, we use a Common Table Expression (CTE) with the `ROW_NUMBER()` window function, partitioning by all relevant columns. Records with a `row_num` greater than 1 are considered duplicates.

**SQL Queries**:

```sql
-- Identify duplicate records
WITH dupl_cte AS (
    SELECT *,
           ROW_NUMBER() OVER(PARTITION BY company, location, industry, total_laid_off, 
                             percentage_laid_off, `date`, stage, country, funds_raised_millions 
                             ORDER BY (SELECT NULL)) AS row_num
    FROM layoffs_bk
)
-- Select duplicate records for review
SELECT *
FROM dupl_cte
WHERE row_num > 1;

-- Create a new table 'layoffs_bk2' including the 'row_num' column
CREATE TABLE layoffs_bk2 AS
SELECT *,
       ROW_NUMBER() OVER(PARTITION BY company, location, industry, total_laid_off, 
                         percentage_laid_off, `date`, stage, country, funds_raised_millions 
                         ORDER BY (SELECT NULL)) AS row_num
FROM layoffs_bk;

-- Delete duplicate records, keeping only the first occurrence
DELETE
FROM layoffs_bk2
WHERE row_num > 1;
```

### 3. Standardizing Textual Data

**Thought Process**: Inconsistent textual data can lead to inaccuracies in analysis. Trimming whitespace and standardizing terms (e.g., removing variations like 'Currency' in the 'industry' column) ensures uniformity.

**SQL Queries**:

```sql
-- Trim whitespace from the 'company' column
UPDATE layoffs_bk2
SET company = TRIM(company);

-- Standardize 'industry' values by removing the word 'Currency' and trimming whitespace
UPDATE layoffs_bk2
SET industry = TRIM(REPLACE(industry, 'Currency', ''));
```

### 4. Formatting Date Fields

**Thought Process**: Dates in inconsistent formats can cause issues in temporal analyses. Converting all dates to the 'YYYY-MM-DD' format ensures consistency and compatibility with SQL date functions.

**SQL Queries**:

```sql
-- Convert 'date' values from 'MM/DD/YYYY' format to 'YYYY-MM-DD' format
UPDATE layoffs_bk2
SET `date` = CASE 
    WHEN `date` LIKE '%/%/%' THEN STR_TO_DATE(`date`, '%m/%d/%Y')
    ELSE `date`
END;

-- Modify the 'date' column to enforce DATE data type
ALTER TABLE layoffs_bk2
MODIFY COLUMN `date` DATE;
```

### 5. Handling Null Values

**Thought Process**: Records with missing critical information can hinder analysis. It's essential to identify such records and decide whether to populate the missing values or remove the records. In this case, records with both `total_laid_off` and `percentage_laid_off` as NULL are removed, as they lack essential information.

**SQL Queries**:

```sql
-- Delete records where both 'total_laid_off' and 'percentage_laid_off' are NULL
DELETE 
FROM layoffs_bk2
WHERE total_laid_off IS NULL
  AND percentage_laid_off IS NULL;
```

**Additional Handling**: For companies with missing 'industry' information, we can infer the industry based on the company name.

**SQL Query**:

```sql
-- Update 'industry' values based on 'company' names for specific cases
UPDATE layoffs_bk2
SET industry = CASE 
    WHEN company = 'Carvana' AND (industry = '' OR industry IS NULL) THEN 'Transportation'
    WHEN company = 'Juul' AND (industry = '' OR industry IS NULL) THEN 'Consumer'
    WHEN company = 'Airbnb' AND (industry = '' OR industry IS NULL) THEN 'Travel'
    ELSE industry
END
WHERE company IN ('Carvana', 'Juul', 'Airbnb');
```

### Finalizing the Cleaned Data

**Thought Process**: After cleaning and standardizing the data, it's prudent to rename the processed table to reflect its finalized state and remove any auxiliary columns used during processing.

**SQL Queries**:

```sql
-- Rename the cleaned and processed table to 'layoffs_final'
RENAME TABLE layoffs_bk2 TO layoffs_final;

-- Remove the 'row_num' column as it's no longer needed
ALTER TABLE layoffs_final
DROP COLUMN row_num;
```

## Conclusion

This project demonstrates a systematic approach to cleaning and standardizing a dataset using SQL. By creating backup tables, removing duplicates, standardizing textual data, formatting dates, and handling null values, we ensure the dataset's integrity and readiness for analysis. This process highlights the importance of data 
