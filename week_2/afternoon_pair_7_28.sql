SELECT *,
	fuel || ' ' || cyl AS fuel_cyl,
	REPLACE(class, '%Small%', '') AS no_small,
	SPLIT_PART(trans, ' ', 1) AS no_trans
FROM vehicles
WHERE model LIKE '%_WD';