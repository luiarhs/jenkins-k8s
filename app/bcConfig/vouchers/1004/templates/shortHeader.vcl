setCharsPerLine 200;
newline;
text "--------------------------------------";
newline;
text "#center($store.storeName)";
text "#center($store.storeAddress)";

#if( $ticket.warrantyReference )
	text "PROGRAMA DE GARANTIA EXTENDIDA";	
	newline;
#end

newline;
#if($ticket.transactionType == 112)
    text "#center($ticket.transactionTitle)";
    newline;
#end

text "#fmt("%-8.8s  %-6.6s  %6.6s  %8.8s", ["TERM","DOCTO","TDA","VEND"])";
text "#fmt("%-8.8s  %-6.6s  %7.7s  %10.10s", ["$ticket.terminalCode", "$ticket.docNumber", "$ticket.storeCode", "$ticket.userName"])";
newline;

text "#fmt("      ATENDIO: %-s", "$ticket.userNameDescription")";
newline;

#if ($ticket.numeroOrdenVenta)
   text "#fmt("NUMERO DE ORDEN  :%20s", $ticket.numeroOrdenVenta)";
   newline;
#end

#if( $ticket.warrantyReference )
	text "REFERENCIA: $ticket.warrantyReference";
	newline;
	newline;
#end
