use sakila;

-- 1. How many distinct (different) actors' last names are there?

select count(distinct(last_name)) from actor;

-- 2. In how many different languages where the films originally produced? 
-- (Use the column `language_id` from the `film` table)

select count(distinct(language_id)) as number_of_languages from film;
-- There is only one language

select count(distinct(original_language_id)) as number_of_languages from film;
-- There are non values in original_language_id

-- 3. How many movies were released with `"PG-13"` rating?

SELECT 
	count(rating) as number_of_PG_13_S
FROM
    film
where rating="PG-13";

-- 4. Get 10 the longest movies from 2006.
SELECT 
    film_id, title, length, release_year
FROM
    film
Where release_year = 2006
ORDER BY length DESC, title
LIMIT 10;


-- 5. How many days has been the company 
-- operating (check `DATEDIFF()` function)?

select * from rental;
-- check for what columns I can use to check 
-- the days of operation

select max(last_update) from  rental;
select min(rental_date) from  rental;

SELECT 
    DATEDIFF(MAX(last_update), MIN(rental_date)) AS days_of_operation
FROM
    rental;

-- I think that makes sense that the operation started the first day rented
-- and ended the last update.



-- 6. Show rental info with additional 
-- columns month and weekday. Get 20.

SELECT 
    * , MONTHNAME(rental_date), DAYNAME(rental_date)
FROM
    rental;
    
-- month name gets the name of the month given a data type and dayname 
-- gives the name of the week

-- 7. Add an additional column `day_type` with values 'weekend' and 'workday'
--  depending on the rental day of the week.

select distinct(DAYNAME(rental_date)) from rental;

select *, 
case when DAYNAME(rental_date) in ("Saturday", "Sunday") THEN "weekend" 
else "workday" end as 'day_type' 
from rental;

-- We use a case for determine wether is weekend or not.


-- 8. How many rentals were in the last month of activity?

-- There are two ways to think about this question. 
-- The first one is to think that the month is the last month name.

select monthname(MAX(last_update)) from rental;

-- using just this will have the inconvenient that there could be 
-- more than one year.

select year(max(last_update)) from rental;

select count(*) from rental 
where year(rental_date) = (select max(year(last_update)) from rental)
and monthname(rental_date) = (select max(monthname(last_update)) from rental);

-- here we use nested queries to get the numbers we are looking for.

-- The other way to think about this problem is that
-- a month is just the last 30 days.

SELECT 
    *
FROM
    rental
WHERE
    rental_date > (SELECT 
            DATE_ADD((SELECT 
                            MAX(last_update)
                        FROM
                            rental),
                    INTERVAL - 30 DAY)
        ) order by rental_date;
        
-- The tricky part with this second problem is 
-- how do you get 30 days. Luckily there is the function
-- date_add that does this for us. :)
