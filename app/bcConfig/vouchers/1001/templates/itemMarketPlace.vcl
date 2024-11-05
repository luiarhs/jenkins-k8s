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
text "Devolución Marketplace";
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
		  text "#fmt("No. PEDIDO: %-s", "$ticket.mrkPlaceNumeroPedido")";
  	endBold;
		newline;

setAlignment center;

			text "** VENDIDO POR $ticket.marketPlaceData.sellerVendorName **";
			text "PROVEEDOR DE LIVERPOOL";

newline;

#set ($mrkPlaceBarcode = "$ticket.mrkPlaceNumeroPedido$item.code");
barcode Code93 "$mrkPlaceBarcode" 50 2 center none;

cutPaper 90;
setFontSize normal;
