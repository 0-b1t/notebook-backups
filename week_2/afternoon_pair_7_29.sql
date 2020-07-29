-- Next in pgAdmin, select the fueleconomy database and open the Query Tool.

--     Count the number of records in the vehicles table.
--     Count the number of distinct values there are in the make field.
--     Obtain the averages of the hwy and cty fields.
--     Group by make and model, obtain the averages of the hwy and cty fields.
--     Group the data by make, average the hwy and cty columns into a combined_mpg field, calculate the average of that field, and then sort descending by the combined_mpg field.
--     Count the number of records and the average of the cty field, grouping by trans and drive. 
--			Filter out records that have cyl > 4 and displ > 2.5 from going into the aggregation and then filter the results to show only where the average cty value is > 18.


SELECT * FROM vehicles LIMIT 10;

SELECT COUNT(*)
FROM vehicles;


SELECT COUNT(DISTINCT make)
FROM vehicles;


SELECT ROUND(AVG(hwy)), ROUND(AVG(cty))
FROM vehicles;


SELECT ROUND(AVG(hwy)), ROUND(AVG(cty)), make, model
FROM vehicles
GROUP BY make, model;

SELECT ROUND(AVG((hwy+cty)/2), 2) AS combined_mpg, make
FROM vehicles
GROUP By make
ORDER BY combined_mpg DESC;

--     Count the number of records and the average of the cty field, grouping by trans and drive. 
--			Filter out records that have cyl > 4 and displ > 2.5 from going into the aggregation and then filter the results to show only where the average cty value is > 18.

SELECT