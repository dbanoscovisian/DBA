SELECT COUNT(*),
Result,
DATEPART(hh,DATEADD(hh,-5,Date)) AS Intervalo,Agent, 
CONVERT(date,DATEADD(hh,-5,Date)) AS Fecha
--,Campaign
FROM [10.80.40.118].[HISTORICALDATA_253].[dbo].[ContactResultDetail]
WHERE virtualCC = 'teleargentina' 
AND CONVERT(date,DATEADD(hh,-5,Date)) >='2021-03-15'
AND CONVERT(date,DATEADD(hh,-5,Date)) <='2021-03-24'
GROUP BY Result, 
		 DATEPART(hh,DATEADD(hh,-5,Date)),
		 Agent, 
		 CONVERT(date,DATEADD(hh,-5,Date))
		 --,Campaign