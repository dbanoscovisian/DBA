USE [InformesTelecolombia]
GO
/****** Object:  StoredProcedure [dbo].[sp_bi_all_managements]    Script Date: 7/03/2022 7:46:50 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[sp_bi_all_managements] AS

DECLARE @Dias AS int ;
DECLARE @Fecha AS date ;
DECLARE @Hoy AS date
SET @Dias = -35;
SET @Fecha = CAST(DATEADD(DAY, @Dias ,GETDATE()) AS date) ;
SET @Hoy = CAST(GETDATE() AS date) ;


----/* Eliminar all management */
--TRUNCATE TABLE InformesTelecolombia.dbo.bi_all_managements

----/* Eliminar all management para evitar duplicados */
DELETE FROM InformesTelecolombia.dbo.bi_all_managements
WHERE fecha_corta_gestion  >= @Fecha

------/* Insertar Gestiones a allmanagement */
INSERT INTO InformesTelecolombia.dbo.bi_all_managements ( id_inconcert, fecha, telefono, id_gss, id_result, tabla, id_agente, fecha_corta_gestion, hora_gestion, intervalo_gestion, anio_gestion, semana_anio_gestion, semana_mes_gestion, mes_num_gestion, mes_nombre_gestion, dia_nombre_gestion, resultado_tipificacion, unico, tipo_tipificado, tipo_contacto, tipo_efectividad, ranking, tipo_tipificacion, agrupacion_tip, agrupacion_bi, nombre_agente, nombre_jefe, fecha_ingreso_agente, atendida, abandonada, cancelada, tiempo_total, tiempo_respuesta, tiempo_espera, tiempo_atencion, tiempo_wrapup, tiempo_desercion, tiempo_hold, tiempo_requerido, tiempo_timbrando, prefijo, outboundprocessid_inconcert, batchid_inconcert, procedencia_base, skill_base, sub_skill_base, nombre_base, fecha_recibido_base, mes_base )
SELECT 
	g.LastInteractionId AS id_inconcert,
	CASE WHEN DATEADD( HOUR, -5, i.[StartDate] ) IS NULL THEN DATEADD( HOUR, -5, c.[Date] ) ELSE DATEADD( HOUR, -5, i.[StartDate] ) END AS fecha,
	REPLACE(REPLACE (REPLACE (REPLACE(REPLACE(ContactAddress, '[57]-[', ''),']-[',''), ']',''), '57-', ''), '-','') AS telefono,
	g.ContactId  AS id_gss,
	g.ManagementResultCode  AS id_result,
	'Gestiones'  AS tabla,
	g.LastAgent AS id_agente,
	CASE WHEN CAST(DATEADD(HOUR, -5 ,i.[StartDate]) AS date) IS NULL THEN CAST(DATEADD(HOUR, -5, c.[Date]) AS date) ELSE CAST(DATEADD(HOUR, -5 ,i.[StartDate]) AS date) END  AS fecha_corta_gestion,
	CASE WHEN LEFT(CAST(DATEADD(HOUR, -5, i.[StartDate]) AS time), 8 ) IS NULL THEN LEFT(CAST(DATEADD(HOUR, -5, c.[Date]) AS time), 8 ) ELSE LEFT(CAST(DATEADD(HOUR, -5, i.[StartDate]) AS time), 8 ) END AS hora_gestion,
	CASE WHEN DATEPART(HH, DATEADD(HH, -5, i.[StartDate])) IS NULL THEN DATEPART(HH, DATEADD(HH, -5, c.[Date])) ELSE DATEPART(HH, DATEADD(HH, -5, i.[StartDate])) END AS intervalo_gestion,
	CASE WHEN DATEPART(YEAR, DATEADD(HOUR, -5 , i.[StartDate])) IS NULL THEN DATEPART(YEAR, DATEADD(HOUR, -5 , c.[Date])) ELSE DATEPART(YEAR, DATEADD(HOUR, -5 , i.[StartDate])) END AS anio_gestion,
	CONCAT('Semana ', (CASE WHEN DATEPART(WW,DATEADD(HOUR, -5 , i.[StartDate] )) IS NULL THEN DATEPART(WW,DATEADD(HOUR, -5 , c.[Date] )) ELSE DATEPART(WW,DATEADD(HOUR, -5 , i.[StartDate] )) END)) AS semana_anio_gestion, 
	CONCAT('Semana ', (CASE WHEN DATEPART(WEEK,DATEADD(HOUR, -5 , i.[StartDate] ))	-  DATEPART(WEEK, DATEADD(dd,-DAY(DATEADD(HOUR, -5 , i.[StartDate]))+1,DATEADD(HOUR, -5 , i.[StartDate] )))	+1   IS NULL THEN DATEPART(WEEK,DATEADD(HOUR, -5 , c.[Date] ))	-  DATEPART(WEEK, DATEADD(dd,-DAY(DATEADD(HOUR, -5 , c.[Date]))+1,DATEADD(HOUR, -5 , c.[Date] )))	+1  ELSE DATEPART(WEEK,DATEADD(HOUR, -5 , i.[StartDate] ))	-  DATEPART(WEEK, DATEADD(dd,-DAY(DATEADD(HOUR, -5 , i.[StartDate]))+1,DATEADD(HOUR, -5 , i.[StartDate] )))	+1  END )) AS semana_mes_gestion,
	CASE WHEN DATEPART(MONTH,DATEADD(HOUR, -5 ,i.[StartDate] )) IS NULL THEN DATEPART(MONTH,DATEADD(HOUR, -5 ,c.[Date] )) ELSE DATEPART(MONTH,DATEADD(HOUR, -5 ,i.[StartDate] )) END AS mes_num_gestion,
	CASE WHEN DATENAME(MONTH,DATEADD(HOUR, -5 , i.[StartDate] )) IS NULL THEN DATENAME(MONTH,DATEADD(HOUR, -5 , c.[Date] )) ELSE DATENAME(MONTH,DATEADD(HOUR, -5 , i.[StartDate] )) END AS mes_nombre_gestion,
	CASE WHEN DATENAME(DW,DATEADD(HOUR, -5 , i.[StartDate])) IS NULL THEN DATENAME(DW,DATEADD(HOUR, -5 , c.[Date])) ELSE DATENAME(DW,DATEADD(HOUR, -5 , i.[StartDate])) END AS dia_nombre_gestion,
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
	CASE WHEN i.IsTaked IS NULL THEN 0 ELSE i.IsTaked END AS atendidas, 
	CASE WHEN i.IsAbandoned IS NULL THEN 0 ELSE i.IsAbandoned END AS abandonadas, 
	CASE WHEN i.IsCancelled IS NULL THEN 0 ELSE i.IsCancelled END AS canceladas, 
	CASE WHEN i.DurationTime IS NULL THEN 0 ELSE i.DurationTime END AS tiempo_total, 
	CASE WHEN i.AnswerTime IS NULL THEN 0 ELSE i.AnswerTime END AS tiempo_respuesta,
	CASE WHEN i.WaitTime IS NULL THEN 0 ELSE i.WaitTime END AS tiempo_espera,
	CASE WHEN i.AttentionTime IS NULL THEN 0 ELSE i.AttentionTime END AS tiempo_atencion, 
	CASE WHEN i.WrapupTime IS NULL THEN 0 ELSE i.WrapupTime END AS tiempo_wrapup, 
	CASE WHEN i.DesertionTime IS NULL THEN 0 ELSE i.DesertionTime END AS tiempo_desercion, 
	CASE WHEN i.HoldTime IS NULL THEN 0 ELSE i.HoldTime END AS tiempo_hold, 
	CASE WHEN i.RequeuedTime IS NULL THEN 0 ELSE i.RequeuedTime END AS tiempo_requerido, 
	CASE WHEN i.RingingTime IS NULL THEN 0 ELSE i.RingingTime END AS tiempo_timbrando,
	i.Prefix AS prefijo,
	i.OutboundProcessId AS outboundprocessid_inconcert,
	i.BatchId AS batchid_inconcert,
	p.procedencia AS procedencia_base,
	s.skill AS skill_base,
	s.nombre AS sub_skill_base,
	b.nombre AS nombre_base,
	b.fecha_recibido AS fecha_recibido_base,
	b.mes_base AS mes_base








