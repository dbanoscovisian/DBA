USE desarrollo;
CREATE TABLE #aux_cargue(Id varchar(255) NULL,
						IdAsignacion varchar(255) NULL,
						NombreCampana varchar(255) NULL,
						Apellido varchar(255) NULL,
						Area varchar(255) NULL,
						Celular1 varchar(255) NULL,
						Celular2 varchar(255) NULL,
						Celular3 varchar(255) NULL,
						Ciudad varchar(255) NULL,
						ClienteBlindado varchar(255) NULL,
						CodigoTarifa1 varchar(255) NULL,
						CodigoTarifa2 varchar(255) NULL,
						CodigoTarifa3 varchar(255) NULL,
						Comunidad varchar(255) NULL,
						Contrato varchar(255) NULL,
						Corte varchar(255) NULL,
						Cuenta varchar(255) NULL,
						CuentaMatriz varchar(255) NULL,
						CuentasAlternas varchar(255) NULL,
						Direccion varchar(255) NULL,
						Division varchar(255) NULL,
						DivisionComercial varchar(255) NULL,
						Docsis30 varchar(255) NULL,
						Email varchar(255) NULL,
						Estrategia varchar(255) NULL,
						Estrato varchar(255) NULL,
						FechaNacimiento varchar(255) NULL,
						FechaUltimaOt varchar(255) NULL,
						FechaVinculacion varchar(255) NULL,
						Mintic varchar(255) NULL,
						Nodo varchar(255) NULL,
						Nombre varchar(255) NULL,
						NumDecosAdi varchar(255) NULL,
						NumDecosAdicionalesTV varchar(255) NULL,
						NumeroIdentificacion varchar(255) NULL,
						Paquete varchar(255) NULL,
						ProbabilidadVenta varchar(255) NULL,
						Renta varchar(255) NULL,
						RentaAdicionales varchar(255) NULL,
						RentaBasico varchar(255) NULL,
						RentaTotalIva varchar(255) NULL,
						SegmentoCliente varchar(255) NULL,
						ServicioInternet varchar(255) NULL,
						ServicioTv varchar(255) NULL,
						ServicioVoz varchar(255) NULL,
						Tarifa varchar(255) NULL,
						Telefono1 varchar(255) NULL,
						Telefono2 varchar(255) NULL,
						Telefono3 varchar(255) NULL,
						TelefonoTelmex varchar(255) NULL,
						TipoAdulto varchar(255) NULL,
						TipoClaroVideo varchar(255) NULL,
						TipoFox varchar(255) NULL,
						TipoHbo varchar(255) NULL,
						TipoHd varchar(255) NULL,
						TipoIdent varchar(255) NULL,
						TipoOtros varchar(255) NULL,
						TipoPaquetes varchar(255) NULL,
						TipoRevista varchar(255) NULL,
						TrabajoRevista varchar(255) NULL,
						Zona varchar(255) NULL,
						Incremento1 varchar(255) NULL,
						RentaIncremento1 varchar(255) NULL,
						TarifaMigrar1 varchar(255) NULL,
						NombrePaqueteAMigrar1 varchar(255) NULL,
						Incremento2 varchar(255) NULL,
						RentaIncremento2 varchar(255) NULL,
						TarifaMigrar2 varchar(255) NULL,
						NombrePaqueteAMigrar2 varchar(255) NULL,
						Incremento3 varchar(255) NULL,
						RentaIncremento3 varchar(255) NULL,
						TarifaMigrar3 varchar(255) NULL,
						NombrePaqueteAMigrar3 varchar(255) NULL,
						PreapobadosPorCartera varchar(255) NULL,
						Oferta1 varchar(255) NULL,
						Oferta2 varchar(255) NULL,
						Oferta3 varchar(255) NULL,
						ValorOferta1 varchar(255) NULL,
						ValorOferta2 varchar(255) NULL,
						ValorOferta3 varchar(255) NULL,
						DiferenciaOferta1 varchar(255) NULL,
						DiferenciaOferta2 varchar(255) NULL,
						DiferenciaOferta3 varchar(255) NULL,
						CodigoPolitica1 varchar(255) NULL,
						CodigoPolitica2 varchar(255) NULL,
						CodigoPolitica3 varchar(255) NULL,
						TipoOferta1 varchar(255) NULL,
						TipoOferta2 varchar(255) NULL,
						TipoOferta3 varchar(255) NULL,
						PreaprobadoPorCartera varchar(255) NULL,
						NumDecosHd varchar(255) NULL,
						DecosHd varchar(255) NULL,
						NumDecosEstandar varchar(255) NULL,
						PaquetesAMigrar varchar(255) NULL,
						IncrementoRenta varchar(255) NULL,
						RentaIncremento varchar(255) NULL,
						TarifaAMigrar varchar(255) NULL,
						HaVistoPpvUltimos3Meses varchar(255) NULL,
						CupoCalculado varchar(255) NULL,
						CampoOpcional2 varchar(255) NULL,
						IdLista varchar(255) NULL,
						CampoOpcional4 varchar(255) NULL,
						CampoOpcional5 varchar(255) NULL,
						TeleNum varchar(255) NULL,
						Estado varchar(255) NULL,
						NombreCliente varchar(255) NULL,
						TipoCliente varchar(255) NULL,
						Antiguedad varchar(255) NULL,
						CalificacionCliente varchar(255) NULL,
						TmcodeActual varchar(255) NULL,
						TipoProducto varchar(255) NULL,
						SegmentoPlan varchar(255) NULL,
						TecnologiaPlan varchar(255) NULL,
						DesTmcode varchar(255) NULL,
						CfmPlan varchar(255) NULL,
						SpCode varchar(255) NULL,
						DesSpcode varchar(255) NULL,
						TecnologiaPaquete varchar(255) NULL,
						CfmPaq varchar(255) NULL,
						Arpu varchar(255) NULL,
						DetalleServicioAdicionales varchar(255) NULL,
						ComportamientoPago varchar(255) NULL,
						ConsumoDatosMes1 varchar(255) NULL,
						ConsumoDatosMes2 varchar(255) NULL,
						ConsumoDatosMes3 varchar(255) NULL,
						MouMes varchar(255) NULL,
						TipoEquipo varchar(255) NULL,
						Tickler varchar(255) NULL,
						Desactiv varchar(255) NULL,
						PlanPar varchar(255) NULL,
						Ajustes varchar(255) NULL,
						MinutosIncluidos varchar(255) NULL,
						MegasIncluidas varchar(255) NULL,
						ICCID varchar(255) NULL,
						Custcode varchar(255) NULL,
						RangoVlrCarg varchar(255) NULL,
						RentaRR varchar(255) NULL,
						DecosAdicionalesHdPvr varchar(255) NULL,
						AreaComercial varchar(255) NULL,
						ZonaComercial varchar(255) NULL,
						Empaquetamiento varchar(255) NULL,
						PaqueteActual varchar(255) NULL,
						Beneficio varchar(255) NULL,
						DescuentoOfertaComercial varchar(255) NULL,
						AbsDescuento varchar(255) NULL,
						ValorComercialConOferta varchar(255) NULL,
						ValorComercialConDesc varchar(255) NULL,
						VentaTecnologia varchar(255) NULL,
						EquipoActual varchar(255) NULL,
						OfertaMultiPlay varchar(255) NULL,
						CampoFijo4 varchar(255) NULL,
						CampoFijo5 varchar(255) NULL,
						DireccionesAlternas varchar(255) NULL,
						IdCampana varchar(255) NULL,
						Periodo varchar(255) NULL,
						Segmento varchar(255) NULL,
						AliadoAsignado varchar(255) NULL); 

