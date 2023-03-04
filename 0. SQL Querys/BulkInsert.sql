BULK INSERT [dbo].[Clientes]
FROM '\\10.80.40.235\Informes_BI\Telefonica_colombia\PYM_WB_TIGO_AVA_271021_120.csv' 
	WITH 
		( FIRSTROW = 2 -- Primera Fila
		, FIELDTERMINATOR=';'  -- Separado por ; o delimitador (columnas)
		, ROWTERMINATOR='\n'  --Separado por intro (filas) 
		, KEEPNULLS )  -- Permite campos nulls