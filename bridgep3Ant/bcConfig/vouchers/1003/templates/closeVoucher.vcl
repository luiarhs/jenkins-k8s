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
	text "FECHA: #formatFecha($date)   $time";
newline;
    text "TERMINAL: $ticket.terminalCode";
newline;
    text "No. TICKETS: $totals.voucher";
newline;
setAlignment center;
text "FOLIOS:";
setAlignment left;
text "DEL:  1 AL $totals.voucher";
setAlignment center;
text "REVISO:";
setAlignment left;
text "NOMBRE:_________________________________";
newline;
newline;
text "FIMRA:__________________________________";
newline;
newline;
newline;
newline;
newline;
cutPaperManual;