##Create Database (GlobalLayoffs)##

##Import Data to table Layoffs_Raw##

##Create staging table Layoffs##

##Removing Duplicates##

select *
from globallayoffs.layoffs;

select *,
row_number() over(
partition by company, industry, total_laid_off, percentage_laid_off, `date`)
as row_num
from globallayoffs.layoffs;

with duplicate_cte as
(
select *,
row_number() over(
partition by company, industry, total_laid_off, percentage_laid_off, `date`,
stage, country, funds_raised_millions)
as row_num
from globallayoffs.layoffs
)

select *
from duplicate_cte
where row_num > 1;

select *
from globallayoffs.layoffs
where company = 'Casper';


CREATE TABLE `layoffs2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` text,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` text,
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


insert globallayoffs.layoffs2
select *,
row_number() over(
partition by company, industry, total_laid_off, percentage_laid_off, `date`,
stage, country, funds_raised_millions)
as row_num
from globallayoffs.layoffs;

delete
from globallayoffs.layoffs2
where row_num>1;


##Standardizing Data##

select (trim(company))
from globallayoffs.layoffs2;

update globallayoffs.layoffs2
set company = trim(company);

update globallayoffs.layoffs2
set industry = 'Crypto'
where industry like 'Crypto%';

select distinct country, trim(trailing '.' from country)
from globallayoffs.layoffs2
order by 1;


update globallayoffs.layoffs2
set country = trim(trailing '.' from country)
where country like 'United States%';


select `date`
from globallayoffs.layoffs2;


select `date`,
str_to_date(`date`, '%m/%d/%Y')
from globallayoffs.layoffs2;

update globallayoffs.layoffs2
set `date` = str_to_date(`date`, '%m/%d/%Y');

alter table globallayoffs.layoffs2
modify column `date` date;

##Null/Blank Values##

select *
from globallayoffs.layoffs2;

update globallayoffs.layoffs2
set total_laid_off = null
where total_laid_off like '%null%';

select *
from globallayoffs.layoffs2
where total_laid_off is null;

update globallayoffs.layoffs2
set percentage_laid_off = null
where percentage_laid_off like '%null%';

select *
from globallayoffs.layoffs2
where total_laid_off is null
and percentage_laid_off is null;

select distinct industry
from globallayoffs.layoffs2;

update globallayoffs.layoffs2
set industry = null
where industry like '%null%';


update globallayoffs.layoffs2
set industry = null
where industry = '';

select *
from globallayoffs.layoffs2
where industry is null
or industry = '';

select *
from globallayoffs.layoffs2 t1
join globallayoffs.layoffs2 t2
	on t1.company= t2.company
where (t1.industry is null or t1.industry = '')
and t2.industry is not null;

update globallayoffs.layoffs2 t1
join globallayoffs.layoffs2 t2
	on t1.company= t2.company
set t1.industry = t2.industry
where (t1.industry is null or t1.industry = '')
and t2.industry is not null;

select t1.industry, t2.industry
from globallayoffs.layoffs2 t1
join globallayoffs.layoffs2 t2
	on t1.company= t2.company
where t1.industry is null
and t2.industry is not null;

select *
from globallayoffs.layoffs2
where company = 'Airbnb';


select *
from globallayoffs.layoffs2;

delete 
from globallayoffs.layoffs2
where total_laid_off is null
and percentage_laid_off is null;


select * 
from globallayoffs.layoffs2
where total_laid_off is null
and percentage_laid_off is null;

select *
from globallayoffs.layoffs2;

 alter table globallayoffs.layoffs2
 drop column row_num;

select *
from globallayoffs.layoffs2;