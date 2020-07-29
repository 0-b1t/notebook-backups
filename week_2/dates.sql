-- Using table: dvdrentals.public.rental

-- We're cracking down on overdue rentals.
-- We have little power over this so we're going to 
-- take a passive aggressive route.  For anyone,
-- who has had their rental for over 1 week, label them with
-- "i'm lame and i turn things in late". For those who've had
-- their dvd for under 24 hours, label them with "newbie".
-- Make up a label or leave the remaining unlabeled.

-- Use age with only 1 arg to compare to today
SELECT AGE(rental_date)
FROM rental;

-- Actual response to prompt
SELECT customer_id,
       rental_date,
	   CASE
	      WHEN AGE(rental_date) > '1 week' THEN 'i''m lame and i turn things in late'
	      WHEN AGE(rental_date) < '24 hours' THEN 'newbie'
	   END AS age_label
FROM rental;


-- Everyone knows Garfield hates Mondays.  Garfield also happens
-- to manage this DVD rental place.  Everyone that rents DVDs on
-- Mondays is dead to him.  Return all records where the rental 
-- date is not a Monday.  Include a column showing the day of the
-- week in this output.
-- reference: https://www.postgresql.org/docs/9.6/functions-formatting.html

-- Day TO_CHAR examples:
SELECT rental_date
       ,TO_CHAR(rental_date, 'Day')
       ,TO_CHAR(rental_date, 'DAY')
	   ,TO_CHAR(rental_date, 'day')
	   ,TO_CHAR(rental_date, 'D')
	   ,TO_CHAR(rental_date, 'DD')
	   ,TO_CHAR(rental_date, 'DDD')
FROM rental;

-- Prompt response:
SELECT rental_date
       ,TO_CHAR(rental_date, 'Day') AS weekday
-- 	   ,'Lasagna' AS please_dont_fire_me
FROM rental
WHERE NOT TO_CHAR(rental_date, 'Day') = 'Monday';


-- All of our rentals are due a week after their rental date.
-- Create a column showing the due date for each rental.
-- Create a column indicating whether or not the dvd is overdue.
SELECT rental_date
       ,rental_date + INTERVAL '1 week' AS due_date
       ,CASE
	       WHEN AGE(rental_date) > '1 week' AND return_date IS NULL THEN 'Late'
		   ELSE 'Not Late'
	    END AS overdue
FROM rental;


-- INTERVAL will convert strings to a time interval data type
-- not always needed, psql makes some good assumptions with this
SELECT '1 week', INTERVAL '1 week';

-- How long do people keep their rentals for?
-- Show a list of everyone who had their rental over a week.
SELECT return_date - rental_date AS rental_len
FROM rental
WHERE return_date - rental_date > '9 days';


-- Almost all programmers will agree that the best 
-- way to write a date is YYYY-MM-DD.  However, your
-- average US citizen might not agree. Let's malicously
-- comply with society by showing the rental date as
-- month_number/day_number/year and the return date as 
-- month_name day_number, year.
-- reference: https://www.postgresql.org/docs/9.6/functions-formatting.html
SELECT TO_CHAR(rental_date, 'MM/DD/YYYY') AS MM_DD_YYYY, 
       TO_CHAR(return_date, 'Month, DD, YYYY') AS Month_DD_YYYY
FROM rental;


SELECT CONCAT(
	          TRIM(TO_CHAR(return_date, 'Month')),
	          ' ',
	          TO_CHAR(return_date, 'DD'), 
	          ', ', 
	          TO_CHAR(return_date, 'YYYY')
        ) AS date_str
FROM rental;

-- Make up a prompt to use different techniques we've
-- used so far and bring it to workshop to challenge
-- everyone.  It can use whatever database & table you'd like.


-- Find the customer that has the largest total of days late
-- the amount of days past the 1 week rental time
-- include inventory_id
SELECT AGE(return_date, rental_date) - '1 week' AS late_amount
FROM rental
WHERE AGE(return_date, rental_date) - '1 week' > '0 seconds'
ORDER BY late_amount DESC
LIMIT 5;

