USE Telemexico ;

CREATE TABLE #aux_cargue( [Fecha] [date] NULL,
	[DNI] [varchar](50) NULL,
	[Proyecto] [varchar](50) NULL,
	[Tipo_Base] [varchar](50) NULL,
	[Perfil] [varchar](50) NULL,
	[Sentido] [varchar](50) NULL,
	[Sede] [varchar](50) NULL
) ON [PRIMARY]
GO

BULK INSERT #aux_cargue
  FROM '\\10.80.40.35\BI Claro\dev\Tele México\Bases\Cliente\TBL_PORTABILIDAD_GSS_04112021.csv'
  WITH
		( FIRSTROW = 1 -- Primera Fila
		, FIELDTERMINATOR=';'  -- Separado por ; o delimitador (columnas)
		, ROWTERMINATOR='\n'  --Separado por intro (filas) 
		,KEEPNULLS ) ; -- Permite campos nulls



INSERT INTO [dbo].[aux_clientes] (Fecha, DNI, Proyecto, Tipo_Base, Perfil, Sentido, Sede)

SELECT 	* 
FROM #aux_cargue ;

DROP TABLE #aux_cargue ;


SELECT  * 
FROM [dbo].[aux_clientes] ;



-- Insertar en Clientes 

--INSERT INTO [dbo].[Clientes]
--SELECT 
--	   CONCAT ('TelMex-', id_incremental) as [ID]
--      ,'Telemexico_portabilidad' as [CampanaInconcert]
--	  , YEAR ( Fecha ) as [Anio]
--      , MONTH ( Fecha ) as [Mes]
--      , DNI AS [DNI]
--      ,[Proyecto]
--      ,[Tipo_Base]
--      ,[Perfil]
--      ,[Sentido]
--      ,'NO_TIENE' as [Nombre_Completo]
--      ,'' as [Plan_Origen]
--      ,'' as [Celular]
--      ,'' as [Telefono]
--      ,'' as [TipoContacto]

--FROM [dbo].[aux_clientes]


--SELECT  * 
--FROM [dbo].[Clientes] as cli
--left JOIN [dbo].[Blacklist] as Bl ON Bl.DN=cli.DNI

