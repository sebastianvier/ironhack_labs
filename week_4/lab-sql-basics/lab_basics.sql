use bank;

### Query 1
-- Get the `id` values of the first 5 clients from 
-- `district_id` with a value equals to 1.

SELECT 
    client_id
FROM
    client
WHERE
    district_id = 1
LIMIT 5;

-- In the `client` table, get an `id` value of the last 
-- client where the `district_id` equals to 72.

SELECT 
    client_id
FROM
    client
WHERE
    district_id = 72
ORDER BY client_id DESC
LIMIT 1;

-- Query 4
-- What are the possible values for status, 
-- ordered alphabetically in ascending order in the loan table?

SELECT DISTINCT
    (status) AS status_letters
FROM
    loan
ORDER BY status;

### Query 5

-- What is the `loan_id` of the highest payment received 
-- in the `loan` table?What is the loan_id of 
-- the highest payment received in the loan table?

select loan_id from loan
where payments = (select max(payments) from loan);

-- Query 6
-- What is the loan amount of the lowest 5 account_ids in 
-- the loan table? Show the account_id and the corresponding amount

select * from loan;

select account_id as id, amount from loan
order by account_id limit 5;


-- What are the `account_id`s with the lowest loan 
-- `amount` that have a loan `duration` of 60 in the `loan` table?

SELECT 
    account_id
FROM
    loan
WHERE
    duration = 60
ORDER BY amount
LIMIT 5;

 ### Query 9

-- In the `order` table, what are the `order_id`s 
-- of the client with the `account_id` 34?

select order_id FROM bank.order
where account_id = 34;

### Query 10

-- In the `order` table, which `account_id`s were 
-- responsible for orders between `order_id` 29540 and 
-- `order_id` 29560 (inclusive)?

select distinct(account_id) from bank.order
where order_id between 29539 and 29560;


### Query 11

-- In the `order` table, what are the individual 
-- amounts that were sent to (`account_to`) id 30067122?

select account_to from bank.order
where amount = 30067122;
 -- ??
 
 ### Query 12
-- In the `trans` table, show the `trans_id`, 
-- `date`, `type` and `amount` of the 10 first 
-- transactions from `account_id` 793 in chronological 
-- order, from newest to oldest.

SELECT 
    trans_id, date, type, amount
FROM
    trans
WHERE
    account_id = 793
ORDER BY trans_id DESC
LIMIT 10;


### Query 13

-- In the `client` table, of all districts with a 
-- `district_id` lower than 10, how many clients 
-- are from each `district_id`? Show the results 
-- sorted by the `district_id` in ascending order.

SELECT district_id, count(district_id) as district_id_count
FROM client
GROUP BY district_id
having district_id < 10
order by district_id
;

-- We use group by in conjunction with count, 
-- how many rows have the district_id 1,2,...
-- we could also use other agregation functions like 
-- sum, but then we will doble the count.
-- then we use a having clause to especify that
-- we only want and finally we use an order by to sort.

### Query 14

-- In the `card` table, how many cards exist for each 
-- `type`? Rank the result starting with the most frequent 
-- `type`.

SELECT 
    type, COUNT(type) as n_of_cards
FROM
    card
GROUP BY type;

-- When you use an agregate function
-- you can type the column where the 
-- row takes place to query the value

### Query 15

-- Using the `loan` table, print the top 10 
-- `account_id`s based on the sum of all of 
-- their loan amounts.

SELECT 
    account_id, SUM(amount) AS total_amount
FROM
    loan
GROUP BY account_id
ORDER BY total_amount DESC
LIMIT 10;

### Query 16

-- In the `loan` table, retrieve the number 
-- of loans issued for each day, before (excl) 
-- 930907, ordered by date in descending order.

select date, count(date) as n_loans from loan
where date < 930907
group by date
order by date desc;


### Query 17

-- In the `loan` table, for each day in December 1997,
-- count the number of loans issued for each unique 
-- loan duration, ordered by date and duration, both 
-- in ascending order. You can ignore days without any
-- loans in your output.

SELECT 
	date, duration, count(*)
FROM
    loan
WHERE
    EXTRACT(YEAR FROM date) = 1997
        AND EXTRACT(MONTH FROM date) = 12
        group by date, duration
        order by date, duration;
        
### Query 18

-- In the `trans` table, for `account_id` 396, sum 
-- the amount of transactions for each type (`VYDAJ` = 
-- Outgoing, `PRIJEM` = Incoming). Your output should
 -- have the `account_id`, the `type` and the sum of
 -- amount, named as `total_amount`. Sort alphabetically 
 -- by type.


SELECT 
    account_id, type, ROUND(SUM(amount), 2)
FROM
    trans
WHERE
    account_id = 396
GROUP BY type;

### Query 19

-- From the previous output, translate the 
-- values for `type` to English, rename the 
-- column to `transaction_type`, round 
-- `total_amount` down to an integer


SELECT 
    account_id,
    if(type='VYDAJ', "Outgoing", "Incoming") as type, 
    floor(SUM(amount)) as total_amount
FROM
    trans
WHERE
    account_id = 396
GROUP BY type;

### Query 20 
-- From the previous result, modify your query 
-- so that it returns only one row, with a column 
-- for incoming amount, outgoing amount and the
-- difference.

SELECT account_id,
		IF(type = 'VYDAJ', sum(amount), sum(amount)) AS type,
            IF(type LIKE "PR%", "S", null) AS TYPE2
    FROM
        trans
    WHERE
        account_id = 396
    GROUP BY type;
    
    SELECT * FROM TRANS;
    
    SELECT
    account_id
    ,ROUND(SUM(IF(TYPE="PRIJEM", AMOUNT, 0)),2) AS "INCOMING"
	,ROUND(SUM(IF(TYPE="VYDAJ", AMOUNT, 0)),2) AS "OUTGOING"
    ,ROUND(SUM(IF(TYPE="PRIJEM", AMOUNT, 0)) - SUM(IF(TYPE="VYDAJ", AMOUNT, 0)),2)
    AS DIFFERENCE
FROM
    trans
    WHERE
        account_id = 396
        GROUP BY ACCOUNT_ID;


    ## Query 21

-- Continuing with the previous example, rank the top 10 
-- `account_id`s based on their difference.

 SELECT
    account_id
    ,ROUND(SUM(IF(TYPE="PRIJEM", AMOUNT, 0)),2) AS "INCOMING"
	,ROUND(SUM(IF(TYPE="VYDAJ", AMOUNT, 0)),2) AS "OUTGOING"
    ,ROUND(SUM(IF(TYPE="PRIJEM", AMOUNT, 0)) - SUM(IF(TYPE="VYDAJ", AMOUNT, 0)),2)
    AS DIFFERENCE
FROM
    trans
        GROUP BY ACCOUNT_ID
        ORDER BY DIFFERENCE DESC
        LIMIT 10;


