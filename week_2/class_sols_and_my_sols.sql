-- Using table: dvdrentals.public.rental

-- We're cracking down on overdue rentals.
-- We have little power over this so we're going to 
-- take a passive aggressive route.  For anyone,
-- who has had their rental for over 1 week, label them with
-- "i'm lame and i turn things in late". For those who've had
-- their dvd for under 24 hours, label them with "newbie".
-- Make up a label or leave the remaining unlabeled.

SELECT * FROM rental LIMIT 10;

SELECT 	*,
		CASE
			WHEN DATE_PART('day',AGE(return_date, rental_date)) > 7 THEN 'i''m lame and i turn things in late'
			WHEN DATE_PART('day',AGE(return_date, rental_date)) = 0 THEN 'newbie'
			ELSE 'Don''t you dare turn things in late'
		END AS message_txt
FROM rental;


--Lecture solutions

SELECT	customer_id,
		rental_date,
		CASE
			WHEN AGE(return_date, rental_date) > '1 week' THEN 'i''m lame and i turn things in late'
			WHEN AGE(return_date, rental_date) < '24 hours' THEN 'newbie'
			ELSE 'Don''t you dare turn things in late'
		END AS age_label
FROM rental;


SELECT 	*,
		DATE_PART('day',AGE(return_date, rental_date)) AS rental_time
FROM rental;
-- Everyone knows Garfield hates Mondays.  Garfield also happens
-- to manage this DVD rental place.  Everyone that rents DVDs on
-- Mondays is dead to him.  Return all records where the rental 
-- date is not a Monday.  Include a column showing the day of the
-- week in this output.
-- reference: https://www.postgresql.org/docs/9.6/functions-formatting.html

SELECT 	*,
		TO_CHAR(return_date, 'Day') AS weekday
FROM rental
WHERE TO_CHAR(return_date, 'Day') NOT LIKE 'Monday'
LIMIT 10;


SELECT 	rental_date
		,TO_CHAR(rental_date, 'Day')
		,TO_CHAR(rental_date, 'DAY')
		,TO_CHAR(rental_date, 'day')
		,TO_CHAR(rental_date, 'D')
		,TO_CHAR(rental_date, 'DD')
		,TO_CHAR(rental_date, 'DDD')
		,TO_CHAR(rental_date, 'D y')
FROM rental;


SELECT rental_date
		,TO_CHAR(rental_date, 'Day') AS weekday
FROM rental
WHERE TO_CHAR(return_date, 'Day') NOT LIKE 'Monday';


-- All of our rentals are due a week after their rental date.
-- Create a column showing the due date for each rental.
-- Create a column indicating whether or not the dvd is overdue.
-- (i know thats kind of like the first prompt, 
--  but its hard to make up unique interesting prompts)

SELECT rental_date
		,rental_date + INTERVAL '1 week' AS due_date
		,CASE
			WHEN return_date-rental_date > '1 week' THEN 'Late'
			ELSE 'Not Late'
		END AS overdue
FROM rental;

--INTERVAL will convert strings to a time interval data type
-- not always needed, psql makes inferences

-- Almost all programmers will agree that the best 
-- way to write a date is YYYY-MM-DD.  However, your
-- average US citizen might not agree. Let's malicously
-- comply with society by showing the rental date as
-- month_number/day_number/year and the return date as 
-- month_name day_number, year.
-- reference: https://www.postgresql.org/docs/9.6/functions-formatting.html


SELECT
		TO_CHAR(rental_date, 'MM/DD/YYYY')
		,CONCAT(
			TRIM(TO_CHAR(return_date, 'Month')),
			' ',
			TO_CHAR(return_date, 'DD'),
			', ',
			TO_CHAR(return_date, 'YYYY') 
		)
FROM rental;


-- Make up a prompt to use different techniques we've
-- used so far and bring it to workshop to challenge
-- everyone.  It can use whatever database & table you'd like.

--Find the customer that has the largest total of days late

SELECT SUM(AGE(return_date, rental_date) - '1 week') AS late_amount, customer_id
FROM rental
WHERE AGE(return_date, rental_date) - '1 week' > '0 seconds'
GROUP BY customer_id
ORDER BY late_amount DESC;
