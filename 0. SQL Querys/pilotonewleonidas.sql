INSERT INTO analytics.dbo.bi_phones ( phone_number, country_code, phone_type, creation_date )
SELECT 
 	a.telefono,
	a.country_code,
	a.phone_type,
	a.fecha_creacion
--	p.phone_number
FROM
(
	SELECT 
		ROW_NUMBER ( ) OVER ( PARTITION BY q.telefono ORDER BY q.telefono, q.fecha_creacion) AS rownumber,
		q.telefono,
		q.country_code,
		q.phone_type,
		q.fecha_creacion
	FROM (
			SELECT 
				CAST(CASE 
						WHEN LEN(b.telefono) <=10 AND LEFT(RIGHT(b.telefono,10),3) >=600 THEN RIGHT(b.telefono,7)
						WHEN LEN(b.telefono) >=10 THEN RIGHT(b.telefono,10)
						END AS bigint) AS telefono,
				57 AS country_code,
				CASE WHEN LEN(b.telefono) <=10 AND LEFT(b.telefono,3) >= 600 THEN 'F' 
					 WHEN LEN(b.telefono) <=9 THEN 'F' 
					 WHEN LEN(b.telefono) >=10 AND LEFT(RIGHT(b.telefono,10),1) = 3 THEN 'M' 
					 ELSE '-' 
				END AS phone_type,
				fecha_creacion
			FROM InformesTigoPortabilidad.dbo.bi_telefonos AS b
			) AS q
	WHERE q.telefono IS NOT NULL ) AS a
LEFT JOIN analytics.dbo.bi_phones AS p ON  p.phone_number = a.telefono
									   AND p.country_code = 57
WHERE a.rownumber = 1
AND p.phone_number IS NULL