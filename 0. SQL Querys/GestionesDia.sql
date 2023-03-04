DECLARE @Fecha AS date

SET  @Fecha  = CAST(DATEADD(DAY, 0 ,GETDATE()) AS date)

SELECT 
	  TmStmp,
      ContactId,
      ManagementResultDescription

FROM Gestiones
WHERE CAST( TmStmp AS date) = @Fecha
ORDER BY TmStmp DESC