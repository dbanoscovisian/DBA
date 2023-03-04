  select '180' as Canal, 'CR' AS TIPO_GESTION, AGENT, AGENT AS AGENT_2, DATE, LOGIN, LOGOUT
  ,CONVERT (NUMERIC(10,0), LoggedTime *86400) AS CONEXION
  ,CONVERT (NUMERIC(10,0), AttentionTime *86400) AS T_ACD
  ,CONVERT (NUMERIC(10,0), WrapupTime *86400) AS T_ACW
  ,CONVERT (NUMERIC(10,0), AvailTime *86400) AS DISPON
  ,CONVERT (NUMERIC(10,0), TotalPauseTime *86400) AS AUX
  , CantidadLlamadas
  ,CONVERT (NUMERIC(10,0), HoldTime *86400) AS HOLD

 

  FROM InformesClaro..ReporteLogueo as RL
  inner join InformesClaro..Planta_Claro as PL ON PL.DOCUMENTO=RL.Agent
  where CAMPAÑA = 'Outbound'
  and DATE >='2021-10-27'
 -- and date(login) not in ('null')
  ORDER BY DATE asc, login asc