----INTO InformesTelecolombia.dbo.bi_all_managements
FROM InformesTelecolombia.dbo.Gestiones AS g
LEFT JOIN InformesTelecolombia.dbo.HistoricalData_InteractionDetail AS i ON i.Id  = g.LastInteractionId 
LEFT JOIN InformesTelecolombia.dbo.HistoricalData_ContactResultDetail AS c ON c.InteractionId  = g.LastInteractionId 
INNER JOIN InformesTelecolombia.dbo.bi_tipificaciones AS t ON t.id_resultado  = g.ManagementResultCode 
LEFT JOIN InformesTelecolombia.dbo.bi_agentes AS ag ON ag.identificacion  = g.LastAgent 
LEFT JOIN InformesTelecolombia.dbo.bi_staff AS st ON st.id_staff = ag.id_staff 
LEFT JOIN InformesTelecolombia.dbo.bi_asignacion AS an ON an.id_gss  = g.ContactId 
LEFT JOIN InformesTelecolombia.dbo.bi_bases AS b ON b.id  = an.id_base 
LEFT JOIN InformesTelecolombia.dbo.bi_servicios AS s ON s.id = b.id_servicio 
LEFT JOIN InformesTelecolombia.dbo.bi_procedencias AS p ON p.id  = b.Id_procedencia
LEFT JOIN InformesTelecolombia.dbo.bi_all_managements AS a ON a.id_inconcert  = g.LastInteractionId 
														   AND a.id_gss  = g.ContactId 
														   AND a.tabla  = 'Gestiones' 
