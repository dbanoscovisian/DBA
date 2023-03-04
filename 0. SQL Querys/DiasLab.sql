DECLARE @FecIni AS date
DECLARE	@FecFin AS date
DECLARE	@DiasLab AS float
DECLARE	@DiasNoLab AS float
DECLARE	@Festivo1 AS float
DECLARE	@Festivo2 AS float
DECLARE	@Festivo3 AS float

SET @FecIni = '2022-03-01'
SET @FecFin = '2022-03-31'
SET @DiasLab = 0.0
SET @DiasNoLab = 0.0
SET @Festivo1 = CASE WHEN CAST( GETDATE() AS date) >= '2022-01-01' THEN 0.5 ELSE 0 END
SET @Festivo2 = CASE WHEN CAST( GETDATE() AS date) >= '2022-01-10' THEN 1 ELSE 0 END
SET @Festivo3 = CASE WHEN CAST( GETDATE() AS date) >= '2099-01-01' THEN 1 ELSE 0 END


WHILE(@FecIni < @FecFin) BEGIN

/*Laborables semana*/
	IF DATEPART(WEEKDAY,@FecIni) <= 5
		SET @DiasLab = @DiasLab + 1;
/*Laborables sabado*/
	IF DATEPART(WEEKDAY,@FecIni) = 6
	SET @DiasLab = @DiasLab + 0.5;
/*No laborables domingo*/
	IF DATEPART(WEEKDAY,@FecIni) = 7
		SET @DiasNoLab = @DiasNoLab + 1;
	
	SET @FecIni = DATEADD(dd,1,@FecIni)	;
END
SELECT @DiasLab - @Festivo1 - @Festivo2 - @Festivo3 AS dias_laborables,
	   @DiasNoLab + @Festivo1 + @Festivo2 + @Festivo3 AS dias_noLaborables,
	   (@DiasLab + @DiasNoLab ) AS total_dias,
	   '' AS mes,
	   '' AS pais