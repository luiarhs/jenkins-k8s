newline;
newline;
setCharsPerLine 48;
setFontSize highWide;
beginBold;
setAlignment center;
text "ESTADO DE TERMINAL";
endBold;

setFontSize normal;
newline;
beginBold;
text "#fmt("%10.10s  %8.8s  %8.8s", ["APLICATION","VERSION","FECHA"])";
endBold;
text "#fmt("%10.10s  %8.8s  %8.8s", ["$terminalReportData.aplicationName","$terminalReportData.aplicationVersion","$terminalReportData.aplicationDate"])";
text "#fmt("%9.9s  %-4.4s  %12.12s  %-4.4s", ["TERMINAL: ","$terminalReportData.terminalCode","CONTROLADOR: ","$terminalReportData.controladorId"])";
newline;
setAlignment left;
text "#fmt("%3.3s  %-2.2s  %26.26s", ["** ","$terminalReportData.lineAutorization"," LINEAS DE AUTORIZACION **"])";
text "#fmt("%8.8s  %10.10s  %5.5s  %4.4s  %1.1s", ["* -> IP:","$terminalReportData.serverIp","PORT:","$terminalReportData.serverPort","*"])";
text "#fmt("%8.8s  %10.10s  %5.5s  %4.4s  %1.1s", ["* -> IP:","$terminalReportData.alternativeServerIp","PORT:","$terminalReportData.alternativeServerPort","*"])";

#if( $terminalReportData.aplicaTarjetaIntel)
	text "*** APLICA TARJETA INTELIGENTE ***";
#end

#if( $terminalReportData.bascula)
	text "*** HAY BASCULA DISPONIBLE ***";
#else
	text "*** NO HAY BASCULA DISPONIBLE ***";
#end

#if( $terminalReportData.permiteTeclearTajeta)
	text "*** PERMITE TECLEAR TARJETA ***";
#else
	text "*** NO PERMITE TECLEAR TARJETA ***";
#end

newline;
setAlignment center;
beginBold;
text " *****  IMPUESTOS *****";
endBold;
text "#fmt("%-5.5s  %-5.5s  %12.12s  %8.8s", ["TIPO","CAT.","DESCRIPCION","PORC."])";
#foreach($taxLiverpoolDTO in $$terminalReportData.taxLiverpool)
  text "#fmt("%-5.5s  %-5.5s  %-12.12s  %8.8s", ["$taxLiverpoolDTO.tipoTax","$taxLiverpoolDTO.categoriaTax","$taxLiverpoolDTO.descripcionTax","$taxLiverpoolDTO.porcenajeTax"])";
#end

newline;
beginBold;
text "CAJONES UTILIZADOS:";
endBold;
#if( $terminalReportData.cajon1)
	text "#fmt("%8.8s  %8.8s  %14.14s", ["CAJON 1","      ","*HABILITADO*"])";
#end
#if( $terminalReportData.cajon2)
	text "#fmt("%8.8s  %8.8s  %14.14s", ["CAJON 2","      ","*HABILITADO*"])";
#end

newline;
beginBold;
text "PROMO";
endBold;
#if( $terminalReportData.motorPromo)
	text "#fmt("%-11.11s  %-4.4s  %6.6s  %-5.5s  %2.2s ", ["** MOTOR: V","$terminalReportData.motorPromo"," MAPA:","$terminalReportData.motorPromoMapa", "**"])";
#end


newline;
#if( $terminalReportData.levelBateryCurrentIpad)
	text "#fmt("%-28.28s %6.6s", ["NIVEL DE BATERIA IPAD:","$terminalReportData.levelBateryCurrentIpad"])";
#end

#if( $terminalReportData.levelBateryCurrentPinPad)
	text "#fmt("%-28.28s %6.6s", ["NIVEL DE BATERIA PINPAD:","$terminalReportData.levelBateryCurrentPinPad"])";
#end

#if( $terminalReportData.versionOperatingSystem)
	text "#fmt("%-26.26s %8.8s", ["VERSION SISTEMA OPERATIVO:","$terminalReportData.versionOperatingSystem"])";
#end

#if( $terminalReportData.versionFirmWarePinPad)
	text "#fmt("%-24.24s %10.10s", ["VERSION FIRMWARE PINPAD:","$terminalReportData.versionFirmWarePinPad"])";
#end

#if( $terminalReportData.printerCurrentUsedIpad)
	text "#fmt("%-23.23s %10.10s", ["IMPRESORA CONFIGURADA:","$terminalReportData.printerCurrentUsedIpad"])";
#end

newline;

#if( $terminalReportData.freeMemory)
	text "#fmt("%-19.19s  %13.13s", ["MB LIBRES:","$terminalReportData.freeMemory"])";
#end

#if( $terminalReportData.allocateMemory)
	text "#fmt("%-28.28s %6.6s", ["TOTAL DE MEMORIA USADA:","$terminalReportData.allocateMemory"])";
#end

#if( $terminalReportData.assignedMemory)
	text "#fmt("%-28.28s %6.6s", ["TOTAL DE MEMORIA ASIGNADA:","$terminalReportData.assignedMemory"])";
#end

#if( $terminalReportData.maxAvailableMemoryJVM)
	text "#fmt("%-28.28s %6.6s", ["MEMORIA MAX DISPONIBLE JVM:","$terminalReportData.maxAvailableMemoryJVM"])";
#end


setAlignment right;
newline;
newline;
  text "#formatFecha($date)   $time";
newline;
newline;
newline;
newline;