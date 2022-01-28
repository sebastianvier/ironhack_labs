-- SQL lab 7

use sakila; 

/* 
1. In the table actor, which are the actors whose last 
names are not repeated? For example if you would sort 
the data in the table actor by last_name, you would see 
that there is Christian Arkoyd, Kirsten Arkoyd, and Debbie 
Arkoyd. These three actors have the same last name. So we 
do not want to include this last name in our output. Last name 
"Astaire" is present only one time with actor "Angelina 
Astaire", hence we would want this in our output list. 
*/

select * from actor;

select last_name as last_name_not_repeated from actor
group by last_name
having count(last_name) = 1;

-- use a having and then an agregated function within the having
-- using count. Because it is repeated if the count is not 1;

/*
2. Which last names appear more than once? We would use the same 
logic as in the previous question but this time we want to include 
the last names of the actors where the last name was present more than once
*/

select last_name as last_name_not_repeated from actor
group by last_name
having count(last_name) > 1;


/*
3. Using the rental table, find out how many rentals 
were processed by each employee.
*/ 

SELECT 
    CONCAT(staff.first_name, ' ', staff.last_name),
    COUNT(rental_id) AS rentals
FROM
    rental
        INNER JOIN
    staff ON rental.staff_id = staff.staff_id
GROUP BY rental.staff_id;


/*
4. Using the film table, find out how many films 
were released each year.
*/

select release_year, count(film_id) from film
group by release_year;

/*
5. Using the film table, find out for each rating how many films were there.
*/
select rental_rate, count(film_id) from film
group by rental_rate;

/*
6. What is the mean length of the film for each rating type. 
Round off the average lengths to two decimal places.
*/

SELECT 
    rental_rate,
    COUNT(film_id),
    ROUND(AVG(length), 2) AS mean_length
FROM
    film
GROUP BY rental_rate;

/*
7. Which kind of movies (rating) have a mean duration of more than two hours?
*/

SELECT 
    rental_rate,
    COUNT(film_id),
    ROUND(AVG(length), 2) AS mean_length
FROM
    film
GROUP BY rental_rate
having mean_length > 120;

-- none!!