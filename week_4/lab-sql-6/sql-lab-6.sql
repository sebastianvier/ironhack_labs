USE SAKILA;

SELECT * FROM FILMS_2020;

set global local_infile = 0;

-- This was the code I tried to import the csv file.
-- It didn't find the file for some reason.

/*

LOAD DATA LOCAL INFILE "/Users/sebastianvier/Documents/Ironhack course/week_4/lab-sql-6/files_for_lab.films_2020.csv"
INTO TABLE  films_2020
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '/n'
IGNORE 1 ROWS;

*/

-- Then I imported it using wizard 

select title from films_2020 where film_id = 13;

-- This returns ALI FOREVER