WHERE a.id_inconcert IS NULL
AND CAST(g.TmStmp AS DATE) >= @Fecha
AND CAST(g.TmStmp AS DATE) < @Hoy

--/* Insertar ContactResultDetails a allmanagements */
INSERT INTO InformesTelecolombia.dbo.bi_all_managements ( id_inconcert, fecha, telefono, id_gss, id_result, tabla, id_agente, fecha_corta_gestion, hora_gestion, intervalo_gestion, anio_gestion, semana_anio_gestion, semana_mes_gestion, mes_num_gestion, mes_nombre_gestion, dia_nombre_gestion, resultado_tipificacion, unico, tipo_tipificado, tipo_contacto, tipo_efectividad, ranking, tipo_tipificacion, agrupacion_tip, agrupacion_bi, nombre_agente, nombre_jefe, fecha_ingreso_agente, atendida, abandonada, cancelada, tiempo_total, tiempo_respuesta, tiempo_espera, tiempo_atencion, tiempo_wrapup, tiempo_desercion, tiempo_hold, tiempo_requerido, tiempo_timbrando, prefijo, outboundprocessid_inconcert, batchid_inconcert, procedencia_base, skill_base, sub_skill_base, nombre_base, fecha_recibido_base, mes_base )
SELECT 
	c.InteractionId  AS id_inconcert,
	CASE WHEN DATEADD( HOUR, -5, i.[StartDate] ) IS NULL THEN DATEADD( HOUR, -5, c.[Date] ) ELSE DATEADD( HOUR, -5, i.[StartDate] ) END AS fecha,
	REPLACE(REPLACE (REPLACE (REPLACE(REPLACE(c.DestinationAddress, '[57]-[', ''),']-[',''), ']',''), '57-', ''), '-','')  AS telefono,
	c.Id  AS id_gss,
	t.id_resultado AS id_result,
	'ContactResultDetail'  AS tabla, 
	c.Agent AS id_agente,
	CASE WHEN CAST(DATEADD(HOUR, -5 ,i.[StartDate]) AS date) IS NULL THEN CAST(DATEADD(HOUR, -5, c.[Date]) AS date) ELSE CAST(DATEADD(HOUR, -5 ,i.[StartDate]) AS date) END  AS fecha_corta_gestion,
	CASE WHEN LEFT(CAST(DATEADD(HOUR, -5, i.[StartDate]) AS time), 8 ) IS NULL THEN LEFT(CAST(DATEADD(HOUR, -5, c.[Date]) AS time), 8 ) ELSE LEFT(CAST(DATEADD(HOUR, -5, i.[StartDate]) AS time), 8 ) END AS hora_gestion,
	CASE WHEN DATEPART(HH, DATEADD(HH, -5, i.[StartDate])) IS NULL THEN DATEPART(HH, DATEADD(HH, -5, c.[Date])) ELSE DATEPART(HH, DATEADD(HH, -5, i.[StartDate])) END AS intervalo_gestion,
	CASE WHEN DATEPART(YEAR, DATEADD(HOUR, -5 , i.[StartDate])) IS NULL THEN DATEPART(YEAR, DATEADD(HOUR, -5 , c.[Date])) ELSE DATEPART(YEAR, DATEADD(HOUR, -5 , i.[StartDate])) END AS anio_gestion,
	CONCAT('Semana ', (CASE WHEN DATEPART(WW,DATEADD(HOUR, -5 , i.[StartDate] )) IS NULL THEN DATEPART(WW,DATEADD(HOUR, -5 , c.[Date] )) ELSE DATEPART(WW,DATEADD(HOUR, -5 , i.[StartDate] )) END)) AS semana_anio_gestion, 
	CONCAT('Semana ', (CASE WHEN DATEPART(WEEK,DATEADD(HOUR, -5 , i.[StartDate] ))	-  DATEPART(WEEK, DATEADD(dd,-DAY(DATEADD(HOUR, -5 , i.[StartDate]))+1,DATEADD(HOUR, -5 , i.[StartDate] )))	+1   IS NULL THEN DATEPART(WEEK,DATEADD(HOUR, -5 , c.[Date] ))	-  DATEPART(WEEK, DATEADD(dd,-DAY(DATEADD(HOUR, -5 , c.[Date]))+1,DATEADD(HOUR, -5 , c.[Date] )))	+1  ELSE DATEPART(WEEK,DATEADD(HOUR, -5 , i.[StartDate] ))	-  DATEPART(WEEK, DATEADD(dd,-DAY(DATEADD(HOUR, -5 , i.[StartDate]))+1,DATEADD(HOUR, -5 , i.[StartDate] )))	+1  END )) AS semana_mes_gestion,
	CASE WHEN DATEPART(MONTH,DATEADD(HOUR, -5 ,i.[StartDate] )) IS NULL THEN DATEPART(MONTH,DATEADD(HOUR, -5 ,c.[Date] )) ELSE DATEPART(MONTH,DATEADD(HOUR, -5 ,i.[StartDate] )) END AS mes_num_gestion,
	CASE WHEN DATENAME(MONTH,DATEADD(HOUR, -5 , i.[StartDate] )) IS NULL THEN DATENAME(MONTH,DATEADD(HOUR, -5 , c.[Date] )) ELSE DATENAME(MONTH,DATEADD(HOUR, -5 , i.[StartDate] )) END AS mes_nombre_gestion,
	CASE WHEN DATENAME(DW,DATEADD(HOUR, -5 , i.[StartDate])) IS NULL THEN DATENAME(DW,DATEADD(HOUR, -5 , c.[Date])) ELSE DATENAME(DW,DATEADD(HOUR, -5 , i.[StartDate])) END AS dia_nombre_gestion,
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
	CASE WHEN i.IsTaked IS NULL THEN 0 ELSE i.IsTaked END AS atendidas, 
	CASE WHEN i.IsAbandoned IS NULL THEN 0 ELSE i.IsAbandoned END AS abandonadas, 
	CASE WHEN i.IsCancelled IS NULL THEN 0 ELSE i.IsCancelled END AS canceladas, 
	CASE WHEN i.DurationTime IS NULL THEN 0 ELSE i.DurationTime END AS tiempo_total, 
	CASE WHEN i.AnswerTime IS NULL THEN 0 ELSE i.AnswerTime END AS tiempo_respuesta,
	CASE WHEN i.WaitTime IS NULL THEN 0 ELSE i.WaitTime END AS tiempo_espera,
	CASE WHEN i.AttentionTime IS NULL THEN 0 ELSE i.AttentionTime END AS tiempo_atencion, 
	CASE WHEN i.WrapupTime IS NULL THEN 0 ELSE i.WrapupTime END AS tiempo_wrapup, 
	CASE WHEN i.DesertionTime IS NULL THEN 0 ELSE i.DesertionTime END AS tiempo_desercion, 
	CASE WHEN i.HoldTime IS NULL THEN 0 ELSE i.HoldTime END AS tiempo_hold, 
	CASE WHEN i.RequeuedTime IS NULL THEN 0 ELSE i.RequeuedTime END AS tiempo_requerido, 
	CASE WHEN i.RingingTime IS NULL THEN 0 ELSE i.RingingTime END AS tiempo_timbrando,
	i.Prefix AS prefijo,
	i.OutboundProcessId AS outboundprocessid_inconcert,
	i.BatchId AS batchid_inconcert,
	p.procedencia AS procedencia_base,
	s.skill AS skill_base,
	s.nombre AS sub_skill_base,
	b.nombre AS nombre_base,
	b.fecha_recibido AS fecha_recibido_base,
	b.mes_base AS mes_base





