USE TLMKT

--DELETE FROM [dbo].[blacklistrep]

--BULK INSERT [dbo].[blacklistrep]
--FROM '\\10.80.40.35\BI Claro\dev\Tele México\Blacklist\Cliente\Lista de Total.csv' 
--	WITH 
--		( FIRSTROW = 2 -- Primera Fila
--		, FIELDTERMINATOR=';'  -- Separado por ; o delimitador (columnas)
--		, ROWTERMINATOR='\n'  --Separado por intro (filas) 
--		,KEEPNULLS )  -- Permite campos nulls


CREATE TABLE #blacklistrep (

	 [TELEFONO] [varchar](50) NOT NULL
	,[Telecomunicaciones] [varchar](50) NOT NULL
	,[Turístico] [varchar](50) NOT NULL
	,[Comercio] [varchar](50) NOT NULL
	,[EXT] [varchar](50) NOT NULL


 --CONSTRAINT [PK__#Blacklist__DN] PRIMARY KEY CLUSTERED 
--(
--	[DN] ASC
--)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]



INSERT INTO #blacklistrep
SELECT 
			[TELEFONO]
			,[Telecomunicaciones]
			,[Turístico]
			,[Comercio]
			,[EXT]
FROM (
		SELECT
			ROW_NUMBER ( ) OVER ( PARTITION BY  [TELEFONO] ORDER BY [TELEFONO]) AS rownumber,	
			*
		FROM
			TLMKT.dbo.blacklistrep ) AS du
WHERE du.rownumber = 1

DELETE FROM [dbo].[blacklistrep]

INSERT INTO TLMKT.dbo.blacklistrep
SELECT DISTINCT 
			[TELEFONO]
			,[Telecomunicaciones]
			,[Turístico]
			,[Comercio]
			,[EXT]

			
FROM #blacklistrep  ;

DROP TABLE #blacklistrep ;

SELECT  * 
FROM [dbo].[Clientes] as cli
inner JOIN [dbo].[blacklistrep] as Bl ON Bl.TELEFONO=cli.DNI
