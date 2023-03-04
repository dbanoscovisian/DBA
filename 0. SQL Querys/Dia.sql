select TmStmp, CelularGestionar, Validador, ObservacionesValidador, TipoVenta, NumeroDocumento, IdEstadoVenta, FechaValidacion, TipoVenta,* from InformesClaro..Gestiones
where CelularGestionar ='3028309493'


select * from InformesClaro..EstadoVentas

update InformesClaro..Gestiones
set TmStmp='2021-02-18 08:00:52.000'
where LastInteractionId='4366D68DE7B94858B84B9CE99841F7BD'



DELETE  FROM InformesClaro..Gestiones
WHERE LastInteractionId='EB2AB4D2FEDE44B0B003150114F8F32E'

select * from InformesClaro..Usuarios
where Cedula like'%1016005379%'

select * from InformesClaro..Clientes
where ID='CLAROMED-2873542' 


select * from InformesClaro..Clientes
where CELULAR_1 = '3188799790'


SELECT * FROM InformesClaro..Clientes
where SUBSTRING(ID,7,100) >= 19903658
and MES = '8'
and IdCliente = '1'


select * from InformesClaro..Puente_Informe
where ID = 'CLARO-19980026'


update InformesClaro..Gestiones
set TmStmp='2020-11-27 08:49:59.000'
where LastInteractionId='0273CD9DD816405E910AAD7BCDA6555A'


select * from InformesClaro..Usuarios
where Nombre like'%tiga%'



select  * from InformesClaro..Gestiones
where TmStmp>='2021-09-03 00:19:04.000'
ORDER BY TmStmp desc


update InformesClaro..Usuarios
set IdRol=2
where Usuario='1106482387'



select 
CASE WHEN Observaciones LIKE '%EMPAQU%' THEN 'EMPAQUETAMIENTO' ELSE 'VENTA NUEVA' END AS TT,
Observaciones, FechaValidacion, 'Outbound', Validador, LastAgent, NombresCompletos, 'CC', NumeroDocumento, CorreoElectronico, Departamento, Ciudad, Barrio, DireccionCorrespondencia, 
Celular, Telefono, Estrato, TipoVenta,
CASE WHEN Observaciones LIKE '%EMPAQU%' THEN 'EMPAQUETAMIENTO' ELSE 'VENTA NUEVA' END AS TT,
Politica, '','','','', '', RentaMensual, Television, Internet, Voz, Adicionales1, ObservacionesValidador, Suscriptor, Convergente, '', OrdenTrabajo, '25/11/2020', IdEstadoVenta, ''
, FechaInstalacion, Franja

 from InformesClaro..Gestiones
where FechaValidacion>='2020-11-26 00:19:04.000'
and Nivel2='venta'
and TipoVenta='fija'

select * from InformesClaro..Gestiones