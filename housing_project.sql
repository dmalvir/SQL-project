---- Data cleaning in SQL queries---
--- To show all the data---

SELECT * 
FROM `Real estate project`.nashvile_housing;



---- populate Property Address data ---

select *
FROM `Real estate project`.nashvile_housing
where PropertyAddress is null
order by ParcelID;
--- Result: There is no null values



--- Analysing the data--
--- To see ParcelID, SaleDate, OwnerName, PropertyAddress, SalePrice date 

SELECT ParcelID, SaleDate, OwnerName, PropertyAddress, SalePrice
FROM `Real estate project`.nashvile_housing;



--- Find out the number of saling properties in 2016 

select SaleDate
FROM `Real estate project`.nashvile_housing
where SaleDate = 2016 
order by SaleDate;
--- Result: 14075 properties were sold


--- How many properties were sold in june 2016?
select SaleDate
FROM `Real estate project`.nashvile_housing
where SaleDate between '2016-06-01' and '2016-06-30';
--- Result: 1888 properties were sold


--- specified how many properties were sold and how much was yearly saleing amount

select SaleDate Year_ID,
sum(SalePrice),
count(SaleDate)
FROM `Real estate project`.nashvile_housing
where SaleDate = 2016;
--- Result: In 2016, 14075 properties were sold and yearly revenue was $4.237 billion

select SaleDate Year_ID,
sum(SalePrice),
count(SaleDate)
FROM `Real estate project`.nashvile_housing
where SaleDate = 2015;
--- Result: In 2015, 16917 properties were sold and yearly revenue was $6.733billion

select SaleDate Year_ID,
sum(SalePrice),
count(SaleDate)
FROM `Real estate project`.nashvile_housing
where SaleDate = 2014;
--- Result: In 2014, 14297 properties were sold and yearly revenue was $4.775 billion

select SaleDate Year_ID,
sum(SalePrice),
count(SaleDate)
FROM `Real estate project`.nashvile_housing
where SaleDate = 2013;
--- Result: In 2013, 11347 properties were sold and yearly revenue was $2.785 billion


--- How many properties were sold and how much is total saleing amount
select sum(SalePrice),
count(SaleDate)
FROM `Real estate project`.nashvile_housing
where SaleDate > '2013-01-01' and SaleDate < '2016-12-31';
--- Result: 56636 properties were sold and total amount is $18.531 billion 

--- Spliting date format

SELECT 
    DAY(SaleDate) AS DAY,
    MONTH(SaleDate) AS MONTH,
    YEAR(SaleDate) AS YEAR
FROM `Real estate project`.nashvile_housing;


--- To split date by year, month and day

SELECT 
EXTRACT(YEAR FROM SaleDate) AS year,
EXTRACT(MONTH FROM SaleDate) AS month,
EXTRACT(DAY FROM SaleDate) AS day
FROM `Real estate project`.nashvile_housing
ORDER BY Year ASC;


-- Now I am tring to split the date in a separate column for example year, month and day.

ALTER TABLE `Real estate project`.nashvile_housing
ADD Year varchar (50);
UPDATE `Real estate project`.nashvile_housing
SET Year = year(SaleDate);

ALTER TABLE `Real estate project`.nashvile_housing
ADD Month varchar (50);
UPDATE `Real estate project`.nashvile_housing
SET Month = month(SaleDate);

ALTER TABLE `Real estate project`.nashvile_housing
ADD Day varchar (50);
UPDATE `Real estate project`.nashvile_housing
SET Day = Day(SaleDate);

--- To find out total selling amount by year to year

Select Year, sum(SalePrice) Total_sale_2016
FROM `Real estate project`.nashvile_housing
where year = 2016 -- change year to see the rest
group by Year ;

--- What was the best month for sales in a specific year? How much was earned that month? 
Select month, max(SalePrice) max_sale_month
FROM `Real estate project`.nashvile_housing
where year = 2016 -- change year to see the rest
group by month
order by 2 desc;
--- Result: September seems to be the month, they sold 5 million dollars. On November and December 2016  they did not sell any property.

Select OwnerName, min(SalePrice) Min_price
FROM `Real estate project`.nashvile_housing
where year = 2015
group by OwnerName
order by Min_price asc;


-- which date has the most frequent sales?

select SaleDate, count(1) as sales_count, sum(SalePrice) as Sum_sales
FROM `Real estate project`.nashvile_housing
group by SaleDate
order by sales_count desc
limit 10;
--- Result: The maximum number of sales for one day is 305 with a total price of  near around 110 M.


--- Which city has the highest average price per sales?

Select PropertyCity, avg(SalePrice) as price_avg , count(1) as sales_count
FROM `Real estate project`.nashvile_housing
group by PropertyCity
order by price_avg desc;
--- Result: There is a total of 40280 sales in Nashville city with an average price of $366304.


--- which year has the lowest number of sales?

Select PropertyCity, avg(SalePrice) as price_avg , count(1) as sales_count
FROM `Real estate project`.nashvile_housing
group by PropertyCity
order by price_avg asc;
--- Result: There is a sales in BELLEVUE city with an average price of $25000.



