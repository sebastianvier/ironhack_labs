use sakila;


-- 1. List number of films per `category`.
select  c.name category_name, count(f.title) film_number
from film f
join film_category fc
on f.film_id = fc.film_id
join category c
on fc.category_id = c.category_id
group by c.name
order by film_number desc;

-- 2. Display the first and last names, as well as the address, 
-- of each staff member.

SELECT 
    UPPER(s.first_name) first_name, s.last_name, address
FROM
    staff s
        JOIN
    address a ON s.address_id = a.address_id;
    

-- 3. Display the total amount rung up by each staff member
--  in August of 2005.

select first_name, last_name, sum(amount) from staff s
JOIN payment p on s.staff_id = p.staff_id
where month(payment_date) = 8 and year(payment_date) = 2005
group by first_name, last_name;

-- 4. List each film and the number of actors who 
-- are listed for that film.

select title, count(a.actor_id) n_actors from film f
join film_actor fa 
on f.film_id = fa.film_id
join actor a
on fa.actor_id = a.actor_id
group by f.title
order by n_actors desc;

-- 5. Using the tables `payment` and `customer` and the JOIN command, list 
-- the total paid by each customer. List the customers alphabetically by 
-- last name.


SELECT 
    c.first_name, last_name, SUM(amount) AS total_paid
FROM
    customer c
        JOIN
    payment p ON c.customer_id = p.customer_id
GROUP BY c.first_name , c.last_name
order by total_paid desc;