FROM InformesTelecolombia.dbo.HistoricalData_ContactResultDetail AS c
LEFT JOIN InformesTelecolombia.dbo.HistoricalData_InteractionDetail AS i ON i.Id  = c.InteractionId 
INNER JOIN InformesTelecolombia.dbo.bi_tipificaciones AS t ON t.resultado  = c.[Result] 
LEFT JOIN InformesTelecolombia.dbo.bi_agentes AS ag ON ag.identificacion  = c.Agent 
LEFT JOIN InformesTelecolombia.dbo.bi_staff AS st ON st.id_staff = ag.id_staff 
LEFT JOIN InformesTelecolombia.dbo.bi_asignacion AS an ON an.id_gss  = c.Id 
LEFT JOIN InformesTelecolombia.dbo.bi_bases AS b ON b.id  = an.id_base 
LEFT JOIN InformesTelecolombia.dbo.bi_servicios AS s ON s.id = b.id_servicio 
LEFT JOIN InformesTelecolombia.dbo.bi_procedencias AS p ON p.id  = b.Id_procedencia
LEFT JOIN InformesTelecolombia.dbo.bi_all_managements AS a ON a.id_inconcert  = c.InteractionId 
														   AND a.id_gss  = c.Id 
														
WHERE a.id_inconcert IS NULL
AND CAST(c.[Date] AS DATE) >= @Fecha
AND CAST(c.[Date] AS DATE) < @Hoy
AND c.VirtualCC = 'telecolombia' ;




