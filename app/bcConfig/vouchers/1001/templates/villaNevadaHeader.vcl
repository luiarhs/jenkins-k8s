#if($printerType == "2")
    setCharsPerLine 48;
#else
    setCharsPerLine 38;
#end
newline;
newline;
newline;
bitmap "#absPath("config/vouchers/templates/liverpool.png")" center;
#if($printerType == "2")
    bitmap "0" center;
    lineSpacing 2;
    newline;
#else
    bitmapPreStored 1 center;
#end
newline;

setAlignment center;
beginBold;
setFontSize wideB;
text "$store.storeName";
endBold;
newline;
setFontSize normal;
text "$store.storeAddress";
 #if($store.storeAddress2)
   	text "$store.storeAddress2";
   #end   	
   #if($store.storeAddress3)
   	text "$store.storeAddress3";
   #end

newline;
setAlignment center;
setFontSize wideB;
text "MUNDO DE BOLO";

newline;
setFontSize normal;
setAlignment left;
text "TERM      DOCTO     TDA        VEND   ";
text "#fmt("%03.03s %10.10s %9.6s %13.10s" , ["$ticket.terminalCode", "$ticket.docNumber", "$ticket.storeCode", "$ticket.userName" ])";

newline;
setAlignment center;
text "ATENDIO:  $ticket.userNameDescription";


