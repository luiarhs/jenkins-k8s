setCharsPerLine 38;
setFontSize highWide;
beginBold;
setAlignment center;
text "ESTADO DE TERMINAL";
endBold;

setFontSize normal;
newline;
beginBold;
text "APLICACION       VERSION         FECHA";
endBold;
text "#fmt("%8s     %12s %11s", ["$terminalReportData.aplicationName","$terminalReportData.aplicationVersion","$terminalReportData.aplicationDate"])";
text "#fmt("   TERMINAL:%-4s     CONTROLADOR:%-4s", ["$terminalReportData.terminalCode","$terminalReportData.controladorId"])";
newline;
setAlignment left;
text "#fmt("****** %-1s LINEAS DE AUTORIZACION ******", ["$terminalReportData.lineAutorization"])";
text "#fmt("*** --> IP:%10s PORT:%4s ***", ["$terminalReportData.serverIp","$terminalReportData.serverPort"])";
text "#fmt("*** --> IP:%10s PORT:%4s ***", ["$terminalReportData.alternativeServerIp","$terminalReportData.alternativeServerPort"])";

#if( $terminalReportData.aplicaTarjetaIntel)
	text "***** APLICA TARJETA INTELIGENTE *****";
#end

#if( $terminalReportData.bascula)
	text "*****  HAY BASCULA DISPONIBLE    *****";
#else
	text "***** NO HAY BASCULA DISPONIBLE  *****";
#end

#if( $terminalReportData.permiteTeclearTajeta)
	text "***** PERMITE TECLEAR TARJETA    *****";
#else
	text "***** NO PERMITE TECLEAR TARJETA *****";
#end

newline;
setAlignment center;
beginBold;
text "**********    IMPUESTOS     **********";
endBold;

text "TIPO  CAT.     DESCRIPCION       PORC.";
#foreach($taxLiverpoolDTO in $$terminalReportData.taxLiverpool)
  text "#fmt("%-5s  %-5s  %-15s %8s", ["$taxLiverpoolDTO.tipoTax","$taxLiverpoolDTO.categoriaTax","$taxLiverpoolDTO.descripcionTax","$taxLiverpoolDTO.porcenajeTax"])";
#end

newline;
beginBold;
text "CAJONES UTILIZADOS:";
endBold;
#if( $terminalReportData.cajon1)
	text "CAJON 1                 *HABILITADO*";
#else
	text "CAJON 1              *DESHABILITADO*";
#end
#if( $terminalReportData.cajon2)
	text "CAJON 2                 *HABILITADO*";
#else
	text "CAJON 2              *DESHABILITADO*";
#end

newline;
beginBold;
text "PROMO";
endBold;
#if( $terminalReportData.motorPromo)
	text "#fmt("%-11s  %-4s  %6s  %-5s  %2s ", ["** MOTOR: V","$terminalReportData.motorPromo"," MAPA:","$terminalReportData.motorPromoMapa", "**"])";
#end


newline;
#if( $terminalReportData.levelBateryCurrentIpad)
	text "#fmt("%-28s %6s", ["NIVEL DE BATERIA IPAD:","$terminalReportData.levelBateryCurrentIpad"])";
#end

#if( $terminalReportData.levelBateryCurrentPinPad)
	text "#fmt("%-28s %6s", ["NIVEL DE BATERIA PINPAD:","$terminalReportData.levelBateryCurrentPinPad"])";
#end

#if( $terminalReportData.versionOperatingSystem)
	text "#fmt("%-26s %8s", ["VERSION SISTEMA OPERATIVO:","$terminalReportData.versionOperatingSystem"])";
#end

#if( $terminalReportData.versionFirmWarePinPad)
	text "#fmt("%-24s %10s", ["VERSION FIRMWARE PINPAD:","$terminalReportData.versionFirmWarePinPad"])";
#end

#if( $terminalReportData.printerCurrentUsedIpad)
	text "#fmt("%-23s %10s", ["IMPRESORA CONFIGURADA:","$terminalReportData.printerCurrentUsedIpad"])";
#end

setAlignment left;
newline;

#if( $terminalReportData.freeMemory)
	text "#fmt("%-19s  %13s", ["MB LIBRES:","$terminalReportData.freeMemory"])";
#end

#if( $terminalReportData.allocateMemory)
	text "#fmt("TOTAL DE MEMORIA USADA:      %6s MB", ["$terminalReportData.allocateMemory"])";
#end

#if( $terminalReportData.assignedMemory)
	text "#fmt("TOTAL DE MEMORIA ASIGNADA:   %6s MB", ["$terminalReportData.assignedMemory"])";
#end

#if( $terminalReportData.maxAvailableMemoryJVM)
	text "#fmt("MEMORIA MAX DISPONIBLE JVM:  %6s MB", ["$terminalReportData.maxAvailableMemoryJVM"])";
#end
setAlignment right;
newline;
  text "#formatFecha($date)   $time";
newline;
cutPaper 90;
setFontSize normal;