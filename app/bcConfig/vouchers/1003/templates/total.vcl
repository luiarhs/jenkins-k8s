#set ($isDiscountsTrx = "false")
#set ($isFirstDayDiscounts = "false")

#if($ticket.transactionType == 2 || $ticket.additionalSubType == 123)
	#if($ticket.originalDate && $ticket.originalTerminal && $ticket.originalTicketNumber)
		 newline;
		 text "#fmt("%-20.20s  %-11.11s", ["FECHA DE VENTA : ","#formatFechaCrt($ticket.originalDate)"])"; 
		 text "#fmt("%-20.20s  %-10.10s", ["TERMINAL : ","$ticket.originalTerminal"])"; 
		 text "#fmt("%-20.20s  %-10.10s", ["BOLETA : ","$ticket.originalTicketNumber"])"; 
	#end
	
	#if($ticket.originalStoreName)
		newline;
	   	text "#fmt("%-20.20s  %-18.18s", ["TIENDA ORIGINAL   :","$ticket.originalStoreName"])"; 
	#end
	#if($ticket.refundCauseDescription)
	   	text "#fmt("%-20.20s  %-18.18s", ["CAUSA DEVOLUCION  :","$ticket.refundCauseDescription"])"; 
	#end
	#if($ticket.refundEmployee)
	   	text "#fmt("%-20.20s  %-18.18s", ["VENDEDOR ORIGINAL :","$ticket.refundEmployee"])"; 
	#end
#end

newline;

#if($ticket.additionalSubType == 122)
	newline;
	setFontSize high;
	beginBold;
		text "#fmt("***** TOTAL DEVUELTO $%12.12s", "#fmtDec($ticket.subtotal)" ) ";
	endBold;
	setFontSize normal;
#end

#if(($ticket.firstPurchaseDay || $ticket.discounts) && !($ticket.ticketVoidFlag) )
	setFontSize high;
	beginBold;
		text "#fmt("  *****    TOTAL  $      %12.12s", "#fmtDec($ticket.total)" ) ";
		newline;
		newline;
	endBold;
	setFontSize normal;
	text "#convertToText($ticket.total,38)";
	
#else
	#if(!($ticket.firstPurchaseDay) && !($ticket.discounts))
		setFontSize high;
		beginBold;
			text "#fmt("   *****   TOTAL  $%12.12s", "#fmtDec($ticket.total)" ) ";
		endBold;
		setFontSize normal;
		newline;
		newline;
		text "#convertToText($ticket.total,38)";
	#end
#end

#foreach( $discountData in $ticket.discounts )
	#if($discountData.reasonCode != "firstDayPayment")
		#set ($isDiscountsTrx = "true")
		newline;
		newline;
		#if($discountData.type == 1)
			#if($discountData.discount.isPositive() && !($ticket.ticketVoidFlag) )
				text "#fmt("%15.15s %1.1s %1.5s %9.9s-", ["REBAJA TOTAL", "$", "#fmtDec($discountData.discount)","#fmtDec($discountData.discount)"])";
			#end	
		#end
	   	#if($discountData.type == 2)
	   		#if($discountData.percent.isPositive() && !($ticket.ticketVoidFlag) )
	   			text "#fmt("%15.15s %1.1s %1.5s %11.5s-", ["DESCUENTO TOTAL", "%", "#fmtDec($discountData.percent)","#fmtDec($discountData.discount)"])";	
	   		#end	
	   	#end
	#end
#end

#if($isDiscountsTrx == true)
	newline;
	newline;
	setFontSize high;
	beginBold;
		text "#fmt("   *****   TOTAL  $%12.12s", "#fmtDec($ticket.totalWithTrxDiscounts)" ) ";
	endBold;
	setFontSize normal;
	newline;
	newline;
	text "#convertToText($ticket.totalWithTrxDiscounts,38)";
#end

#foreach( $discountData in $ticket.discounts )
	#if($discountData.reasonCode == "firstDayPayment")
		#set ($isFirstDayDiscounts = "true")
		newline;
		newline;
		#if($discountData.type == 1)
			#if($discountData.discount.isPositive() && !($ticket.ticketVoidFlag) )
				newline;
				text "******* 1ER DIA DE COMPRAS *******";
				text "#fmt("%10.10s %1.1s %1.5s %9.9s-", ["DESCUENTO", "%", "#fmtDec($discountData.percent)","#fmtDec($discountData.discount)"])";
			#end	
		#end
	#end
#end
#if($isFirstDayDiscounts == true)
	newline;
	newline;
	setFontSize high;
	beginBold;
		text "#fmt("   *****   TOTAL NETO  $%12.12s", "#fmtDec($ticket.total)" ) ";
	endBold;
	setFontSize normal;
	newline;
	newline;
	text "#convertToText($ticket.total,38)";
#end
#if($ticket.transactionDolar)
	setAlignment center;
	beginBold;
	   text "CORRESPONSAL CAMBIARIO DE BBVA BANCOMER";
	   text "INSTITUCION DE BANCA MULTIPLE";
	   text "COMPRA DE DOLARES US";
	endBold;
	newline;
#end