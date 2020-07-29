-- Write a query that returns the following information from the purchases table:

--     The date the purchase was made (created_at field).
--     Add 30 days to the purchase date.
--     Subtract 90 days from the purchase date.
--     Convert the purchase date to a date string using the formatting of your choice.
--     Truncate the purchase date to the hour.
--     Extract from the purchase date the year, month, day, weekday name, and week number.


SELECT * FROM purchases LIMIT 10;

SELECT 	created_at
		, created_at + '30 days' AS month_after
		, created_at - INTERVAL '90 days' AS ninety_before
		, TO_CHAR(created_at, 'MM/DD/YYYY')
		, DATE_TRUNC('hour', created_at) AS truncated
		, TO_CHAR(created_at, 'YYYY MM DD Day WW')
FROM purchases;