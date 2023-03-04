
USE [InformesClaro]
GO

DECLARE @return_value int

EXEC @return_value = [dbo].[ReporteLog]
@FechaI = N'2021-10-01',
@FechaF = N'2021-10-31'

SELECT 'Return Value' = @return_value

GO
