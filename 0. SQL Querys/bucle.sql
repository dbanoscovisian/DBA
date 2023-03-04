DECLARE @FechaI AS datetime
DECLARE @FechaF AS datetime
SET @FechaI = GETDATE() - 1000
SET @FechaF = GETDATE() + 1000
PRINT @FechaI
PRINT @FechaF

WHILE @FechaI <= @FechaF



	BEGIN
	--TRUNCATE TABLE business_intelligence.dbo.base_fecha
	INSERT INTO business_intelligence.dbo.base_fecha
		SELECT 
			CAST (@FechaI AS DATE) AS fecha,
			DATEPART(YEAR, @FechaI) AS anio,
			CONCAT('Semana ', DATEPART(WW,@FechaI)) AS semana_anio,
			CONCAT('Semana ', DATEPART(WEEK,@FechaI)	-  DATEPART(WEEK, DATEADD(dd,-DAY(@FechaI)+1,@FechaI))	+1  ) AS semana_mes,
			DATEPART(MONTH,@FechaI) AS mes_num,
			DATENAME(MONTH,@FechaI) AS mes_nombre,
			DATENAME(DW,@FechaI) AS dia_nombre,
			DATEPART(WEEKDAY,@FechaI) AS dia_num,
			CASE WHEN DATEPART(MONTH,@FechaI) IN (1,2,3) THEN 1 
						WHEN DATEPART(MONTH,@FechaI)  IN (4,5,6) THEN 2 
							WHEN DATEPART(MONTH,@FechaI)  IN (7,8,9) THEN 3 ELSE 4 END trimestre,
			CASE WHEN DATEPART(WEEKDAY,@FechaI)  <=5 THEN 1 
						WHEN DATEPART(WEEKDAY,@FechaI) = 6 THEN 0.5 ELSE 0 END habil_general

		
		SET @FechaI = @FechaI + 1 

			
	END
