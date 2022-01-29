use sakila

-- 1. How many copies of the film _Hunchback Impossible_ exist 
-- in the inventory system?

select count(inventory_id) from inventory 
where film_id = (select film_id from film where title like 'Hunch%');

-- 2. List all films whose length is longer than 
-- the average of all the films.
select title, length from film
where
length > (select avg(length) from film);

-- 3. Use subqueries to display all actors who 
-- appear in the film _Alone Trip_.


select first_name, last_name from actor a
join film_actor fa
on a.actor_id = fa.actor_id
where film_id = (select film_id from film where title like 'Alo%');


-- 4. Sales have been lagging among young families, 
-- and you wish to target all family movies for a promotion.
 -- Identify all movies categorized as family films.
 
 # category_id for family
 select category_id from category where name = 'Family';
 
 select title, category_id from film f
 join film_category fc 
 on f.film_id = fc.film_id
 where category_id =  (select category_id from category where name = 'Family');
 
/* 5. Get name and email from customers from Canada using subqueries. 
Do the same with joins. Note that to create a join, you will have to 
identify the correct tables with their primary keys and foreign keys, 
that will help you get the relevant information.
*/

## I can do exactly what I've been using so far
## using a mix of joins and subqueries
## But this time I am going to try to only use 
## subqueries.


## canada_id
select country_id from country where country = 'CANADA';

## cities in canada_id
select city_id from city 
where country_id = (select country_id from country where country = 'CANADA');
 
 ## addresses id
 select address_id from address
 where city_id in (select city_id from city 
where country_id = (select country_id from country where country = 'CANADA'));

## 
SELECT 
    first_name, last_name
FROM
    customer
WHERE
    address_id IN (SELECT 
            address_id
        FROM
            address
        WHERE
            city_id IN (SELECT 
                    city_id
                FROM
                    city
                WHERE
                    country_id = (SELECT 
                            country_id
                        FROM
                            country
                        WHERE
                            country = 'CANADA')));

## The only thing you need to be careful is to start to add the in.
## BTW the query took 0.0015 sec to excecute.

select cs.first_name, cs.last_name, ct.country from customer cs
## join address
join address a
on cs.address_id = a.address_id
## join city
join city c
on a.city_id = c.city_id
## join country 
join country ct
on c.country_id = ct.country_id
## filter by country
where ct.country = 'Canada';

## Using all the joins it took 0.00063 seconds
## It was 4x slower.

/* 6. Which are films starred by the most prolific actor? Most
 prolific actor is defined as the actor that has acted in the most 
 number of films. First you will have to find the most prolific actor 
 and then use that actor_id to find the different films that he/she starred.
*/

## actor_id for ost prolific actor
select a.actor_id
from actor a
join film_actor fa 
on a.actor_id = fa.actor_id
group by a.actor_id, first_name, last_name
order by  count(fa.film_id) desc
limit 1;

## join films with actor id
select * from film f
join film_actor fa
on f.film_id = fa.film_id;

## Add filter 
select f.film_id, title from film f
join film_actor fa
on f.film_id = fa.film_id
# filter
where actor_id = (
select a.actor_id
from actor a
join film_actor fa 
on a.actor_id = fa.actor_id
group by a.actor_id, first_name, last_name
order by  count(fa.film_id) desc
limit 1
);

/* 
7. Films rented by most profitable customer. You can use the 
customer table and payment table to find the most profitable 
customer ie the customer that has made the largest sum of payments
*/

## customer_id of most profitable customer
select c.customer_id from customer c
join payment p
on c.customer_id = p.customer_id
group by c.customer_id
order by sum(amount) desc
limit 1;

## Make join so I have film title and customer_id
select title, customer_id from film f
join inventory i 
on f.film_id = i.film_id
join rental r
on i.inventory_id = r.inventory_id;

## Apply the filter
select title, customer_id from film f
join inventory i 
on f.film_id = i.film_id
join rental r
on i.inventory_id = r.inventory_id
where customer_id = (
select c.customer_id from customer c
join payment p
on c.customer_id = p.customer_id
group by c.customer_id
order by sum(amount) desc
limit 1
);

/*
8. Get the `client_id` and the `total_amount_spent` of those 
clients who spent more than the average of the `total_amount` spent by each client.
*/

## amount spent by client
select sum(amount) as total_spent from payment
group by customer_id;

## avg amount spent by client
select avg(total_spent) from (select sum(amount) as total_spent from payment
group by customer_id) t1;

## client_id who spent more than the average
select customer_id from payment
group by customer_id
having sum(amount) > (
select avg(total_spent) from (select sum(amount) as total_spent from payment
group by customer_id) t1)
order by sum(amount);

## client who has that id
select customer_id, first_name, last_name from customer
where customer_id in (
select customer_id from payment
group by customer_id
having sum(amount) > (
select avg(total_spent) from (select sum(amount) as total_spent from payment
group by customer_id) t1)
order by sum(amount)
);

## Make joins to add the amount again
select c.customer_id, first_name, last_name, sum(p.amount)
from customer c
join payment p 
on c.customer_id = p.customer_id
where c.customer_id in (
select customer_id from payment
group by customer_id
having sum(amount) > (
select avg(total_spent) from (select sum(amount) as total_spent from payment
group by customer_id) t1)
order by sum(amount)
)
group by customer_id, first_name, last_name;


