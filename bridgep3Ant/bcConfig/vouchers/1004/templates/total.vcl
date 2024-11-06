setCharsPerLine 38;

#set ($isDiscountsTrx = "false")
#set ($isFirstDayDiscounts = "false")

#if($ticket.transactionType == 2 || $ticket.additionalSubType == 123)
	#if($ticket.originalDate && $ticket.originalTerminal && $ticket.originalTicketNumber)
		 newline;
		 text "#fmt("%-20.20s  %-11.11s", ["FECHA DE VENTA : ","#formatFechaCrt($ticket.originalDate)"])";
		 text "#fmt("%-20.20s  %-10.10s", ["TERMINAL : ","$ticket.originalTerminal"])";
		 text "#fmt("%-20.20s  %-10.10s", ["BOLETA : ","$ticket.originalTicketNumber"])";
	#end
#end
	#if($ticket.originalStoreNamePrinter) 
	   newline;
	   text "#fmt( "TIENDA ORIGINAL  :%20s", $ticket.originalStoreNamePrinter )";
	#end
	#if($ticket.refundCauseJournal)
	   text "#fmt( "CAUSA DEVOLUCION :%20s", $ticket.refundCauseJournal )";
	#end
	#if($ticket.refundEmployee)
	   text "#fmt( "VENDEDOR ORIGINAL:            %8s", $ticket.refundEmployee )";
	#end
newline;

#if($ticket.additionalSubType == 122)
	newline;
	text "#fmt("***** TOTAL DEVUELTO $%12.12s", "#fmtDec($ticket.subtotal)" ) ";
#end

#if ($ticket.firstPurchaseDay || $ticket.discounts)
	
	#if($ticket.additionalSubType == 118 || $ticket.additionalSubType == 119 || $ticket.additionalSubType == 120 || $ticket.additionalSubType == 141 || $ticket.additionalSubType == 143 || $ticket.additionalSubType == 144)
		#set ($sign = "-1")
		text "#fmt("  ***** TOTAL M.N. $      %12s", "#fmtDec($ticket.total $sign)" ) ";
	#else
		text "#fmt("  ***** TOTAL M.N. $      %12s", "#fmtDec($ticket.total)" ) ";
	#end
	newline;
	text "#convertToText($ticket.total, 38)";
#else
	text "#fmt("  ***** TOTAL M.N. $      %12s", "#fmtDec($ticket.total)" ) ";
	newline;
	text "#convertToText($ticket.total, 38)";
#end

#if(!$ticket.trainingModeFlag)
 	
	#if($isDiscountsTrx == true)
		newline;
		##newline;
		text "#fmt("  ***** TOTAL M.N. $      %12s", "#fmtDec($ticket.totalWithTrxDiscounts)" ) ";
		newline;
		text "#convertToText($ticket.totalWithTrxDiscounts, 38)";
	#end

#end

newline;

#if($ticket.transactionDolar && $ticket.additionalSubType != 119)
	text "CORRESPONSAL CAMBIARIO DE BBVA";
	text "INSTITUCION DE BANCA MULTIPLE";
	text "COMPRA DE DOLARES US";
	newline;
#end

setCharsPerLine 200;
