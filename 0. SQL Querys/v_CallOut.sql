DECLARE @Fecha as date

SET  @Fecha  = cast( dateadd (day, -1 ,getdate()) as date)

SELECT	nombre_base,
		nro_registro,
		campana,
		celular_contacto,
		proveedor,
		codigo_abonado,
		CASE WHEN estado_gestion = 1 THEN 'SI' ELSE 'NO' END AS gestionado,
		fecha_gestion,
		CASE WHEN tipo_contacto = 1 THEN 'SI' ELSE 'NO' END AS contactado,
		CASE WHEN tipo_efectividad = 1 THEN 'VENTA' ELSE NULL END AS tipo_gestion,
		OFERTA_1 AS oferta_contratada,
		agrupacion,
		resultado AS campo,
		id_agente AS vendedor,
		id_resultado AS codigo_gestion,
		nro_peticion,
		codigo_producto,
		producto
FROM [InformesTelecolombia].[dbo].[bi_reportegeneral]
WHERE estado_gestion = 1
AND procedencia = 'MOVISTAR'
AND CAST( fecha_gestion AS date) >= @Fecha
--AND tipo_efectividad = 1 