BULK INSERT #aux_cargue
   FROM '\\10.80.40.35\BI Claro\Claro\2021\10. Octubre\Claro Bogot�\10. BulkInsert\Tmk_Base_Asignacion_Supervisor_Campania.csv' 
  WITH
	(	FIRSTROW = 2,
		FIELDTERMINATOR =';',
		ROWTERMINATOR ='\n',
	    KEEPNULLS );

INSERT INTO desarrollo.dbo.aux_clientes(Id, IdAsignacion, NombreCampana, Apellido, Area, Celular1, Celular2, Celular3, Ciudad, ClienteBlindado, CodigoTarifa1, CodigoTarifa2, CodigoTarifa3, Comunidad, Contrato, Corte, Cuenta, CuentaMatriz, CuentasAlternas, Direccion, Division, DivisionComercial, Docsis30, Email, Estrategia, Estrato, FechaNacimiento, FechaUltimaOt, FechaVinculacion, Mintic, Nodo, Nombre, NumDecosAdi, NumDecosAdicionalesTV, NumeroIdentificacion, Paquete, ProbabilidadVenta, Renta, RentaAdicionales, RentaBasico, RentaTotalIva, SegmentoCliente, ServicioInternet, ServicioTv, ServicioVoz, Tarifa, Telefono1, Telefono2, Telefono3, TelefonoTelmex, TipoAdulto, TipoClaroVideo, TipoFox, TipoHbo, TipoHd, TipoIdent, TipoOtros, TipoPaquetes, TipoRevista, TrabajoRevista, Zona, Incremento1, RentaIncremento1, TarifaMigrar1, NombrePaqueteAMigrar1, Incremento2, RentaIncremento2, TarifaMigrar2, NombrePaqueteAMigrar2, Incremento3, RentaIncremento3, TarifaMigrar3, NombrePaqueteAMigrar3, PreapobadosPorCartera, Oferta1, Oferta2, Oferta3, ValorOferta1, ValorOferta2, ValorOferta3, DiferenciaOferta1, DiferenciaOferta2, DiferenciaOferta3, CodigoPolitica1, CodigoPolitica2, CodigoPolitica3, TipoOferta1, TipoOferta2, TipoOferta3, PreaprobadoPorCartera, NumDecosHd, DecosHd, NumDecosEstandar, PaquetesAMigrar, IncrementoRenta, RentaIncremento, TarifaAMigrar, HaVistoPpvUltimos3Meses, CupoCalculado, CampoOpcional2, IdLista, CampoOpcional4, CampoOpcional5, TeleNum, Estado, NombreCliente, TipoCliente, Antiguedad, CalificacionCliente, TmcodeActual, TipoProducto, SegmentoPlan, TecnologiaPlan, DesTmcode, CfmPlan, SpCode, DesSpcode, TecnologiaPaquete, CfmPaq, Arpu, DetalleServicioAdicionales, ComportamientoPago, ConsumoDatosMes1, ConsumoDatosMes2, ConsumoDatosMes3, MouMes, TipoEquipo, Tickler, Desactiv, PlanPar, Ajustes, MinutosIncluidos, MegasIncluidas, ICCID, Custcode, RangoVlrCarg, RentaRR, DecosAdicionalesHdPvr, AreaComercial, ZonaComercial, Empaquetamiento, PaqueteActual, Beneficio, DescuentoOfertaComercial, AbsDescuento, ValorComercialConOferta, ValorComercialConDesc, VentaTecnologia, EquipoActual, OfertaMultiPlay, CampoFijo4, CampoFijo5, DireccionesAlternas, IdCampana, Periodo, Segmento, AliadoAsignado) 
SELECT 
	* 
FROM #aux_cargue;

DROP TABLE #aux_cargue;
SELECT * FROM desarrollo.dbo.aux_clientes;