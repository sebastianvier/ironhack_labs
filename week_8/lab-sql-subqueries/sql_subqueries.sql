
/*
4. Sales have been lagging among young families, 
and you wish to target all family movies for a promotion.
 Identify all movies categorized as family films.
5. Get name and email from customers from Canada using subqueries. 
Do the same with joins. Note that to create a join, you will have to 
identify the correct tables with their primary keys and foreign keys, 
that will help you get the relevant information.
6. Which are films starred by the most prolific actor? Most
 prolific actor is defined as the actor that has acted in the most 
 number of films. First you will have to find the most prolific actor 
 and then use that actor_id to find the different films that he/she starred.
7. Films rented by most profitable customer. You can use the 
customer table and payment table to find the most profitable 
customer ie the customer that has made the largest sum of payments
8. Get the `client_id` and the `total_amount_spent` of those 
clients who spent more than the average of the `total_amount` spent by each client.
*/

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

select * from film where title like 'Alo%'


