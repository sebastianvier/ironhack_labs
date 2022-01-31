use sakila;

USE SAKILA;

/*
In this lab, you will be using the [Sakila]
(https://dev.mysql.com/doc/sakila/en/) database of movie rentals.

### Instructions
*/

-- 1. Get number of monthly active customers.

## Monthly active customers is the number of
## customers who has rentend something during a month.

## Join customer with rentals
select * 
from customer c
join rental r
on c.customer_id = r.customer_id;

## Add a month column and a year column
## Find customer per month.
select date_format(rental_date, '%m') month,
date_format(rental_date, '%Y') year,
count(distinct(c.customer_id)) active_customers
from customer c
join rental r
on c.customer_id = r.customer_id
GROUP BY YEAR, MONTH;
## I can see that we have mostly customers 
## in 2005 and 154 in 2006 and that there is 
## Only 1 in 2021 (not really sure why)



-- 2. Active users in the previous month.

## Just create a cte for the model
with active_per_month as (select date_format(rental_date, '%m') month,
date_format(rental_date, '%Y') year,
count(distinct(c.customer_id) ) active_customers
from customer c
join rental r
on c.customer_id = r.customer_id
GROUP BY YEAR, MONTH) 
select * from active_per_month;

## Turn the * into the three columns we are going to search on
with active_per_month as (select date_format(rental_date, '%m') month,
date_format(rental_date, '%Y') year,
count(distinct(c.customer_id)) active_customers
from customer c
join rental r
on c.customer_id = r.customer_id
GROUP BY YEAR, MONTH) 
select year, month, active_customers,
lag(active_customers, 1) over (order by year, month) last_month
from active_per_month;

## For some reason partion by year doesn't get me the correct
## answer. The idea to understand this is what is the difference between the other.


-- 3. Percentage change in the number of active customers.
-- 4. Retained customers every month.

with cte_last_month as 
(
with active_per_month as (select date_format(rental_date, '%m') month,
date_format(rental_date, '%Y') year,
count(distinct(c.customer_id)) active_customers
from customer c
join rental r
on c.customer_id = r.customer_id
GROUP BY YEAR, MONTH) 
select year, month, active_customers,
lag(active_customers, 1) over (order by year, month) last_month
from active_per_month
)
select year, month, active_customers, last_month, 
## percentage change
round((abs(last_month - active_customers)/ active_customers),2) percentage_change
## Retained customers
,(active_customers - last_month) as retained_customers
 from cte_last_month
where last_month is not null and year = 2005;