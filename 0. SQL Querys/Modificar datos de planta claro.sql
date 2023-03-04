/****** Script for SelectTopNRows command from SSMS  ******/
update Planta_Claro 
set Supervisor = 'Sebastian Andres Gonzalez Beltran'

where DOCUMENTO = '1010031911'

select * from Planta_Claro
where DOCUMENTO = '1010031911'
update 

 


 select * from InformesClaro..Planta_Claro