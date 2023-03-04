--  sparta_bcs
EXECUTE spDatiBCS_PRG_mese_nostr;

-- sparta_users
EXECUTE spUtentiTeamOggi ;

-- cruscotto
SELECT * FROM vcruscottototsett2 ;

-- PianiMese_Global
EXECUTE [spDatiAvanzamentoCumulato] '2022-06-01' ;

-- CheckErroriTS_Global
WITH ING AS
(SELECT [tl002_Data_tl001]
		, [tl002_IDAnagrafica_tl001]
		, MIN([tl002_Mezzora_ru000]) AS FIRST
  FROM [Sparta2].[dbo].[tl002_TimeSheetMezzore] WITH(NOLOCK)
  WHERE  tl002_Data_tl001=CAST(GETDATE() AS date) 
		AND tl002_AttivitaOra_ru059 IN (SELECT ru059_Cod 
										FROM ru059_AttivitaOre WITH(NOLOCK)) 
		AND tl002_IDTipoTimeSheet_tl003= 1
		and tl002_IDAnagrafica_tl001 = '90080752'
  GROUP BY [tl002_Data_tl001]
		,[tl002_IDAnagrafica_tl001]
),

TMS AS
(SELECT [tl016_IdSparta_ru001]
		, MIN([tl016_stamp]) AS FIRST
  FROM [Sparta2].[dbo].[tl016_Badging] WITH(NOLOCK)
  WHERE  tl016_actionCode='I' 
		AND tl016_stamp>=CAST(GETDATE() AS date)
		AND tl016_IdSparta_ru001 ='90080752' 
  GROUP BY [tl016_IdSparta_ru001]
  
)
, ANAG AS
(SELECT team.ru025_Nome
		, an.ru001_ID
		, an.ru001_Cognome
		, an.ru001_Nome
		, sed.cg002_Descrizione
		, sed.cg002_SiteCountry_cf009
FROM [dbo].[ru027_ASsegnazioneTeam] at WITH(NOLOCK)
JOIN [dbo].[ru025_Team] team WITH(NOLOCK)
	ON team.ru025_IDTeam=at.ru027_IDTeam_ru025
JOIN [dbo].[ru001_Anagrafiche] an WITH(NOLOCK)
	ON an.ru001_ID=at.ru027_IDAnagrafica_ru001
JOIN [dbo].[ru050_ASsegnazioneSede] ASe WITH(NOLOCK)
	ON ASe.ru050_IDAnagrafica_ru001=an.ru001_ID
JOIN [dbo].[cg002_Sedi] sed WITH(NOLOCK)
	ON sed.cg002_IDSede=ASe.ru050_IDSede_cg002
WHERE (ru027_DataFine IS NULL OR ru027_DataFine>=GETDATE()) 
	AND team.ru025_TipoTeam='DIRETTO'
	AND (ASe.ru050_DataFine IS NULL OR ASe.ru050_DataFine>=GETDATE())
	AND cg002_SiteCorporate_cg005 = 2
)
SELECT ING.tl002_Data_tl001 AS Data
	, ING.tl002_IDAnagrafica_tl001 AS IDAnagrafica
	, ANAG.ru001_Cognome + ' '+ ANAG.ru001_Nome+ ' ('+ LTRIM(RTRIM(CAST( ING.tl002_IDAnagrafica_tl001  AS CHAR)))+')' AS Utente
	, ANAG.ru025_Nome AS Team
	, ANAG.cg002_Descrizione AS Ditta
	, ANAG.cg002_SiteCountry_cf009 AS Country
	, CAST(LEFT(ING.FIRST,2) + ':' + RIGHT(ING.FIRST,2) AS TIME) AS TS
	, CAST(TMS.FIRST AS TIME) AS BADGE
	, DATEDIFF(N,CAST(LEFT(ING.FIRST,2) + ':' + RIGHT(ING.FIRST,2) AS TIME), CAST(TMS.FIRST AS TIME)) AS DELAY
	, CAST(ABS(DATEDIFF(N,CAST(LEFT(ING.FIRST,2) + ':' + RIGHT(ING.FIRST,2) AS TIME), CAST(TMS.FIRST AS TIME)))/60.0 AS FLOAT) AS ERRH
FROM ING WITH(NOLOCK)
JOIN TMS 
	ON TMS.tl016_IdSparta_ru001=ING.tl002_IDAnagrafica_tl001
JOIN ANAG 
	ON ANAG.ru001_ID=ING.tl002_IDAnagrafica_tl001
WHERE ABS(DATEDIFF(N,CAST(LEFT(ING.FIRST,2) + ':' + RIGHT(ING.FIRST,2) AS TIME), CAST(TMS.FIRST AS TIME)))>15 


