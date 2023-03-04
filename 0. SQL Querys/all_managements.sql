USE [InformesColpatria]
GO
/****** Object:  StoredProcedure [dbo].[sp_bi_allmanagement_original]    Script Date: 11/01/2022 9:47:18 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_bi_allmanagement_original] AS 
DECLARE @Fecha as date

SET  @Fecha  = cast( dateadd (day, -1 ,getdate()) as date)

--/* Eliminar all management para evitar duplicados */


--DELETE FROM InformesColpatria.dbo.bi_all_managements
--WHERE CAST ( fecha AS date ) >= @Fecha

--/* Insertar Gestiones a allmanagement */
--INSERT INTO InformesColpatria.dbo.bi_all_managements(id_inconcert, fecha, telefono, id_gss, id_result, tabla, id_agente)
SELECT 
	 g.LastInteractionId AS id_inconcert,
	 g.TmStmp  AS fecha,
	 replace(replace (replace (replace(replace(ContactAddress, '[57]-[', ''),']-[',''), ']',''), '57-', ''), '-','') AS telefono,
	 g.ContactId  AS id_gss,
	 g.ManagementResultCode  AS id_result,
	 'Gestiones'  AS tabla,
	 g.LastAgent AS id_agente
--INTO InformesColpatria.dbo.bi_all_managements
FROM InformesColpatria.dbo.Gestiones AS g
LEFT JOIN InformesColpatria.dbo.bi_all_managements AS a ON a.id_inconcert  = g.LastInteractionId 
														   AND a.id_gss  = g.ContactId 
														   AND a.tabla  = 'GESTIONES' 
--WHERE a.id_inconcert IS NULL
AND CAST(g.TmStmp AS DATE) >= @Fecha;

--/* Insertar ContactResultDetails a allmanagement */
--INSERT INTO InformesColpatria.dbo.bi_all_managements(id_inconcert, fecha, telefono, id_gss , id_result, tabla, id_agente)
SELECT 
	c.InteractionId  AS id_inconcert,
	DATEADD( HOUR, -5, C.[Date] ) AS fecha,
	replace(replace (replace (replace(replace(c.DestinationAddress, '[57]-[', ''),']-[',''), ']',''), '57-', ''), '-','')  AS telefono,
	c.Id  AS id_gss,
	t.id_resultado AS id_result,
	'ContactResultDetail'  AS tabla, 
	c.Agent AS id_agente
--INTO InformesColpatria.dbo.bi_all_managements
FROM InformesColpatria.dbo.ContactResultDetail AS c
INNER JOIN InformesColpatria.dbo.bi_tipificaciones AS t ON t.resultado  = c.[Result] 
LEFT JOIN InformesColpatria.dbo.bi_all_managements AS a ON a.id_inconcert  = c.InteractionId 
														   AND a.id_gss  = c.Id 
														   AND a.tabla  = 'ContactResultDetail' 
WHERE CAST(c.[Date] AS DATE) >= @Fecha
AND c.VirtualCC = 'colpatria'
--AND a.id_inconcert IS NULL;