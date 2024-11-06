 ##imprime el logo de tienda
#if($printerType == "2")
    bitmap "0" center;
    lineSpacing 2;
    newline;
#else
    bitmapPreStored 1 center;
#end

newline;
setAlignment center;
setCharsPerLine 48;
beginBold;
setFontSize wide;
text "Devolución";
text "NO APTA PARA VENTA";
endBold;
newline;

#if($printerType != "2")
    setCharsPerLine 38;
#end

setFontSize normal;
setAlignment left;

text "#fmt("%4s      %5s    %-4s     %4s", ["TERM","DOCTO","TDA","VEND"])";
text "#fmt("%03s       %4s     %4s    %8s", ["$ticket.terminalCode", "$ticket.docNumber", "$ticket.storeCode", "$ticket.userName"])";
newline;
text "#fmt("%-18s   %-4s %3s  %s%1s", ["$item.description", "SECC", "$item.merchandiseHierarchy","$item.priceInputTypeIndicator","$isLetter"] )";
text "#fmt("%010s", ["$item.code"])";
newline;

setAlignment center;

			text "ENTREGAR ESTA MERCANCIA AL AREA DE";
			text "ENVIOS PARA SU TRATAMIENTO INMEDIATO";

newline;

text "TIENDA     #formatFecha($date) $time";

cutPaper 90;
setFontSize normal;
