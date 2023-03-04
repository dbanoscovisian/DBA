SELECT TOP 3 TmStmp FROM [dbo].[Gestiones] Where CAST(TmStmp AS date) >= '2021-12-01'
ORDER BY TmStmp DESC
	
	SELECT TOP 3 CAST (DATEADD(hh,-5, Date) AS datetime) datecontactresult FROM [dbo].[HistoricalData_ContactResultDetail] 
	Where CONVERT(date, Date, 0) >= '2021-12-01'
	ORDER BY Date DESC

	SELECT TOP 3 CAST (DATEADD(hh,-5,StartDate) AS datetime) stardateinteractiondetail FROM [dbo].[HistoricalData_InteractionDetail]
	Where cast(StartDate as date ) >= '2021-12-01'
	ORDER BY StartDate  DESC