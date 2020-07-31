-- Using the dvdrentals database:
-- Return all matching records as a result of joining 
-- the payment and customer tables. Keep only records found in both tables.

-- How do we think these tables join up?
-- To prove out the foreign keyness of this field we 
-- could also view the table constraints.
SELECT * FROM payment;
SELECT * FROM customer;


-- Lets now perform the join
-- Reminder of the prompt: 
-- "Keep only records found in both tables"
-- This query will return 2 copies of the `customer_id` field
SELECT *
FROM payment AS p
INNER JOIN customer AS c
ON p.customer_id = c.customer_id;


-- Return the first name, last name and address of 
-- customers as a result of joining the customer and address tables. 
-- Keep only records found in both tables.
SELECT 
	first_name,
	last_name,
	address
FROM customer AS cus
	JOIN address AS ad
ON cus.address_id = ad.address_id;


-- We can keep the JOIN 🚂 rolling and join on join on join on join on join on join on join on join on join...
-- Add payment amounts to the last query

-- Note, this is introducing duplicate info from LEFT table
-- Check row counts with COUNT(*) and note what the expected
-- output row count is.
SELECT 
	first_name,
	last_name,
	address,
	amount
FROM customer AS cus
	JOIN address AS ad
ON cus.address_id = ad.address_id
LEFT JOIN payment AS p
ON cus.customer_id = p.customer_id;

-- Checking expected output row count:
SELECT COUNT(*)
FROM customer AS cus
	JOIN address AS ad
ON cus.address_id = ad.address_id;

SELECT COUNT(*)
FROM customer AS cus
	JOIN address AS ad
ON cus.address_id = ad.address_id
LEFT JOIN payment AS p
ON cus.customer_id = p.customer_id;

-- Let's 'solve' the duplication by showing total
-- customer payments.
SELECT 
	cus.first_name,
	cus.last_name,
	ad.address,
	SUM(p.amount)
FROM customer AS cus
	JOIN address AS ad
       ON cus.address_id = ad.address_id
    LEFT JOIN payment AS p
       ON cus.customer_id = p.customer_id
GROUP BY cus.first_name, cus.last_name, ad.address;

-- When joining many tables it can be useful to specify
-- what table everything is coming from, even though it isn't necesary.
-- If you hadn't already, add table specifiers before every
-- column you mention in the SELECT clause



-- We can also JOIN a table to itself
-- Example potential use case:
-- We have a 'people' table modeled like below.
-- We could join it to itself to get a marriage per row.
-- |  id  |  name  | married_to |
-- |:----:|:------:|:----------:|
-- |  1   | Skyler |     3      |
-- |  2   | Elliot |    NULL    |
-- |  3   | Peyton |     1      |

-- SELECT *
-- FROM people AS a
--   JOIN people AS b
--     ON a.id = b.married_to;

-- Don't have a great setup for our dvdrentals data
-- but this is how a self JOIN query could look like.
-- This is also a use case for aliasing where its not
-- only an aid to readability.
SELECT a.customer_id,
       CONCAT('A - ', a.first_name) AS cust_name_a,
       CONCAT('B - ', b.first_name) AS cust_name_b
FROM customer AS a
INNER JOIN customer AS b
ON a.customer_id = b.customer_id;