use sakila;

-- 1. List each pair of actors that have worked together.

## join actors first_name, last_name and film title
select first_name, last_name, title from film_actor fa
join film f
on fa.film_id = f.film_id
join actor a
on fa.actor_id = a.actor_id;

with actor_and_film as 
(select first_name, last_name, title from film_actor fa
join film f
on fa.film_id = f.film_id
join actor a
on fa.actor_id = a.actor_id) 
select concat(t1.first_name, ' ',t1.last_name) actor_1, 
concat(t2.first_name,' ', t2.last_name) actor_2,
t1.title movie
from actor_and_film t1
join actor_and_film t2
on t1.title = t2.title
where t1.first_name <> t2.first_name
and t1.last_name <> t2.last_name;


-- 2. For each film, list actor that has acted in more films.

## If the actor acts in more than one film then have the
## actor next to the film

## actor that have acted in more than one film
SELECT 
    a.actor_id
FROM
    actor a
        JOIN
    film_actor fa ON a.actor_id = fa.actor_id
GROUP BY a.actor_id , first_name , last_name
HAVING COUNT(film_id) > 1;

## In this case it doesn't matter because all actor
## have at least 2 movies

SELECT 
    title, first_name, last_name
FROM
    film_actor fa
        JOIN
    actor a ON fa.actor_id = a.actor_id
        JOIN
    film f ON fa.film_id = f.film_id
WHERE
    a.actor_id IN (SELECT 
            a.actor_id
        FROM
            actor a
                JOIN
            film_actor fa ON a.actor_id = fa.actor_id
        GROUP BY a.actor_id , first_name , last_name
        HAVING COUNT(film_id) > 1);

