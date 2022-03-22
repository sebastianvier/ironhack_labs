use sakila;

-- Write queries to answer the following questions:

-- 1) Write a query to find what is the total business (revenew) done by each store.
select s.store_id, sum(p.amount) total_amount
from store s
join inventory i on s.store_id = i.store_id
join rental r on i.inventory_id = r.inventory_id 
join payment p on r.rental_id = p.rental_id
group by s.store_id;




-- Convert the previous query into a stored procedure.
-- Convert the previous query into a stored procedure 
-- that takes the input for `store_id` and displays the 
-- *total sales for that store*.

drop procedure total_revenew; 
# For dropping the procedure if needed

delimiter $$
Create Procedure total_revenew(in store_id int, out result float)
begin
select  round(sum(p.amount), 2) into result # The alias will be changed by the variable name.
from store s
join inventory i on s.store_id = i.store_id
join rental r on i.inventory_id = r.inventory_id 
join payment p on r.rental_id = p.rental_id
where s.store_id = store_id
group by s.store_id
;
end
$$
delimiter ;

Call total_revenew(1, @result);
select round(@result, 2); # For some reason I couldn't round the result in the procedure.

-- Update the previous query. Declare a variable `total_sales_value` 
-- of float type, that will store the returned result (of the total 
-- sales amount for the store). Call the stored procedure and print 
-- the results.


-- In the previous query, add another variable `flag`.
-- If the total sales value for the store is over 30.000, 
-- then label it as `green_flag`, otherwise label is as `red_flag`. 
-- Update the stored procedure that takes an input as the `store_id` 
-- and returns total sales value for that store and flag value.

drop procedure total_revenew_flag;

delimiter $$
Create Procedure total_revenew_flag(
in store_id int
)
begin
select  round(sum(p.amount), 2) total_amount, 
-- When Flag statement
case 
when round(sum(p.amount), 2) > (3 * 10 ^ 4) THEN 'green flag'
else 'red flag'
end flag
from store s
join inventory i on s.store_id = i.store_id
join rental r on i.inventory_id = r.inventory_id 
join payment p on r.rental_id = p.rental_id
where s.store_id = store_id
group by s.store_id
;
end
$$
delimiter ;

call total_revenew_flag(1)