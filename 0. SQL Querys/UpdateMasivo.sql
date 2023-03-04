UPDATE c
SET c.apellidos = a.ult4dig_tc1
FROM clientes AS c
INNER JOIN InformesColpatria.dbo.bi_asignacion AS a ON a.id_gss = c.id;



UPDATE c
SET c.apellidos = a.Apellidos
FROM [10.80.40.119].Colpatria.dbo.Clientes as c
INNER JOIN InformesColpatria.dbo.Clientes AS a ON a.Id = c.id;