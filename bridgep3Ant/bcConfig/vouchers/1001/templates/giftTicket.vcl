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
   text "TICKET DE REGALO";
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
  beginBold;
	text "En caso de devolución se descontará";
	text "del importe a devolver, el monto boni-";
	text "ficado en monedero(s) electrónico(s)";
	text "al momento de la compra o el valor de";
	text "los incentivos otorgados al realizarla";
	#if ($ticket.firstPurchaseDay)
	   newline;
	   text "Transacción con primer día de compras.";
	#end
   endBold;
   newline;
    setAlignment center;
	text " CLIENTE     #formatFecha($date)     $time";
	setCharsPerLine 38;
	#if($printerType == "2")
        barcode CODE128 "$item.giftBarcode" 70 2 center below;
    #else
        barcode CODE128 "$item.giftBarcode" 50 2 center none;
    #end

cutPaper 90;
setFontSize normal;
