--SELECT 
--	cast(TmStmp as date) as fecha,
--	count(1) as cantidad
--FROM InformesClaro.dbo.Gestiones
--where cast(TmStmp as date) >= '2021-09-01'
--group by cast(TmStmp as date)
--order by cast(TmStmp as date) DESC ;


SELECT  
	CAST(TmStmp AS DATE) as Fecha, 
	count(LastInteractionId) as Gestiones,
	SUM(CASE WHEN du.rownumber = 1 THEN 1 ELSE 0 END) AS 'Sin Repetidos',
	SUM(CASE WHEN du.rownumber > 1 THEN 1 ELSE 0 END) AS 'Repetidos'
FROM



(
		SELECT 
			ROW_NUMBER ( ) OVER ( PARTITION BY  LastInteractionId ORDER BY LastInteractionId) AS rownumber,	
			TmStmp, LastInteractionId
		FROM


			InformesClaro.dbo.Gestiones AS GE
			--		left join InformesClaro..HistoricalData_InteractionDetail as ID ON ID.StartDate=GE.TmStmp 

		WHERE CAST(TmStmp AS DATE) >= '2021-09-21'
		AND CAST(TmStmp AS DATE) <= '2021-10-13') AS du
--WHERE q.rownumber = 1
group by cast(TmStmp as date)
order by cast(TmStmp as date) DESC ;

select * from InformesClaro..Gestiones 
where lastinteractionid ='6931E9C5BB144C0E8BB99446F2D4A306'


