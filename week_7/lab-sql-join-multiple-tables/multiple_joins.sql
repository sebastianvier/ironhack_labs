use sakila;

-- 1. Write a query to display for each store its store ID, 
-- city, and country.

SELECT 
    store_id, city, country
FROM
    store s
        JOIN
    address a ON s.address_id = a.address_id
        JOIN
    city c ON a.city_id = c.city_id
        JOIN
    country ctr ON c.country_id = ctr.country_id;
    
-- 2. Write a query to display how much 
-- business, in dollars, each store brought in.

SELECT 
    s.store_id, SUM(amount)
FROM
    store s
        JOIN
    inventory i ON s.store_id = i.store_id
        JOIN
    rental r ON i.inventory_id = r.inventory_id
        JOIN
    payment p ON r.rental_id = p.rental_id
GROUP BY s.store_id;

-- 3. What is the average running time 
-- of films by category?

select c.name category ,  avg(f.length) average_rt from film f
join film_category fc
on f.film_id = fc.film_id
join category c
on fc.category_id = c.category_id
group by c.name
order by average_rt desc;

-- 4. Which film categories are longest?

select c.name category ,  avg(f.length) average_rt from film f
join film_category fc
on f.film_id = fc.film_id
join category c
on fc.category_id = c.category_id
group by c.name
order by average_rt desc
limit 2;

-- On average Sports and Games films.

-- 5. Display the most frequently rented 
-- movies in descending order.
Select f.title, count(rental_id) times_rented from film f
join inventory i 
on f.film_id = i.film_id
join rental r
on i.inventory_id = r.inventory_id
group by f.title
order by times_rented desc;

-- 6. List the top five genres in gross 
-- revenue in descending order.

Select c.name category , sum(amount) gross_revenue from category c
join film_category fc
on c.category_id = fc.category_id
join film f
on fc.film_id = f.film_id
join inventory i 
on f.film_id = i.film_id
join rental r
on i.inventory_id = r.inventory_id
join payment p
on r.rental_id = p.rental_id
group by c.name
order by gross_revenue desc;


-- 7. Is "Academy Dinosaur" available for rent from Store 1?
select f.title, inventory_id, s.store_id from film f
join inventory i 
on f.film_id = i.film_id
join store s
on i.store_id = s.store_id
where s.store_id = 1
and f.title = 'Academy Dinosaur';

