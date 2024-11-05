setCharsPerLine 48;
newline;
##the 'bitmap' command loads an image file, sends the image data to printer and then prints the image data
newline;
##bitmap "#absPath("config/vouchers/templates/liverpool.png")" center;
bitmap "0" center;
newline;

setAlignment center;
beginBold;
text "$store.storeName";
endBold;

setAlignment left;
setFontSize normal;
newline;
text "#fmt("  %-8.8s  %-4.4s  %8.8s  %8.8s", ["TERM","DOCTO","TDA","VEND"])";
text "#fmt("  %-8.8s  %-5.5s  %8.8s  %8.8s", ["$ticket.terminalCode", "$ticket.docNumber", "$ticket.storeCode", "$ticket.userName"])";
 
newline;
  text "#fmt("      ATENDIO: %-s", "$ticket.userNameDescription")";
newline;


text "COMPUTADOR    $          #fmtDec($totals.totalComputador)";
text "ENTREGADO     $          #fmtDec($totals.entregado)";
text "DIFERENCIA    $          #fmtDec($totals.totalDiferencia)";
text "DEVOLUCION    $          #fmtDec($totals.devolucion)";
text "PUNTOS RIFA   $          0.00";
text "VALES PAPEL   $          #fmtDec($totals.valesPapel)";
newline;
text "*****     $ticket.trxVoucher     *****";
newline;
newline;                                      
text "*****TOTALES DE TERMINAL BORRADOS*****";
text "***********TERMINAL CERRADA***********";
newline;
newline;
	text "#formatFecha($date)   $time";
newline;
newline;
setAlignment center;
text "www.liverpool.com.mx";
text "Centro de atención telefónica CAT";
text "De la Cd. de México llame al 52-62-99-99";
text "Del interior sin costo al 01-800-713-5555";
newline;
newline;
newline;
newline;
cutPaperManual;