/* Insertar InteractionsDetails a allmanagement */
INSERT INTO InformesTelecolombia.dbo.bi_all_managements ( id_inconcert, fecha, telefono, id_gss, id_result, tabla, id_agente, fecha_corta_gestion, hora_gestion, intervalo_gestion, anio_gestion, semana_anio_gestion, semana_mes_gestion, mes_num_gestion, mes_nombre_gestion, dia_nombre_gestion, resultado_tipificacion, unico, tipo_tipificado, tipo_contacto, tipo_efectividad, ranking, tipo_tipificacion, agrupacion_tip, agrupacion_bi, nombre_agente, nombre_jefe, fecha_ingreso_agente, atendida, abandonada, cancelada, tiempo_total, tiempo_respuesta, tiempo_espera, tiempo_atencion, tiempo_wrapup, tiempo_desercion, tiempo_hold, tiempo_requerido, tiempo_timbrando, prefijo, outboundprocessid_inconcert, batchid_inconcert, procedencia_base, skill_base, sub_skill_base, nombre_base, fecha_recibido_base, mes_base )
SELECT 
	i.Id  AS id_inconcert,
	CASE WHEN DATEADD( HOUR, -5, i.[StartDate] ) IS NULL THEN DATEADD( HOUR, -5, c.[Date] ) ELSE DATEADD( HOUR, -5, i.[StartDate] ) END AS fecha,
	RIGHT(CASE WHEN cl.CELULAR_CONTACTO IS NULL THEN REPLACE(REPLACE (REPLACE (REPLACE(REPLACE(i.ContactName, '[57]-[', ''),']-[',''), ']',''), '57-', ''), '-','') ELSE cl.CELULAR_CONTACTO END , 10)  AS telefono,
	CASE WHEN i.ContactId = ''  THEN i.Id ELSE i.ContactId END AS id_gss,
	t.id_resultado AS id_result,
	'InteractionDetail'  AS tabla, 
	i.LastAgent AS id_agente,
	CASE WHEN CAST(DATEADD(HOUR, -5 ,i.[StartDate]) AS date) IS NULL THEN CAST(DATEADD(HOUR, -5, c.[Date]) AS date) ELSE CAST(DATEADD(HOUR, -5 ,i.[StartDate]) AS date) END  AS fecha_corta_gestion,
	CASE WHEN LEFT(CAST(DATEADD(HOUR, -5, i.[StartDate]) AS time), 8 ) IS NULL THEN LEFT(CAST(DATEADD(HOUR, -5, c.[Date]) AS time), 8 ) ELSE LEFT(CAST(DATEADD(HOUR, -5, i.[StartDate]) AS time), 8 ) END AS hora_gestion,
	CASE WHEN DATEPART(HH, DATEADD(HH, -5, i.[StartDate])) IS NULL THEN DATEPART(HH, DATEADD(HH, -5, c.[Date])) ELSE DATEPART(HH, DATEADD(HH, -5, i.[StartDate])) END AS intervalo_gestion,
	CASE WHEN DATEPART(YEAR, DATEADD(HOUR, -5 , i.[StartDate])) IS NULL THEN DATEPART(YEAR, DATEADD(HOUR, -5 , c.[Date])) ELSE DATEPART(YEAR, DATEADD(HOUR, -5 , i.[StartDate])) END AS anio_gestion,
	CONCAT('Semana ', (CASE WHEN DATEPART(WW,DATEADD(HOUR, -5 , i.[StartDate] )) IS NULL THEN DATEPART(WW,DATEADD(HOUR, -5 , c.[Date] )) ELSE DATEPART(WW,DATEADD(HOUR, -5 , i.[StartDate] )) END)) AS semana_anio_gestion, 
	CONCAT('Semana ', (CASE WHEN DATEPART(WEEK,DATEADD(HOUR, -5 , i.[StartDate] ))	-  DATEPART(WEEK, DATEADD(dd,-DAY(DATEADD(HOUR, -5 , i.[StartDate]))+1,DATEADD(HOUR, -5 , i.[StartDate] )))	+1   IS NULL THEN DATEPART(WEEK,DATEADD(HOUR, -5 , c.[Date] ))	-  DATEPART(WEEK, DATEADD(dd,-DAY(DATEADD(HOUR, -5 , c.[Date]))+1,DATEADD(HOUR, -5 , c.[Date] )))	+1  ELSE DATEPART(WEEK,DATEADD(HOUR, -5 , i.[StartDate] ))	-  DATEPART(WEEK, DATEADD(dd,-DAY(DATEADD(HOUR, -5 , i.[StartDate]))+1,DATEADD(HOUR, -5 , i.[StartDate] )))	+1  END )) AS semana_mes_gestion,
	CASE WHEN DATEPART(MONTH,DATEADD(HOUR, -5 ,i.[StartDate] )) IS NULL THEN DATEPART(MONTH,DATEADD(HOUR, -5 ,c.[Date] )) ELSE DATEPART(MONTH,DATEADD(HOUR, -5 ,i.[StartDate] )) END AS mes_num_gestion,
	CASE WHEN DATENAME(MONTH,DATEADD(HOUR, -5 , i.[StartDate] )) IS NULL THEN DATENAME(MONTH,DATEADD(HOUR, -5 , c.[Date] )) ELSE DATENAME(MONTH,DATEADD(HOUR, -5 , i.[StartDate] )) END AS mes_nombre_gestion,
	CASE WHEN DATENAME(DW,DATEADD(HOUR, -5 , i.[StartDate])) IS NULL THEN DATENAME(DW,DATEADD(HOUR, -5 , c.[Date])) ELSE DATENAME(DW,DATEADD(HOUR, -5 , i.[StartDate])) END AS dia_nombre_gestion,
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
	CASE WHEN i.IsTaked IS NULL THEN 0 ELSE i.IsTaked END AS atendidas, 
	CASE WHEN i.IsAbandoned IS NULL THEN 0 ELSE i.IsAbandoned END AS abandonadas, 
	CASE WHEN i.IsCancelled IS NULL THEN 0 ELSE i.IsCancelled END AS canceladas, 
	CASE WHEN i.DurationTime IS NULL THEN 0 ELSE i.DurationTime END AS tiempo_total, 
	CASE WHEN i.AnswerTime IS NULL THEN 0 ELSE i.AnswerTime END AS tiempo_respuesta,
	CASE WHEN i.WaitTime IS NULL THEN 0 ELSE i.WaitTime END AS tiempo_espera,
	CASE WHEN i.AttentionTime IS NULL THEN 0 ELSE i.AttentionTime END AS tiempo_atencion, 
	CASE WHEN i.WrapupTime IS NULL THEN 0 ELSE i.WrapupTime END AS tiempo_wrapup, 
	CASE WHEN i.DesertionTime IS NULL THEN 0 ELSE i.DesertionTime END AS tiempo_desercion, 
	CASE WHEN i.HoldTime IS NULL THEN 0 ELSE i.HoldTime END AS tiempo_hold, 
	CASE WHEN i.RequeuedTime IS NULL THEN 0 ELSE i.RequeuedTime END AS tiempo_requerido, 
	CASE WHEN i.RingingTime IS NULL THEN 0 ELSE i.RingingTime END AS tiempo_timbrando,
	i.Prefix AS prefijo,
	i.OutboundProcessId AS outboundprocessid_inconcert,
	i.BatchId AS batchid_inconcert,
	p.procedencia AS procedencia_base,
	s.skill AS skill_base,
	s.nombre AS sub_skill_base,
	b.nombre AS nombre_base,
	b.fecha_recibido AS fecha_recibido_base,
	b.mes_base AS mes_base



