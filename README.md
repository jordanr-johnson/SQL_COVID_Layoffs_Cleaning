# 📉 Global Layoffs Data Cleaning Project (MySQL Workbench)

This project demonstrates my ability to clean and prepare real-world layoff data using SQL in MySQL Workbench. The goal was to transform messy, duplicate, and inconsistent layoff data into a clean, standardized table ready for analysis.

---

## 🧰 Tools Used

- MySQL Workbench
- SQL (CTEs, window functions, string manipulation, date conversion, null conversions)

---

## 📂 Process Overview

### 1. 🗃️ Create and Import

- Created the `GlobalLayoffs` database and imported raw data into a staging table `layoffs`.

### 2. 🧼 Removing Duplicates

- Used a `ROW_NUMBER()` window function to identify exact duplicates.
- Inserted de-duplicated records into a new table `layoffs2`.
- Deleted rows where `row_num > 1`.

### 3. 🧽 Standardizing Data

- Removed leading/trailing whitespace using `TRIM()`.
- Standardized inconsistent industry and country names (e.g., `'Crypto Currency/Cryptocurrency' → 'Crypto'`, `'United States.' → 'United States'`).
- Converted the `date` column from `TEXT` to `DATE` format using `STR_TO_DATE()` and then modified the column type.

### 4. 🚫 Handling Null/Blank Values

- Replaced `'null'` strings and blanks with actual `NULL` values in `total_laid_off`, `percentage_laid_off`, and `industry`.
- Imputed missing `industry` values by joining on matching `company` names that had valid values.
- Deleted records where both `total_laid_off` and `percentage_laid_off` were null (incomplete data).

### 5. 🧹 Final Cleanup

- Dropped the helper column `row_num`.
- Verified the integrity and completeness of the cleaned `layoffs2` table.

---

## ✅ Final Output

A fully cleaned and standardized SQL table `layoffs2` ready for:
- Visualization in BI tools (Power BI, Tableau)
- Exploratory data analysis (EDA)
- Business insights on layoff trends by industry, geography, and time

---

## 🔗 Notes

This project reflects key SQL data cleaning techniques including:
- Deduplication with window functions
- String cleaning and pattern replacement
- Null handling and data imputation
- Date formatting and type conversion

Feel free to explore the code in `SQL_Layoffs_Code.sql` or reach out with questions!
