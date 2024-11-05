 setCharsPerLine 48;
 newline;
 ##the 'bitmap' command loads an image file, sends the image data to printer and then prints the image data
 newline;
 ##bitmap "#absPath("config/vouchers/templates/liverpool.png")" center;
 bitmap "0" center;
 newline;
  beginBold;
   setFontSize highWide;
   text "TICKET REGALO";
  endBold;
  newline;
  setFontSize normal;
  
text "#fmt("  %-8.8s  %-4.4s  %8.8s  %8.8s", ["TERM","DOCTO","TDA","VEND"])";
text "#fmt("  %-8.8s  %-5.5s  %8.8s  %8.8s", ["$ticket.terminalCode", "$ticket.docNumber", "$ticket.storeCode", "$ticket.userName"])";

  newline;
  text "#fmt("%-20.20s  %-5.5s  %-5.5s   %-5.5s", ["$item.description", "SECC", "$item.merchandiseHierarchy","$item.priceInputTypeIndicator"] )";
setAlignment left;
text "$item.code";

  newline;
  beginBold;
	text "En caso de devolución se descontará";
	text "del importe a devolver, el monto boni-";
	text "ficado en monedero(s) electrónico(s)";
	text "al momento de la compra o el valor de";
	text "los incentivos otorgados al realizarla";
   endBold;
   newline;
	text "CLIENTE   #formatFecha($date)   $time";
	
	newline;
    barcode CODE128 "$item.giftBarcode" 70 2 center below;
    newline;
	newline;
	newline;
	newline;
	newline;

cutPaperManual;
