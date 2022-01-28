use sakila;


/*
1. Rank films by length (filter out the rows that have nulls or 
0s in length column). In your output, only select the columns title, 
length, and the rank.  
*/

SELECT TITLE
, LENGTH
, DENSE_RANK() OVER (ORDER BY LENGTH DESC) AS "RANK"
 FROM FILM WHERE LENGTH <> 0;
 
 /* 
 2. Rank films by length within the `rating` category 
(filter out the rows that have nulls or 0s in length column). 
In your output, only select the columns title, length, rating
 and the rank.  
 */
 
 SELECT TITLE
, LENGTH
, RATING
, DENSE_RANK() OVER (PARTITION BY RATING ORDER BY LENGTH DESC) AS "RANK"
 FROM FILM WHERE LENGTH <> 0
 ORDER BY RATING;
 
 /*
 3. How many films are there for each of the categories in 
the category table. Use appropriate join to write this query
 */
 
 SELECT 
    CATEGORY.NAME, COUNT(*) AS N_FILM
FROM
    FILM
        INNER JOIN
    film_category ON film.film_id = film_category.film_id
        INNER JOIN
    category ON film_category.category_id = category.category_id
GROUP BY CATEGORY.NAME
ORDER BY N_FILM DESC;


-- 4. Which actor has appeared in the most films?

SELECT  CONCAT(FIRST_NAME, ' ',LAST_NAME)
,COUNT(FILM.FILM_ID) as films
FROM ACTOR
INNER JOIN FILM_ACTOR ON ACTOR.ACTOR_ID = FILM_ACTOR.ACTOR_ID
INNER JOIN FILM ON FILM_ACTOR.FILM_ID = FILM.FILM_ID
GROUP BY CONCAT(FIRST_NAME, ' ' ,LAST_NAME)
ORDER BY films DESC
LIMIT 3;



/* 5. Most active customer (the customer that 
has rented the most number of films) 
*/

select concat(first_name,' ', last_name), count(rental_id) as movies_rented from customer
join rental on customer.customer_id = rental.customer_id
group by concat(first_name,' ', last_name)
order by movies_rented desc
limit 3;

 
 /* 
**Bonus**: Which is the most rented film?
The answer is Bucket Brotherhood
This query might require using more than one join statement. Give it a try. We will talk about queries with multiple join statements later in the lessons.
*/
 
 SELECT  FILM.TITLE, COUNT(RENTAL_ID) AS TIMES_RENTED FROM FILM
 INNER JOIN INVENTORY ON FILM.FILM_ID = INVENTORY.FILM_ID
 INNER JOIN RENTAL ON INVENTORY.INVENTORY_ID = RENTAL.INVENTORY_ID
 GROUP BY FILM.TITLE
 ORDER BY TIMES_RENTED DESC;
 