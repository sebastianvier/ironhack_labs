use sakila;

-- 1. Get all pairs of actors that worked together.

select t1.first_name, t1.last_name, t2.first_name, t2.last_name, t1.title
## Select a table with the actor name and the actor name and the films they work on
 from (select a.actor_id, first_name, last_name, title from actor a
join film_actor fa
on a.actor_id = fa.actor_id
join film f
on fa.film_id = f.film_id) t1
## Join the same table
join (select a.actor_id, first_name, last_name, title from actor a
join film_actor fa
on a.actor_id = fa.actor_id
join film f
on fa.film_id = f.film_id) t2
on t1.title = t2.title 
# Make sure when you join together the actor ids are different
and t1.actor_id <> t2.actor_id;




-- 2. Get all pairs of customers that have rented 
-- the same film more than 3 times.

select c.customer_id, rental_id, count(film_id) n_times from customer c
# join rental
join rental r
on c.customer_id = r.customer_id
# join inventory
join inventory i 
on r.inventory_id = i.inventory_id
group by customer_id, rental_id 
having n_times > 1;

-- There is no customer id who has rented a movie more than once.

-- 3. Get all possible pairs of actors and films.

-- 3.1. All possible actor pairs
select t1.first_name, t1.last_name, t2.first_name, t2.last_name
from actor t1
cross join actor t2
where t1.actor_id <>  t2.actor_id;

-- 3.2. All possible film pairs (in the first 10 films)
select t1.title, t2.title
from (select title from film limit 10) t1
cross join (select title from film limit 10) t2
where t1.title <>  t2.title;

