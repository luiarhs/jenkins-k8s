#if($printerType == "2")
    setCharsPerLine 48;
#else
    setCharsPerLine 38;
#end
newline;
text "RESUMEN DE CONTEO DE RETIRO";
newline;

text "#fmt("%17s  %s  %10s", ["TIPO DE PAGO", "CNT", "MONTO"])";
newline;
#foreach( $payment in $ticket.paymentsTenderControl )
	#if($payment.tenderGsaId == 15 )
		text "#fmt("%13s  %s %4s  %12s", ["CONTADO", "$", "$payment.qtyTenderGsa", "#fmtDec($payment.totalTenderGsa)"])";
		newline;
	#end
#end

##Cheque
#foreach( $payment in $ticket.paymentsTenderControl )
	#if($payment.tenderGsaId == 0 )
		text "#fmt("%13s  %s %4s  %12s", ["CHEQUE", "$", "$payment.qtyTenderGsa", "#fmtDec($payment.totalTenderGsa)"])";
		newline;
	#end
#end
##Cupones
#foreach( $payment in $ticket.paymentsTenderControl )
	#if($payment.tenderGsaId == 1 )
		text "#fmt("%13s  %s %4s  %12s", ["CUPONES", "$", "$payment.qtyTenderGsa", "#fmtDec($payment.totalTenderGsa)"])";
		newline;
	#end
#end
##Monedero
#foreach( $payment in $ticket.paymentsTenderControl )
	#if($payment.tenderGsaId == 2 )
		text "#fmt("%13s  %s %4s  %12s", ["VALE/MONEDERO", "$", "$payment.qtyTenderGsa", "#fmtDec($payment.totalTenderGsa)"])";
		newline;
	#end
#end
##Dolares
#foreach( $payment in $ticket.paymentsTenderControl )
	#if($payment.tenderGsaId == 30 )
		#######text "#fmt("%13s  %s %4s  %12s", ["US 30", "$", "$payment.qtyTenderGsa", "#fmtDec($payment.totalTenderGsa)"])";
		text "#fmt("%13s  %s %4s  %12s", ["DóLARES", "$", "$payment.qtyTenderGsa", "#fmtDec($payment.totalTenderGsa)"])";
		 setAlignment center;
		text "(#fmtDec($payment.totalForeignAmount) * $payment.foreignCurrencyQuote)";
		newline;
	#end
#end
##Quetzales
#foreach( $payment in $ticket.paymentsTenderControl )
	#if($payment.tenderGsaId == 31 )
		######text "#fmt("%13s  %s %4s  %12s", ["QT 31", "$", "$payment.qtyTenderGsa", "#fmtDec($payment.totalTenderGsa)"])";
		text "#fmt("%13s  %s %4s  %12s", ["QUETZALES", "$", "$payment.qtyTenderGsa", "#fmtDec($payment.totalTenderGsa)"])";
		setAlignment center;
		text "(#fmtDec($payment.totalForeignAmount) * $payment.foreignCurrencyQuote)";
		newline;
	#end
#end
##Euros
#foreach( $payment in $ticket.paymentsTenderControl )
	#if($payment.tenderGsaId == 27 )
		######text "#fmt("%13s  %s %4s  %12s", ["EU 27", "$", "$payment.qtyTenderGsa", "#fmtDec($payment.totalTenderGsa)"])";
		text "#fmt("%13s  %s %4s  %12s", ["EUROS", "$", "$payment.qtyTenderGsa", "#fmtDec($payment.totalTenderGsa)"])";
		setAlignment center;
		text "(#fmtDec($payment.totalForeignAmount) * $payment.foreignCurrencyQuote)";
		newline;
	#end
#end
##Dolar Belicenio
#foreach( $payment in $ticket.paymentsTenderControl )
	#if($payment.tenderGsaId == 26 )
		#####text "#fmt("%13s  %s %4s  %12s", ["DB", "$", "$payment.qtyTenderGsa", "#fmtDec($payment.totalTenderGsa)"])";
		text "#fmt("%13s  %s %4s  %12s", ["DóLAR BELICENIO", "$", "$payment.qtyTenderGsa", "#fmtDec($payment.totalTenderGsa)"])";
		setAlignment center;
		text "(#fmtDec($payment.totalForeignAmount) * $payment.foreignCurrencyQuote)";
		newline;
	#end
#end
##Dolar Canadiense
#foreach( $payment in $ticket.paymentsTenderControl )
	#if($payment.tenderGsaId == 28 )
		#####3text "#fmt("%13s  %s %4s  %12s", ["DC", "$", "$payment.qtyTenderGsa", "#fmtDec($payment.totalTenderGsa)"])";
		text "#fmt("%13s  %s %4s  %12s", ["DóLAR CANADIENSE", "$", "$payment.qtyTenderGsa", "#fmtDec($payment.totalTenderGsa)"])";
		 setAlignment center;
		text "(#fmtDec($payment.totalForeignAmount) * $payment.foreignCurrencyQuote)";
		newline;
	#end
#end
text "#fmt("%24s  %s%9s", ["CONTEO TOTAL DE RETIRO:","$","#fmtDec($ticket.paymentsTotal)"])";
newline;
text "#fmt("%23.23s  %1.1s%10.10s", ["TOTAL RETIRADO ACTUAL:", "$", "#fmtDec($totals.entregado)"])";
newline;