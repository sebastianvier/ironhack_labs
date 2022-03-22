
use sakila;

delimiter $$
CREATE PROCEDURE get_actor_by_category(in category_name varchar(50))
BEGIN
 select first_name, last_name, email
    from customer
    join rental on customer.customer_id = rental.customer_id
    join inventory on rental.inventory_id = inventory.inventory_id
    join film on film.film_id = inventory.film_id
    join film_category on film_category.film_id = film.film_id
    join category on category.category_id = film_category.category_id
    where category.name = category_name
    group by first_name, last_name, email;
END
$$
delimiter ;

-- drop procedure get_actor_by_category;

call get_actor_by_category('animation');
    

-- Write a query to check the number of movies released in each movie category.
-- Convert the query in to a stored procedure to filter only those categories 
-- that have movies released greater than a certain number. Pass that number
-- as an argument in the stored procedure.

Delimiter //
Create Procedure movies_by_category(in category_name varchar(50))
Begin
select c.name, count(film_id) 'number of films'
from film_category fc
join category c 
on c.category_id = fc.category_id
where c.name = category_name
group by c.name;
end
//
DELIMITER ;

call movies_by_category('animation');

