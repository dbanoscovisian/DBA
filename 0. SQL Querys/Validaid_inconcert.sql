DECLARE @Id AS varchar(100)
SET @Id = '{F1A3E25E-78BB-4174-AAAA-93F9B70CEC4D}'

SELECT 
	*  
FROM InformesClaro.dbo.Informe
WHERE LastInteractionId = @Id

SELECT 
	* 
FROM InformesClaro.dbo.Gestiones
WHERE LastInteractionId = @Id


SELECT 
	* 
FROM InformesClaro.dbo.HistoricalData_ContactResultDetail
WHERE InteractionId = @Id
SELECT 
	* 
FROM InformesClaro.dbo.HistoricalData_InteractionDetail
WHERE Id = @Id