--INTO InformesTelecolombia.dbo.bi_all_managements
FROM InformesTelecolombia.dbo.HistoricalData_InteractionDetail AS i
LEFT JOIN InformesTelecolombia.dbo.HistoricalData_ContactResultDetail AS c ON c.InteractionId  = i.Id
INNER JOIN InformesTelecolombia.dbo.bi_tipificaciones AS t ON t.resultado  = i.[Disposition]
LEFT JOIN InformesTelecolombia.dbo.bi_agentes AS ag ON ag.identificacion  = i.FirstAgent
LEFT JOIN InformesTelecolombia.dbo.bi_staff AS st ON st.id_staff  = ag.id_staff
LEFT JOIN InformesTelecolombia.dbo.bi_asignacion AS an ON an.id_gss = i.ContactId
LEFT JOIN InformesTelecolombia.dbo.bi_bases AS b ON b.id = an.id_base 
LEFT JOIN InformesTelecolombia.dbo.bi_servicios AS s ON s.id = b.id_servicio
LEFT JOIN InformesTelecolombia.dbo.bi_procedencias AS p ON p.id = b.Id_procedencia 
LEFT JOIN InformesTelecolombia.dbo.Clientes AS cl ON cl.ID = i.ContactId
--LEFT JOIN InformesTelecolombia.dbo.bi_all_managements AS a ON a.id_inconcert  = i.Id 
--														   AND a.id_gss  = i.ContactId 

--WHERE a.id_inconcert IS NULL
where CAST(i.[StartDate] AS DATE) >= @Fecha
AND CAST(i.[StartDate] AS DATE) < @Hoy
AND i.VirtualCC = 'telecolombia' ;
