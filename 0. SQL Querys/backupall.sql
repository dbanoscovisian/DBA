USE [TLMKT]
GO
/****** Object:  StoredProcedure [dbo].[sp_bi_all_managements]    Script Date: 9/03/2022 10:33:21 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[sp_bi_all_managements] AS

DECLARE @Dias AS int ;
DECLARE @Fecha AS date ;
SET @Dias = - 1 ;
SET @Fecha = CAST(DATEADD(DAY, @Dias ,GETDATE()) AS date) ;

----/* Eliminar all management */
--TRUNCATE TABLE TLMKT.dbo.bi_all_managements

----/* Eliminar all management para evitar duplicados */
DELETE FROM TLMKT.dbo.bi_all_managements
WHERE fecha_corta_gestion  >= @Fecha

----/* Insertar Gestiones a allmanagement */
INSERT INTO TLMKT.dbo.bi_all_managements ( id_inconcert, fecha, telefono, id_gss, id_result, tabla, id_agente, fecha_corta_gestion, hora_gestion, intervalo_gestion, anio_gestion, semana_anio_gestion, semana_mes_gestion, mes_num_gestion, mes_nombre_gestion, dia_nombre_gestion, resultado_tipificacion, unico, tipo_tipificado, tipo_contacto, tipo_efectividad, ranking, tipo_tipificacion, agrupacion_tip, agrupacion_bi, nombre_agente, nombre_jefe, fecha_ingreso_agente, tiempo_total, tiempo_respuesta, tiempo_espera, tiempo_atencion, tiempo_wrapup, tiempo_desercion, tiempo_hold, tiempo_requerido, tiempo_timbrando, procedencia_base, skill_base, sub_skill_base, nombre_base, fecha_recibido_base, mes_base  )
SELECT 
	 g.LastInteractionId AS id_inconcert,
	 g.TmStmp  AS fecha,
	 REPLACE(REPLACE (REPLACE (REPLACE(REPLACE(ContactAddress, '[52]-[', ''),']-[',''), ']',''), '52-', ''), '-','') AS telefono,
	 g.ContactId  AS id_gss,
	 g.ManagementResultCode  AS id_result,
	 'Gestiones'  AS tabla,
	 g.LastAgent AS id_agente,
	CAST (g.TmStmp AS DATE) AS fecha_corta_gestion,
	LEFT( CAST (g.TmStmp AS time), 8 ) as hora_gestion,
	DATEPART(HH,g.TmStmp) AS intervalo_gestion,
	DATEPART(YEAR, g.TmStmp) AS anio_gestion,
	CONCAT('Semana ', DATEPART(WW,g.TmStmp)) AS semana_anio_gestion, 
	CONCAT('Semana ', DATEPART(WEEK,g.TmStmp)	-  DATEPART(WEEK, DATEADD(dd,-DAY(g.TmStmp)+1,g.TmStmp))	+1  ) AS semana_mes_gestion,
	DATEPART(MONTH,g.TmStmp) AS mes_num_gestion,
	DATENAME(MONTH,g.TmStmp) AS mes_nombre_gestion,
	DATENAME(DW,g.TmStmp) AS dia_nombre_gestion,
	t.resultado AS resultado_tipificacion,
	1 AS unico,
	1 AS tipo_tipificado,
	t.tipo_contacto AS tipo_contacto,
	t.tipo_efectividad AS tipo_efectividad,
	t.ranking AS ranking,
	t.tipo AS tipo_tipificacion,
	t.agrupacion AS agrupacion_tip,
	t.agrupacion_bi AS agrupacion_bi, 
	ag.nombres AS nombre_agente,
	st.nombre AS nombre_jefe,
	ag.fecha_ingreso AS fecha_ingreso_agente,
	CASE WHEN i.DurationTime IS NULL THEN 0 ELSE i.DurationTime END AS tiempo_total, 
	CASE WHEN i.AnswerTime IS NULL THEN 0 ELSE i.AnswerTime END AS tiempo_respuesta,
	CASE WHEN i.WaitTime IS NULL THEN 0 ELSE i.WaitTime END AS tiempo_espera,
	CASE WHEN i.AttentionTime IS NULL THEN 0 ELSE i.AttentionTime END AS tiempo_atencion, 
	CASE WHEN i.WrapupTime IS NULL THEN 0 ELSE i.WrapupTime END AS tiempo_wrapup, 
	CASE WHEN i.DesertionTime IS NULL THEN 0 ELSE i.DesertionTime END AS tiempo_desercion, 
	CASE WHEN i.HoldTime IS NULL THEN 0 ELSE i.HoldTime END AS tiempo_hold, 
	CASE WHEN i.RequeuedTime IS NULL THEN 0 ELSE i.RequeuedTime END AS tiempo_requerido, 
	CASE WHEN i.RingingTime IS NULL THEN 0 ELSE i.RingingTime END AS tiempo_timbrando,
	p.procedencia AS procedencia_base,
	s.skill AS skill_base,
	s.nombre AS sub_skill_base,
	b.nombre AS nombre_base,
	b.fecha_recibido AS fecha_recibido_base,
	b.mes_base AS mes_base







