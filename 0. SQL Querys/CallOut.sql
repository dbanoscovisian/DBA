SELECT
	1 AS row,
	c.ID AS id_gss,
	c.operador,
	c.PRODUCTO AS producto,
	b.mes_base, 
	b.Nombre AS nombre_base,
	p.procedencia, 
	b.Fecha_recibido,
	c.CIUDAD,
	DATEPART(YEAR,b.Fecha_recibido) AS anio_recibido,
	DATENAME(MONTH,b.Fecha_recibido) AS mes_recibido,
	sk.sub_skill,
	s.skill_nombre,
	CASE 
		WHEN mg.id_inconcert IS NULL THEN 0 ELSE 1
	END AS estado_gestion,
	mg.id_inconcert,
	mg.fecha AS fecha_gestion,
	DATEPART(YEAR,mg.fecha) AS anio_gestion,
	DATENAME(MONTH,mg.fecha) AS mes_gestion,
	DATEPART(HH,mg.fecha) AS hora_gestion, 
	mg.telefono,
	mg.id_resultado,
	mg.resultado,
	mg.tipo_contacto,
	mg.tipo_efectividad,
	mg.ranking,
	c.CAMPANA,
	c.CELULAR_CONTACTO,
	C.PROVEEDOR,
	C.CODIGO_ABONADO,
	c.OFERTA_1,
	mg.agrupacion
FROM InformesTelecolombia.dbo.bi_asignacion AS c
INNER JOIN InformesTelecolombia.dbo.bi_bases AS b ON b.id = c.ID_BASE
INNER JOIN InformesTelecolombia.dbo.bi_procedencias AS p ON p.id = b.Id_procedencia 
INNER JOIN InformesTelecolombia.dbo.bi_sub_skills AS sk ON sk.id = b.Id_sub_skill 
INNER JOIN InformesTelecolombia.dbo.bi_skills AS s ON s.id = sk.id_skill
LEFT JOIN (
	        SELECT 
	        	* 
	        FROM (
					SELECT 
						ROW_NUMBER ( ) OVER ( PARTITION BY a.id_gss ORDER BY  a.id_gss, t.ranking ASC,a.fecha DESC) AS rownumber,
						a.id_inconcert,
						a.fecha,
						a.telefono,
						a.id_gss,
						t.id_resultado,
						t.resultado,
						t.tipo_contacto,
						t.tipo_efectividad,
						t.ranking,
						t.tipo,
						t.agrupacion
					FROM InformesTelecolombia.dbo.bi_all_managements AS a
					INNER JOIN InformesTelecolombia.dbo.bi_tipificaciones AS t ON t.id_resultado = a.id_result
					WHERE LEN(a.id_gss) < 30
					AND t.resultado NOT IN ('10009')
					AND CAST ( a.fecha as date ) >= '2021-11-01'
					) AS q
			WHERE rownumber = 1		
		  ) AS mg ON mg.id_gss = c.ID;