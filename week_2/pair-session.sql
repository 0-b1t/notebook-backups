SELECT
	(fixed_acidity + volatile_acidity + citric_acid) AS acidity,
	ROUND(((total_sulfur_dioxide::FLOAT - free_sulfur_dioxide::FLOAT)/total_sulfur_dioxide::FLOAT)::DECIMAL, 2) AS dio,
	LOG((residual_sugar::FLOAT*alcohol::FLOAT)^4.0) AS alc,
	(ROUND(chlorides,2)*total_sulfur_dioxide)::FLOAT^(1.0/3.0)
FROM winequality_red;

SELECT quality, alcohol, total_sulfur_dioxide,
	((alcohol^(3.0))::float/100.0) + (quality^2) - (total_sulfur_dioxide/10.0)

FROM winequality_red
ORDER BY quality;