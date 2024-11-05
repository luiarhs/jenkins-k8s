newline;
setFontSize highWide;
beginBold;
setAlignment center;
text "$store.storeName";
endBold;
setFontSize normal;
text "$store.storeAddress";
#if($ticket.transactionType == 112 || $ticket.transactionType == 2)
    beginBold;
    setAlignment center;
    setFontSize highWide;
    text "$ticket.transactionTitle";
    endBold;
#end
setFontSize normal;
setAlignment left;
setFontSize normal;
#if( $ticket.warrantyReference )
   setAlignment center;
	newline;
	newline;
	text "PROGRAMA DE GARANTIA EXTENDIDA";	
    newline;
   setAlignment left;
#end    
newline;
text "#fmt("  %-8.8s  %-4.4s  %8.8s  %8.8s", ["TERM","DOCTO","TDA","VEND"])";
text "#fmt("  %-8.8s  %-5.5s  %8.8s  %8.8s", ["$ticket.terminalCode", "$ticket.docNumber", "$ticket.storeCode", "$ticket.userName"])";		 
newline;
  text "#fmt("      ATENDIO: %-s", "$ticket.userNameDescription")";
newline;
#if( $ticket.warrantyReference )
	beginBold;
		text "#fmt("REFERENCIA: %-s", "$ticket.warrantyReference")";
	endBold;
#end