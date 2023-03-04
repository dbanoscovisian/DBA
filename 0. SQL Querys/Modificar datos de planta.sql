update CubosTelefonia..Asignacion_OUT
set NombreJefe = 'Sebastian Andres Gonzalez Beltran'
where Documento_vEmpleados = '1010031911' 
and CentroCosto like '%CLARO%'

select * from CubosTelefonia..Asignacion_OUT
where Documento_vEmpleados = '1010031911'

where DOCUMENTO = '1010031911'