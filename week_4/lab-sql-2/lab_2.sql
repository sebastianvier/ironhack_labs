# Lab | SQL Queries 2
/*
In this lab, you will be using the [Sakila](https://dev.mysql.com/doc/sakila/en/) database of movie rentals. You can follow the steps listed here to get the data locally: [Sakila sample database - installation](https://dev.mysql.com/doc/sakila/en/sakila-installation.html).

The database is structured as follows:
![DB schema](https://education-team-2020.s3-eu-west-1.amazonaws.com/data-analytics/database-sakila-schema.png)

<br><br>
*/

### Instructions
use sakila;


-- 1. Select all the actors with the first name ‘Scarlett’


SELECT 
    *
FROM
    actor
WHERE
    first_name = 'Scarlett';

-- 2. Select all the actors with the last name ‘Johansson’.

SELECT 
    *
FROM
    actor
WHERE
    last_name = 'Johansson';


-- 3. How many films (movies) are available for rent?

SELECT 
    COUNT(film_id)
FROM
    film;

-- 4. How many films have been rented?

SELECT 
    COUNT(*)
FROM
    film
WHERE
    rental_duration > 0;
    
    
-- 5. What is the shortest and longest rental period?

SELECT 
    MIN(return_date - rental_date) AS shortest
FROM
    rental;
    
SELECT 
    MAX(return_date - rental_date) AS longest
FROM
    rental;

-- 6. What are the shortest and longest movie duration? 
-- Name the values `max_duration` and `min_duration`.

SELECT 
    max(length) as max_duration
FROM
    film;

SELECT 
    min(length) as min_duration
FROM
    film;

-- 7. What's the average movie duration?

SELECT 
    AVG(length) AS avr_film_length
FROM
    film;


-- 8. What's the average movie duration expressed in format (hours, minutes)?

SELECT 
    AVG(length)
FROM
    (SELECT 
        length / 60 + (length % 60) / 100.0 as length
    FROM
        film) as length;
        
select round(floor(length/60) +  (length % 60)  / 100.0, 2) from film;

-- 9. How many movies longer than 3 hours?

select count(*) as movies_longer_3 from film
where length > 180;

-- 10. Get the name and email formatted. Example:
-- Mary SMITH - *mary.smith@sakilacustomer.org*.

SELECT 
    CONCAT(LOWER(first_name), ' ', last_name) AS full_name,
    LOWER(email) AS email
FROM
    customer;

-- 11. What's the length of the longest film title?

select max(length(title)) from film; 