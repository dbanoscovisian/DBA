UPDATE c
SET c.CELULAR_CONTACTO = a.CELULAR_CONTACTO
FROM clientes AS c
INNER JOIN InformesTelecolombia.dbo.bi_asignacion AS a ON a.id_gss = c.id
WHERE a.id_base IN  (343,344)