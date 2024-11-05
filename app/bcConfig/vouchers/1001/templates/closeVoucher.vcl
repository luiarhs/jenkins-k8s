#if($printerType == "2")
    setCharsPerLine 48;
#else
    setCharsPerLine 38;
#end
newline;
newline;
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
setFontSize high;
newline;
	  text "FECHA: #formatFecha($date)   $time";
newline;
    text "TERMINAL: $ticket.terminalCode";
newline;
    text "No. TICKETS: $totals.voucher";
newline;
 newline;
setAlignment center;
beginBold;
   text "FOLIOS:";
   newline;
endBold;
setAlignment left;
  text "DEL:  1 AL $totals.voucher";
newline;
newline;
newline;
setAlignment center;
beginBold;
  text "REVISO:";
  newline;
endBold;
setAlignment left;
text "NOMBRE:_______________________";
newline;
 newline;
text "FIRMA:________________________";
newline;
newline;
cutPaper 90;
setFontSize normal;