SELECT 
	REPLACE(DATE, '-', ''),
	'|',
	'GSS_CONTACT_CENTER',
	'|',
	CAST(SUM(LoggedTime*24) AS int),
	'|',
	CAST(SUM(LoggedTime*24) AS int)/12,
	'|'
	'COLOMBIA',
	'|',
	'BOGOTA',
	'|',
	'PORTABILIDAD',
	'|',
	'SITE'
FROM [TLMKT].[dbo].[v_SabanaLogueo]
group by DATE
