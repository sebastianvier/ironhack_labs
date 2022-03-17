use Sakila;

select * from actor;

-- 1) Select the first name, last name, and email address of all 
-- the customers who have rented a movie.

select first_name, last_name, email, count(rental_id) from customer c
join rental r 
on r.customer_id = c.customer_id
group by first_name, last_name, email 
-- Actually here doesn't make a difference
-- By doing an inner join + a groupby I am getting all 
-- the customer_id with a rental_id 
order by count(rental_id);

-- 2) What is the average payment made by each customer (display the 
-- *customer id*, *customer name* 
-- (concatenated), and the *average payment made*).

with cte_1 as 
(select c.customer_id, concat(first_name, ' ',last_name) full_name, email from customer c 
-- It is cool you don't need to groupby by the whole concatenation.
join rental r 
on r.customer_id = c.customer_id
group by c.customer_id, first_name, last_name, email)
select  full_name, email, avg(amount) av_amount from cte_1 c
join payment p
on c.customer_id = p.customer_id
group by full_name, email
order by av_amount desc;


 -- 3) Select the *name* and *email* address of all the customers 
 -- who have rented the "Action" movies.

-- 1) Create a table with film_id where category = Action
select f.film_id category from film f
join film_category fc
on f.film_id = fc.film_id
join category c
on c.category_id = fc.category_id
where c.name = 'Action'
;

-- 2) Create a table that links film_id with customer.
select c.customer_id, concat(c.first_name,' ',c.last_name), i.film_id
from customer c
join rental r
on c.customer_id = r.customer_id
join inventory i
on r.inventory_id = i.inventory_id
order by c.customer_id;

-- 3) Connect the two tables
with cte_1 as (select f.film_id from film f
join film_category fc
on f.film_id = fc.film_id
join category c
on c.category_id = fc.category_id
where c.name = 'Action')
select c.customer_id, concat(c.first_name,' ',c.last_name) full_name
from customer c
join rental r
on c.customer_id = r.customer_id
join inventory i
on r.inventory_id = i.inventory_id
where i.film_id in (select film_id from cte_1)
group by c.customer_id 
order by c.customer_id;


--  4) Use the case statement to create a new column classifying
 -- existing columns as either or high value transactions based on the amount 
 -- of payment. 
 -- If the amount is between 0 and 2, label should be `low` and if 
 -- the amount is between 2 and 4, the label should be `medium`, and if it is more 
 -- than 4, then it should be `high`.
 
 select payment_id, customer_id, amount,
 case 
 when amount <= 2 then 'low'
 when amount <= 4 then 'medium'
 else 'high'
 end classification
 from payment;