----INTO TLMKT.dbo.bi_all_managements
FROM TLMKT.dbo.Gestiones AS g
LEFT JOIN TLMKT.dbo.InteractionDetail AS i ON i.Id  = g.LastInteractionId
INNER JOIN TLMKT.dbo.bi_tipificaciones AS t ON t.id_resultado = g.ManagementResultCode
LEFT JOIN TLMKT.dbo.bi_agentes AS ag ON ag.identificacion  = g.LastAgent
LEFT JOIN TLMKT.dbo.bi_staff AS st ON st.id_staff  = ag.id_staff 
LEFT JOIN TLMKT.dbo.bi_asignacion AS an ON an.id_gss = g.ContactId
LEFT JOIN TLMKT.dbo.bi_bases AS b ON b.id = an.id_base 
LEFT JOIN TLMKT.dbo.bi_servicios AS s ON s.id = b.id_servicio
LEFT JOIN TLMKT.dbo.bi_procedencias AS p ON p.id = b.Id_procedencia 
LEFT JOIN TLMKT.dbo.bi_all_managements AS a ON a.id_inconcert  = g.LastInteractionId 
														   AND a.id_gss  = g.ContactId 
														   AND a.tabla  = 'GESTIONES' 
WHERE a.id_inconcert IS NULL
AND CAST(g.TmStmp AS DATE) >= @Fecha;


