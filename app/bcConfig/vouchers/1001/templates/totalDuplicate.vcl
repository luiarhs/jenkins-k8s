#if( $ticket.transactionType == 2 ) 
   newline;
    #if($ticket.originalDate && $ticket.originalTerminal && $ticket.originalTicketNumber)

		 text "#fmt("FECHA   DE VENTA :%20s", "#formatFechaCrt($ticket.originalDate)")"; 
		 text "#fmt("        TERMINAL :%20s", "$ticket.originalTerminal")"; 
		 text "#fmt("          BOLETA :%20s", "$ticket.originalTicketNumber")"; 
    #end
	#if($ticket.originalStoreName)
	   text "#fmt("TIENDA ORIGINAL  :%20s","$ticket.originalStoreName")"; 
	#end
	#if($ticket.refundCauseJournal)
	   text "#fmt("CAUSA DEVOLUCION :%20s", "$ticket.refundCauseJournal")"; 
	#end
	#if($ticket.refundEmployee)
	   text "#fmt( "VENDEDOR ORIGINAL:            %8s", "$ticket.refundEmployee")"; 
	#end
#end
	

newline;
text "#fmt("  *****    TOTAL M.N. $%15s", "#fmtDec($ticket.total)") ";
setFontSize normal;
setAlignment center;
#if($ticket.transactionType != 2)
   text "#convertToText($ticket.total,38)";
#end
newline;