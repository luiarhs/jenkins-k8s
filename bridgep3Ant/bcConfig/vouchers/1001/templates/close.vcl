#if($printerType == "2")
    setCharsPerLine 48;
#else
    setCharsPerLine 38;
#end
newline;
##the 'bitmap' command loads an image file, sends the image data to printer and then prints the image data
newline;
##bitmap "#absPath("config/vouchers/templates/liverpool.png")" center;
#if($printerType == "2")
    bitmap "0" center;
    lineSpacing 2;
    newline;
#else
    bitmapPreStored 1 center;
    newline;
#end

setAlignment center;
beginBold;
text "$store.storeName";
endBold;

setAlignment left;
setFontSize normal;
newline;
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

setAlignment center;
text "*****     $ticket.trxVoucher     *****";
setAlignment left;
newline;
beginBold;                                      
	text "*****TOTALES DE TERMINAL BORRADOS*****";
	text "***********TERMINAL CERRADA***********";
	text "TIENDA:  #formatFecha($date)   $time";
endBold;
newline;
setAlignment center;
beginBold;
     text "Ventas y Centro de Atencion";
     text "52 62 99 99 / 01 800 713 55 55";
endBold;
newline;
newline;
cutPaper 90;
setFontSize normal;