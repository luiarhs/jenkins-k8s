#if( $ticket.transactionType == 2 ) 
   #if( $ticket.transaccionRegalo )
		#if($ticket.originalDate)
	   		text "#fmt("%-20.20s  %-10.10s", ["FECHA DE VENTA  :","$ticket.originalTrxDate"])"; 
		#end
		#if($ticket.originalTrxTerminal)
	   		text "#fmt("%-20.20s  %-10.10s", ["       TERMINAL  :","$ticket.originalTrxTerminal"])"; 
		#end	
		#if($ticket.originalTrxNumber)
	   		text "#fmt("%-20.20s  %-10.10s", ["         BOLETA  :","$ticket.originalTrxNumber"])"; 
		#end
		newline;
		newline;
	#end
	newline;
	#if($ticket.originalStoreName)
	   text "#fmt("%-20.20s  %-18.18s", ["TIENDA ORIGINAL    :","$ticket.originalStoreName"])"; 
	#end
	#if($ticket.refundCauseDescription)
	   text "#fmt("%-20.20s  %-18.18s", ["CAUSA DEVOLUCION   :","$ticket.refundCauseDescription"])"; 
	#end
	#if($ticket.refundEmployee)
	   text "#fmt("%-20.20s  %-18.18s", ["VENDEDOR ORIGINAL  :","             $ticket.refundEmployee"])"; 
	#end
#end
	

setFontSize high;
newline;
beginBold;
	text "#fmt("     *****     TOTAL  $%17.17s", "#fmtDec($ticket.total)" ) ";
endBold;
setFontSize normal;

newline;
newline;
