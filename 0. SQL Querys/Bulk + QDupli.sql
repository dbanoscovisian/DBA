USE TLMKT

DELETE FROM [dbo].[blacklist]

BULK INSERT [dbo].[blacklist]
FROM '\\10.80.40.35\BI Claro\dev\Tele México\Blacklist\Cliente\LN.txt' 
	WITH 
		( FIRSTROW = 2 -- Primera Fila
		, FIELDTERMINATOR=';'  -- Separado por ; o delimitador (columnas)
		, ROWTERMINATOR='\n'  --Separado por intro (filas) 
		,KEEPNULLS )  -- Permite campos nulls


CREATE TABLE #blacklist (

	  [DN] [varchar](50) NOT NULL

 --CONSTRAINT [PK__#Blacklist__DN] PRIMARY KEY CLUSTERED 
--(
--	[DN] ASC
--)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]



INSERT INTO #blacklist
SELECT DN FROM (
		SELECT
			ROW_NUMBER ( ) OVER ( PARTITION BY  DN ORDER BY DN) AS rownumber,	
			*
		FROM
			TLMKT.dbo.blacklist ) AS du
WHERE du.rownumber = 1

DELETE FROM [dbo].[blacklist]

INSERT INTO TLMKT.dbo.blacklist
SELECT DISTINCT DN
FROM #blacklist  ;

DROP TABLE #blacklist ;

SELECT  * 
FROM [dbo].[Clientes] as cli
inner JOIN [dbo].[blacklist] as Bl ON Bl.DN=cli.DNI
