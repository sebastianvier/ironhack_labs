### Instructions
use sakila;

-- 1. Get film ratings.

SELECT 
    film_id, title, rating
FROM
    film;
    
-- 2. Get release years.

SELECT 
    film_id, release_year, rating
FROM
    film;


-- 3. Get all films with ARMAGEDDON in the title.

SELECT 
    title
FROM
    film
WHERE
    title LIKE '%ARMAGEDDON%';


-- 4. Get all films with APOLLO in the title.

SELECT 
    title
FROM
    film
WHERE
    title LIKE '%APOLLO%';

-- 5. Get all films which title ends with APOLLO.
    
    SELECT 
    title
FROM
    film
WHERE
    title LIKE '%APOLLO';

select * from film;

-- 6. Get all films with word DATE in the title.

    SELECT 
    title
FROM
    film
WHERE
    title LIKE '% Date' or title like '% Date'  or title like 'Date %';
    
-- Is there a better way to do the same?

-- 7. Get 10 films with the longest title.

select title from film
order by length(title) desc
limit 10;

-- 8. Get 10 the longest films.

SELECT 
    title, length
FROM
    film
ORDER BY length DESC
LIMIT 10;

-- 9. How many films include **Behind the Scenes** content?
select * from film
where special_features like '%Behind the Scenes%';


-- 10. List films ordered by release year and title in alphabetical order.

SELECT 
    *
FROM
    film
ORDER BY release_year , title;

-- Select
SELECT 
    TITLE, LENGTH(TITLE)
FROM
    FILM
ORDER BY LENGTH(TITLE) DESC , TITLE
LIMIT 10;