-- Tablas conseguidas en el giallo 
SELECT * FROM Sparta2.dbo.tl002_TimeSheetMezzore WITH(NOLOCK) -- Coonexion con mezzero
SELECT * FROM Sparta2.dbo.tl016_Badging WITH(NOLOCK) ;-- Conexiones bading 
SELECT * FROM Sparta2.dbo.ru001_Anagrafiche WITH(NOLOCK) ;-- Datos de personal de sparta
SELECT * FROM Sparta2.dbo.ru027_ASsegnazioneTeam WITH(NOLOCK) ; -- Todos los cambios de team y funzione con fecha inizio y finale
SELECT * FROM Sparta2.dbo.ru025_Team WITH(NOLOCK) ;-- Datos de teams de sparta con fecha de activación, id de team, nombre de team, tipo de contrato team
SELECT * FROM Sparta2.dbo.ru050_ASsegnazioneSede WITH(NOLOCK) ;-- - Todos los cambios de sedes y funzione con fecha inizio y finale
SELECT * FROM Sparta2.dbo.cg002_Sedi WITH(NOLOCK) ;-- Datos de sedes, con pais de sede
SELECT * FROM Sparta2.dbo.tl002_TimeSheetMezzore WITH(NOLOCK) ; -- Consultivas programadas e iniciales por usuario de sparta
SELECT * FROM Sparta2.dbo.cg001_Ditte WITH(NOLOCK) ;-- Negocios o dittas de sparta con id y nombre
SELECT * FROM ru059_AttivitaOre WITH(NOLOCK) ; -- Estados activos ore




-- Aux_sparta_users_full (Query para toda la planta sparta (Cololmbia)
SELECT	
	an.ru001_ID AS IDAnagrafica,
	an.ru001_Cognome AS Cognome,
	an.ru001_Nome AS Nome,
	te.ru025_Nome AS Team,
	an.ru001_Matricola AS Matricola,
	CASE WHEN sed.cg002_SiteCountry_cf009 = 'CO' THEN 'AVANZA COLOMBIA' ELSE 'OTHER' END AS Ditta,
	sed.cg002_Descrizione AS Sede,
	sed.cg002_IDSede AS IDSede,
	NULL AS UtenteSparta,
	CASE 
		WHEN at.ru027_IDFunzione_ru026 = '1' THEN 'Operatore'
		WHEN at.ru027_IDFunzione_ru026 = '2' THEN 'ViceTeamLeader'
		WHEN at.ru027_IDFunzione_ru026 = '3' THEN 'TeamLeader'
		WHEN at.ru027_IDFunzione_ru026 = '4' THEN 'Staff'
		WHEN at.ru027_IDFunzione_ru026 = '5' THEN 'Manager'
		ELSE 'Other'
	END AS Funzione,
	an.ru001_CodiceFiscale AS CodiceFiscale,
	NULL AS GruppoPianificazione,
	CASE WHEN ISDATE(CAST(ase.ru050_DataInizio AS nvarchar)) = 0 THEN NULL ELSE ase.ru050_DataInizio END AS InizioContratto,
	te.ru025_TipoTeam AS TipoTeam,
	CASE WHEN ISDATE(CAST(an.ru001_DataNascita AS nvarchar)) = 0 THEN NULL ELSE ru001_DataNascita END AS DataNascita, 
	an.ru001_Email AS Email,
	an.ru001_Genere AS Genere,
	CAST(CASE WHEN ISNUMERIC(REPLACE(RIGHT(an.ru001_Cellulare,10),'.','')) = 0 THEN NULL ELSE REPLACE(RIGHT(an.ru001_Cellulare,10),'.','') END AS bigint) AS Cellulare,
	CAST(ba.tl016_stamp AS date) AS last_login
FROM Sparta2.dbo.ru001_Anagrafiche AS an
LEFT JOIN (	SELECT 
			*
		FROM Sparta2.dbo.ru027_ASsegnazioneTeam WITH(NOLOCK)  
		WHERE ru027_DataFine IS NULL ) AS at ON an.ru001_ID = at.ru027_IDAnagrafica_ru001
LEFT JOIN Sparta2.dbo.ru025_Team AS te WITH(NOLOCK) ON te.ru025_IDTeam = at.ru027_IDTeam_ru025
LEFT JOIN ( SELECT
			*
	   FROM	Sparta2.dbo.ru050_ASsegnazioneSede WITH(NOLOCK)
	   WHERE ru050_DataFine IS NULL ) AS ase ON ase.ru050_IDAnagrafica_ru001=an.ru001_ID
LEFT JOIN Sparta2.dbo.cg002_Sedi AS sed WITH(NOLOCK) ON sed.cg002_IDSede=ASe.ru050_IDSede_cg002
LEFT JOIN ( SELECT 
			q.*
		FROM
			(
				SELECT 
					ROW_NUMBER ( ) OVER ( PARTITION BY b.tl016_IdSparta_ru001 ORDER BY b.tl016_IdSparta_ru001 ASC, b.tl016_stamp DESC) AS rownumber,
					* 
				FROM Sparta2.dbo.tl016_Badging AS b WITH(NOLOCK)
				JOIN Sparta2.dbo.cg002_Sedi AS s WITH(NOLOCK) ON b.tl016_IdSite_cg002 = s.cg002_IDSede
				--HERE s.cg002_SiteCountry_cf009 = 'CO'
													) AS q
		WHERE q.rownumber = 1 ) AS ba ON an.ru001_ID = ba.tl016_IdSparta_ru001
WHERE sed.cg002_SiteCountry_cf009 = 'CO' ;