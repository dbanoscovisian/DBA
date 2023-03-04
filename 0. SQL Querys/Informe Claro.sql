	DECLARE @Fecha datetime = cast( dateadd (day, -2,getdate()) as date)


DROP TABLE [dbo].[A1_INFORME_CLARO_119]

Select
	case when Resumen_Gen.SKILL = 'FIJA' then '180' when inf.IdCliente ='1' then '107' else '133' end  as 'CANAL'
	, inf.CUENTA as 'ID_REGISTRO'
	, case when INF.CODIGO_TIP is null then '64' else INF.CODIGO_TIP end as 'ID_TIPIFICACION'
	, hora as 'HORA_GESTION'
	, inf.Fecha as 'FECHA_GESTION'
	, case when ASESOR = 'Maquina' then '0' else ASESOR end as 'ID_ASESOR_GESTION'
	, case when inf.IdCliente ='1' then '79547671' else '79689902' end  as 'ID_ESPECIALISTA'
	, case when Resumen_Gen.ESTRATO is null then '0' else Resumen_Gen.ESTRATO end as 'ESTRATO'
	, case when Resumen_Gen.NODO is null then '0' else Resumen_Gen.NODO end as 'NODO'
	, case when Resumen_Gen.COMUNIDAD is null then '0' else Resumen_Gen.COMUNIDAD end as 'COMUNIDAD'
	, case when Resumen_Gen.TIPO_DE_BBDD is null then 'REFERIDOS' else Resumen_Gen.TIPO_DE_BBDD end as 'NOMBRE BASE'
	, (CAST( GETDATE() AS DATE)) AS 'FECHA_CORTE'
	, CONVERT(INT,case when INF.CODIGO_TIP is null then '0' WHEN  INF.CODIGO_TIP>='64' THEN  0 else TiempoAtencion end ) as 'DURACION_LLAMADA'
	, case when OrdenTrabajo IS NULL then '' else OrdenTrabajo end as 'OT'
	, replace(replace (replace (replace(replace(Telefono, '[57]-[', ''),']-[',''), ']',''), '57-', ''), '-','') AS 'TELEFONO'
	, case when INF.CODIGO_TIP is null then 'NO_CONTACTOS-NO CONTESTAN' else CONCATENADO end as 'DETALLE_TIPIFICACION'
	, '' AS 'FECHA_PERMANENCIA' 
	, '' AS 'COMUNICACIONES'
	, CASE WHEN CorreoElectronico NOT LIKE '%@%' THEN '' 
		WHEN CorreoElectronico LIKE '%NOTIENE%'  THEN ''
		WHEN CorreoElectronico LIKE '%NOMANEJA%' THEN '' 
		WHEN CorreoElectronico LIKE '%NO@TIENE%' THEN '' 
		WHEN CorreoElectronico IS NULL THEN ''  ELSE CorreoElectronico END AS 'EMAIL'

	, '' AS 'USOLD'
	, '' AS 'TELEFONO ALTERNO'
	, '' AS 'DIRECCION ALTERNA'
	, '' AS 'CIUDAD'
	, '' AS 'NOMBRE CLIENTE'
	, inf.IdCliente AS 'IdCliente'
	, case when Resumen_Gen.IdCliente is null then '0' else Resumen_Gen.IdCliente end as 'IdCliente_2'
	, case when Resumen_Gen.MES is null then '0' else Resumen_Gen.MES end as 'Mes_Base'
	, DATEPART ( HH,  Hora) as 'Hora'
	, '1' as 'Unico'
	, case when inf.CODIGO_TIP  <= '63' then '1'  when inf.CODIGO_TIP in (71,72,73,74) then '1' else '0' end as 'CTO_'
	, case when inf.CODIGO_TIP  <= '60' then '1' else '0' end as 'Directo'
	, case when inf.CODIGO_TIP  <= '6' then '1' else '0' end as 'Vta_'
	, BS.[Dia Semana] as 'Dia semana'
	, BS.[Semana Mes] as 'Semana Mes'
	, BS.[Semana año] as 'Semana Año'
	, case when Resumen_Gen.DEPARTAMENTO_UBICACION is null then '-' else Resumen_Gen.DEPARTAMENTO_UBICACION end as 'Dptmto'
	, case when Resumen_Gen.SKILL is null then '-' else Resumen_Gen.SKILL end as 'Tipo base'
	, case when PL.[NOMBRE COMPLETO] is null then '-' else PL.[NOMBRE COMPLETO] end as 'Agente'
	, case when PL.[NOMBRE COMPLETO] is null then '-' else PL.[Supervisor] end as 'Super'
	, CONCAT (Inf.CUENTA, Resumen_Gen.TIPO_DE_BBDD) AS 'llave'
	, case when Resumen_Gen.CLIENTE_HOGAR is null then '-' else Resumen_Gen.CLIENTE_HOGAR end  as 'id'
	, case when AD.DIME IS NULL THEN '64' ELSE AD.DIME END AS 'CODIGO DIME'
	, CAST(inf.Fecha as varchar) as 'Fecha Dime'
	, LEFT(Hora,5) as 'hora ok'
	, case when inf.CODIGO_TIP  <= '6' and  Resumen_Gen.SKILL in ('MIGRACION','PORTABILIDAD') then  ( replace(replace (replace (replace(replace(Telefono, '[57]-[', ''),']-[',''), ']',''), '57-', ''), '-','')) when inf.CODIGO_TIP  <= '6' and  Resumen_Gen.SKILL in ('FIJA') THEN ( case when OrdenTrabajo IS NULL then '0' else OrdenTrabajo end ) else '0' end as 'Real'
	, case when inf.CODIGO_TIP  <= '6' then '1' when Resumen_Gen.MES = '10' then '1' else 0 end as 'Cargar'
	, case when CDE.Result IS NULL then 'CONNECTED' else CDE.Result end as 'Maquina'



 INTO [dbo].[A1_INFORME_CLARO_119]

 from InformesClaro..Informe as Inf

	 left join InformesClaro..Planta_Claro as PL ON PL.DOCUMENTO=Asesor
	 left join InformesClaro..BaseFecha as BS ON BS.Fecha2=Inf.Fecha
	 left join InformesClaro..HistoricalData_ContactResultDetail as CDE ON CDE.InteractionId=Inf.LastInteractionId
	 left join InformesClaro..ArbolDime as AD ON AD.TIPIFICACION=INF.CODIGO_TIP 
	 left join  (select * from (select ROW_NUMBER () over( partition by cuenta order by mes desc, cuenta desc) as Row2, * from (select  count ( cuenta ) as Rep ,* from (select * from
	(select ROW_NUMBER () over( partition by cuenta order by mes asc, cuenta) as Row ,CUENTA, TELEFONO_1, TELEFONO_2, TELEFONO_3, CELULAR_1, CELULAR_2, CELULAR_3, TIPO_DE_BBDD, ANIO, MES, ESTRATO, NODO, COMUNIDAD, SKILL, DEPARTAMENTO_UBICACION, CLIENTE_HOGAR, IdCliente  from InformesClaro..Clientes
	where ANIO ='2021'and mes in ('9','10')  and idcliente=1)  as resumen_bog where row=1


	union

	select * from (select ROW_NUMBER () over( partition by cuenta order by  mes asc, cuenta) as Row ,CUENTA, TELEFONO_1, TELEFONO_2, TELEFONO_3, CELULAR_1, CELULAR_2, CELULAR_3,
	TIPO_DE_BBDD, ANIO, MES, ESTRATO, NODO, COMUNIDAD, SKILL, DEPARTAMENTO_UBICACION, CLIENTE_HOGAR, IdCliente  from InformesClaro..Clientes
	where ANIO ='2021'and mes in ('9','10')  and idcliente=2)  as resumen_med where row=1) as resumen_general 
	group  by  CUENTA, TELEFONO_1, TELEFONO_2, TELEFONO_3, CELULAR_1, CELULAR_2, CELULAR_3, TIPO_DE_BBDD, ANIO, MES, ESTRATO, NODO, COMUNIDAD, SKILL, DEPARTAMENTO_UBICACION, CLIENTE_HOGAR, IdCliente, row ) as R1) as R2
	where Row2=1 ) AS Resumen_Gen 

	ON Resumen_Gen.CUENTA=Inf.CUENTA



 --WHERE inf.Fecha >='2021-10-06'
 WHERE inf.Fecha >= @Fecha
 and inf.TIPO_DE_BBDD <>'WEB CALL BACK'
 and Telefono not in ('null')
 and Asesor <> 'icagente' 