--/* Insertar ContactResultDetails a allmanagements */
INSERT INTO TLMKT.dbo.bi_all_managements ( id_inconcert, fecha, telefono, id_gss, id_result, tabla, id_agente, fecha_corta_gestion, hora_gestion, intervalo_gestion, anio_gestion, semana_anio_gestion, semana_mes_gestion, mes_num_gestion, mes_nombre_gestion, dia_nombre_gestion, resultado_tipificacion, unico, tipo_tipificado, tipo_contacto, tipo_efectividad, ranking, tipo_tipificacion, agrupacion_tip, agrupacion_bi, nombre_agente, nombre_jefe, fecha_ingreso_agente, tiempo_total, tiempo_respuesta, tiempo_espera, tiempo_atencion, tiempo_wrapup, tiempo_desercion, tiempo_hold, tiempo_requerido, tiempo_timbrando, procedencia_base, skill_base, sub_skill_base, nombre_base, fecha_recibido_base, mes_base  )
SELECT 
	c.InteractionId  AS id_inconcert,
	DATEADD( HOUR, -5, c.[Date] ) AS fecha,
	REPLACE(REPLACE (REPLACE (REPLACE(REPLACE(c.DestinationAddress, '[52]-[', ''),']-[',''), ']',''), '52-', ''), '-','') AS telefono,
	c.Id  AS id_gss,
	t.id_resultado AS id_result,
	'ContactResultDetail'  AS tabla, 
	c.Agent AS id_agente,
	CAST(DATEADD(HOUR, -5 ,c.[Date]) AS date)  AS fecha_corta_gestion,
	LEFT(CAST(DATEADD(HOUR, -5, c.[Date]) AS time), 8 ) as hora_gestion,
	DATEPART(HH, DATEADD(HH, -5, c.[Date])) AS intervalo_gestion,
	DATEPART(YEAR, DATEADD(HOUR, -5 , c.[Date])) AS anio_gestion,
	CONCAT('Semana ', DATEPART(WW,DATEADD(HOUR, -5 , c.[Date] ))) AS semana_anio_gestion, 
	CONCAT('Semana ', DATEPART(WEEK,DATEADD(HOUR, -5 , c.[Date] ))	-  DATEPART(WEEK, DATEADD(dd,-DAY(DATEADD(HOUR, -5 , c.[Date]))+1,DATEADD(HOUR, -5 , c.[Date] )))	+1  ) AS semana_mes_gestion,
	DATEPART(MONTH,DATEADD(HOUR, -5 ,c.[Date] )) AS mes_num_gestion,
	DATENAME(MONTH,DATEADD(HOUR, -5 , c.[Date] )) AS mes_nombre_gestion,
	DATENAME(DW,DATEADD(HOUR, -5 , c.[Date])) AS dia_nombre_gestion,
	t.resultado AS resultado_tipificacion,
	1 AS unico,
	0 AS tipo_tipificado,
	t.tipo_contacto AS tipo_contacto,
	t.tipo_efectividad AS tipo_efectividad,
	t.ranking AS ranking,
	t.tipo AS tipo_tipificacion,
	t.agrupacion AS agrupacion_tip,
	t.agrupacion_bi AS agrupacion_bi, 
	ag.nombres AS nombre_agente,
	st.nombre AS nombre_jefe,
	ag.fecha_ingreso AS fecha_ingreso_agente,
	CASE WHEN i.DurationTime IS NULL THEN 0 ELSE i.DurationTime END AS tiempo_total, 
	CASE WHEN i.AnswerTime IS NULL THEN 0 ELSE i.AnswerTime END AS tiempo_respuesta,
	CASE WHEN i.WaitTime IS NULL THEN 0 ELSE i.WaitTime END AS tiempo_espera,
	CASE WHEN i.AttentionTime IS NULL THEN 0 ELSE i.AttentionTime END AS tiempo_atencion, 
	CASE WHEN i.WrapupTime IS NULL THEN 0 ELSE i.WrapupTime END AS tiempo_wrapup, 
	CASE WHEN i.DesertionTime IS NULL THEN 0 ELSE i.DesertionTime END AS tiempo_desercion, 
	CASE WHEN i.HoldTime IS NULL THEN 0 ELSE i.HoldTime END AS tiempo_hold, 
	CASE WHEN i.RequeuedTime IS NULL THEN 0 ELSE i.RequeuedTime END AS tiempo_requerido, 
	CASE WHEN i.RingingTime IS NULL THEN 0 ELSE i.RingingTime END AS tiempo_timbrando,
	p.procedencia AS procedencia_base,
	s.skill AS skill_base,
	s.nombre AS sub_skill_base,
	b.nombre AS nombre_base,
	b.fecha_recibido AS fecha_recibido_base,
	b.mes_base AS mes_base





FROM TLMKT.dbo.ContactResultDetail AS c
LEFT JOIN TLMKT.dbo.InteractionDetail AS i ON i.Id  = c.InteractionId
INNER JOIN TLMKT.dbo.bi_tipificaciones AS t ON t.resultado  = c.[Result]
LEFT JOIN TLMKT.dbo.bi_agentes AS ag ON ag.identificacion  = c.Agent
LEFT JOIN TLMKT.dbo.bi_staff AS st ON st.id_staff  = ag.id_staff
LEFT JOIN TLMKT.dbo.bi_asignacion AS an ON an.id_gss = c.Id
LEFT JOIN TLMKT.dbo.bi_bases AS b ON b.id = an.id_base 
LEFT JOIN TLMKT.dbo.bi_servicios AS s ON s.id = b.id_servicio
LEFT JOIN TLMKT.dbo.bi_procedencias AS p ON p.id = b.Id_procedencia 
LEFT JOIN TLMKT.dbo.bi_all_managements AS a ON a.id_inconcert  = c.InteractionId 
														   AND a.id_gss  = c.Id 
														
WHERE a.id_inconcert IS NULL
AND CAST(c.[Date] AS DATE) >= @Fecha
AND c.VirtualCC = 'telemexico' ;
