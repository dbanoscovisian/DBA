USE InformesTelecolombia
DELETE FROM InformesTelecolombia.dbo.Clientesback;

INSERT INTO InformesTelecolombia.dbo.Clientesback	
SELECT [ID]
      ,[ID_BASE]
      ,[NRO_REGISTRO]
      ,[Campana]
      ,[GRUPO_CAMPANA]
      ,[ESTRATEGIA]
      ,[NOMBRE_CLIENTE]
      ,[TIPO_DOCUMENTO]
      ,[DOCUMENTO]
      ,[DIRECCION]
      ,[ESTRATO]
      ,[BARRIO]
      ,[DEPARTAMENTO]
      ,[CIUDAD]
      ,[PRODUCTO]
      ,[PUERTOS_DISPONIBLES]
      ,[PROMEDIO_FACT]
      ,[MX_TENENCIA_CUENTA]
      ,[TEL_CONTACTO_1]
      ,[TEL_CONTACTO_2]
      ,[TEL_CONTACTO_3]
      ,[CELULAR_CONTACTO]
      ,[COD_PLAN_VOZ_ACTUAL]
      ,[NOM_PLAN_VOZ_ACTUAL]
      ,[COD_PLAN_BA_ACTUAL]
      ,[NOM_PLAN_BA_ACTUAL]
      ,[COD_PLAN_TV_ACTUAL]
      ,[NOM_PLAN_TV_ACTUAL]
      ,[OFERTA_1]
      ,[VLR_OFERTA1]
      ,[OFERTA_2]
      ,[VLR_OFERTA2]
      ,[OFERTA_3]
      ,[VLR_OFERTA3]
      ,[OFERTA_4]
      ,[VLR_OFERTA4]
      ,[OFERTA_5]
      ,[VLR_OFERTA5]
      ,[PROMEDIO_VALOR_LDN]
      ,[PROMOCION_OFERTA_MES]
      ,[VALOR_OFERTA1_SIN_IVA]
      ,[VALOR_OFERTA2_SIN_IVA]
      ,[VALOR_OFERTA3_SIN_IVA]
      ,[VALOR_OFERTA4_SIN_IVA]
      ,[VALOR_OFERTA5_SIN_IVA]
      ,[ULTIMO_VALOR_FACTURADO]
      ,[VELOCIDAD_MAXIMA_BA]
      ,[PROVEEDOR]
      ,[CLIENTE_COD_ATIS]
      ,[CUENTA_COD_ATIS]
      ,[TELEFONO_CONTRATADO]
      ,[PC_CODDANE_MUNICIPIO]
      ,[PC_CODDANE_LOCALIDAD]
      ,[CICLO_FACTURACION]
      ,[FECHA_ALTA_ABONADO]
      ,[CODIGO_CLIENTE_SCL]
      ,[CODIGO_ABONADO]
      ,[FECHA_ENVIO_BASE]
      ,[NOM_CONTACTO_AUTORIZADO1]
      ,[TEL_CONTACTO_AUTORIZADO1]
      ,[NOM_CONTACTO_AUTORIZADO2]
      ,[TEL_CONTACTO_AUTORIZADO2]
      ,[NOM_CONTACTO_AUTORIZADO3]
      ,[TEL_CONTACTO_AUTORIZADO3]
      ,[ZONA_COB]
      ,[REGIONAL_COMERCIAL]
      ,[NUM_ZONA_COB]
      ,[VARIACIONOF1]
      ,[VARIACIONOF2]
      ,[VARIACIONOF3]
      ,[VARIACIONOF4]
      ,[VARIACIONOF5]
      ,[CampanaInconcert]
      ,[CampanaGSS]
      ,[Anio]
      ,[Mes]
      ,[Skill]
      ,[SubSkill]
FROM (
		SELECT
			ROW_NUMBER ( ) OVER ( PARTITION BY  Id ORDER BY Id) AS rownumber,	
			*
		FROM
			InformesTelecolombia.dbo.Clientes
			where MES = 'ENERO'
			AND ANIO = 2022) AS q
WHERE q.rownumber = 1;


DELETE FROM  InformesTelecolombia.dbo.Clientes
			where MES = 'ENERO'
			AND ANIO = 2022

INSERT INTO InformesTelecolombia.dbo.Clientes
SELECT * FROM InformesTelecolombia.dbo.Clientesback;