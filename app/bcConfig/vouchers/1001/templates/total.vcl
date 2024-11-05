#if($printerType == "2")
    setCharsPerLine 48;
#else
    setCharsPerLine 38;
#end

#set ($isDiscountsTrx = "false")
#set ($isFirstDayDiscounts = "false")

#if($ticket.additionalSubType == 154 && $ticket.ivaServicios != 0)
	beginBold;
	text "#fmt("Iva 	$  %25s","$ticket.ivaServicios")";
	endBold;
#end

newline;
#if($ticket.transactionType == 2 || $ticket.additionalSubType == 123)
	#if($ticket.originalDate && $ticket.originalTerminal && $ticket.originalTicketNumber)
		 text "#fmt("FECHA   DE VENTA :%20s", "#formatFechaCrt($ticket.originalDate)")"; 
		 text "#fmt("        TERMINAL :%20s", "$ticket.originalTerminal")"; 
		 text "#fmt("          BOLETA :%20s", "$ticket.originalTicketNumber")"; 
	#end
	#if($ticket.originalStoreName )
	   text "#fmt( "TIENDA ORIGINAL  :%20s", $ticket.originalStoreName )";
	#end
	#if($ticket.refundCauseJournal )
	   text "#fmt( "CAUSA DEVOLUCION :%20s", $ticket.refundCauseJournal )";
	#end
	#if($ticket.refundEmployee)	   
	   text "#fmt( "VENDEDOR ORIGINAL:            %8s", $ticket.refundEmployee )";
	#end
	newline;
#end


#if($ticket.additionalSubType == 122)
	newline;
	setFontSize high;
	beginBold;
		text "#fmt("***** TOTAL DEVUELTO $%12.12s", "#fmtDec($ticket.subtotal)" ) ";
	endBold;
	setFontSize normal;
#end

#if ($ticket.firstPurchaseDay || $ticket.discounts)
	setFontSize high;
	beginBold;
	
	#if($ticket.additionalSubType == 118 || $ticket.additionalSubType == 119 || $ticket.additionalSubType == 120 || $ticket.additionalSubType == 141 || $ticket.additionalSubType == 143 || $ticket.additionalSubType == 144 || ($ticket.additionalSubType == 136 && $ticket_is_duplicate == false))
		#set ($sign = "-1")
		text "#fmt("*****   TOTAL M.N. $     %12s", "#fmtDec($ticket.total $sign)" ) ";
	#else
		text "#fmt("*****   TOTAL M.N. $     %12s", "#fmtDec($ticket.total)" ) ";
	#end
	newline;
	
	endBold;
	setFontSize normal;                
   setAlignment center;
	text "#convertToText($ticket.total,38)";
#else
		setFontSize high;
		beginBold;
	   text "#fmt("*****   TOTAL M.N. $     %12s", "#fmtDec($ticket.total)" ) ";
		endBold;
		setFontSize normal;
   		newline;
   		
   		setAlignment center;
   		text "#convertToText($ticket.total,38)";
#end

#if(!$ticket.trainingModeFlag)
		
		
		#if($isDiscountsTrx == true)
			newline;
			setFontSize high;
			beginBold;
				text "#fmt("*****   TOTAL M.N. $     %12s", "#fmtDec($ticket.totalWithTrxDiscounts)" ) ";
			endBold;
			setFontSize normal;
			newline;
			
			setAlignment center;
			text "#convertToText($ticket.totalWithTrxDiscounts,38)";
		#end
			
				
#end
newline;
#if($ticket.transactionDolar && $ticket.additionalSubType != 119 && $ticket.additionalSubType != 120)
	setCharsPerLine 44;
	setAlignment center;
	beginBold;
	   text "CORRESPONSAL CAMBIARIO DE BBVA";
	   text "INSTITUCION DE BANCA MULTIPLE";
	   text "COMPRA DE DOLARES US";
	endBold;
	newline;
#end


#if($printerType == "2")
    setCharsPerLine 48;
#else
    setCharsPerLine 38;
#end
