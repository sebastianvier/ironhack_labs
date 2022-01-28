
use sakila;
### Instructions

-- 1. Drop column `picture` from `staff`.
select * from staff;

ALTER TABLE staff
DROP COLUMN picture;



-- 2. A new person is hired to help Jon. Her name is TAMMY SANDERS,
-- and she is a customer. 
-- Update the database accordingly.

/* INSERT INTO staff (first_name, last_name, address_id, email, 
store_id, active, username,last_update)
SELECT 
    first_name, last_name,address_id, email, 2, 1, first_name, date(now())
FROM
    customer
WHERE
    first_name = 'TAMMY' ;*/
    
select * from staff;

-- This shows that the value is already added.
    
    
DELETE FROM customer 
WHERE
    first_name = 'TAMMY';

-- Tried to delete customer but was complicated, there is some sort 
-- of problems, because the value appears in another table
-- the key word is parent row

/* 3. Add rental for movie "Academy Dinosaur" by Charlotte Hunter 
from Mike Hillyer at Store 1.
 You can use current date for the `rental_date` column in the `rental` table.
   **Hint**: Check the columns in the table rental and see what 
   information you would need to add there. You can query those pieces of information.
   For eg., you would notice that you need `customer_id` information as well. To get that
   you can use the following query:

    ```sql
    select customer_id from sakila.customer
    where first_name = 'CHARLOTTE' and last_name = 'HUNTER';
    ```
*/
    select now() as rental_date;
    select * from film where title = "Academy Dinosaur" ;
    select * from rental where rental_id = (select max(rental_id) from rental);
    
   insert into rental (rental_date, inventory_id, customer_id, 
   return_date, staff_id, last_update)
	SELECT 
    now() as rental_date, 
    (SELECT 
            inventory_id
        FROM
            inventory
        WHERE
            film_id = (SELECT 
                    film_id
                FROM
                    film
                WHERE
                    title = 'Academy Dinosaur')
                AND store_id = 1
        LIMIT 1) AS inventory_id,
	-- this is the inventory_id
    (SELECT 
            customer_id
        FROM
            customer
        WHERE
            first_name = 'Charlotte'
                AND last_name = 'Hunter') AS customer_id,
    -- this is the customer_id     
    (select DATE_ADD(now(), INTERVAL 10 DAY))as return_date,
    (SELECT 
            staff_id
        FROM
            STAFF
        WHERE
            FIRST_NAME = 'Mike'
                AND LAST_NAME = 'HILLYER') AS staff_id,
    -- this is the staff_id
 now() as last_update;


select * from rental order by rental_id desc;

/*
4. Delete non-active users, but first, create a _backup table_ `deleted_users` to store `customer_id`, `email`, and the `date` for the users that would be deleted. Follow these steps:

   - Check if there are any non-active users
   - Create a table _backup table_ as suggested
   - Insert the non active users in the table _backup table_
   - Delete the non active users from the table _customer_
*/

select * from customer limit 3;

-- create a backup table

/*
CREATE TABLE back_up_table (
    customer_id smallint NOT NULL,
    store_id smallint,
    first_name varchar(50),
    last_name varchar(50),
    email varchar(200),
    adress_id smallint,
    active int default 1,
    create_date date, 
    last_update date , 
    PRIMARY KEY(customer_id)
);
*/

-- This was my first try to insert the values 
INSERT INTO back_up_table (customer_id, store_id, first_name, last_name, email,
address_id, active, create_date, last_update)
 select * from customer
 where active = 0;
 
 -- I discovered I misspelled the names
 ALTER TABLE back_up_table RENAME COLUMN adress_id TO address_id;
 
 
 -- seccond try
 INSERT INTO back_up_table (customer_id, store_id, first_name, last_name, email,
address_id, active, create_date, last_update)
 select * from customer
 where active = 0;
 
 
 -- Check if the number of inactive customer is the same
 
 select count(*) from customer where active = 0;
select count(*) from back_up_table where active = 0;

-- both are 15 so we are good to go!!

-- lets now delete the values
DELETE FROM customer WHERE active = 0;

-- but this: ERROR 1451 (23000): Cannot delete or update a parent row:

-- A way to do this is: SET FOREIGN_KEY_CHECKS=0; to disable them and
-- SET FOREIGN_KEY_CHECKS=1; to enable

SET FOREIGN_KEY_CHECKS=0;
DELETE FROM customer WHERE active = 0;

select count(*) from customer where active = 0;
SET FOREIGN_KEY_CHECKS=1;

-- Proably the error 1451 is there for a reason, but not really sure how 
-- to solve this.

