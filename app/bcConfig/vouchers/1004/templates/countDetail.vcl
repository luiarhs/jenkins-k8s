newline;
text "RESUMEN DE CONTEO DE RETIRO";
newline;
newline;
text "#fmt("%15.15s %5.5s  %10.10s", ["TIPO DE PAGO", "CNT", "MONTO"])";
newline;
#foreach( $payment in $ticket.paymentsTenderControl )
	#if($payment.tenderGsaId == 15 )
		text "#fmt("  %-17.17s  %-4.4s  %12.12s", ["CONTADO       $", "$payment.qtyTenderGsa", "#fmtDec($payment.totalTenderGsa)"])";
		newline;
	#end
#end
##Cheque
#foreach( $payment in $ticket.paymentsTenderControl )
	#if($payment.tenderGsaId == 0 )
		text "#fmt("  %-17.17s  %-4.4s  %12.12s", ["CHEQUE        $", "$payment.qtyTenderGsa", "#fmtDec($payment.totalTenderGsa)"])";
		newline;
	#end
#end
##Cupones
#foreach( $payment in $ticket.paymentsTenderControl )
	#if($payment.tenderGsaId == 1 )
		text "#fmt("  %-17.17s  %-4.4s  %12.12s", ["CUPONES       $", "$payment.qtyTenderGsa", "#fmtDec($payment.totalTenderGsa)"])";
		newline;
	#end
#end
##Monedero
#foreach( $payment in $ticket.paymentsTenderControl )
	#if($payment.tenderGsaId == 2 )
		text "#fmt("  %-17.17s  %-4.4s  %12.12s", ["VALE/MONEDERO $", "$payment.qtyTenderGsa", "#fmtDec($payment.totalTenderGsa)"])";
		newline;
	#end
#end
##Dolares
#foreach( $payment in $ticket.paymentsTenderControl )
	#if($payment.tenderGsaId == 30 )
		text "#fmt("  %-17.17s  %-4.4s  %12.12s", ["DÓLARES       $", "$payment.qtyTenderGsa", "#fmtDec($payment.totalTenderGsa)"])";
		text "(#fmtDec($payment.totalForeignAmount) * $payment.foreignCurrencyQuote)";
		newline;
	#end
#end
##Quetzales
#foreach( $payment in $ticket.paymentsTenderControl )
	#if($payment.tenderGsaId == 31 )
		text "#fmt("  %-17.17s  %-4.4s  %12.12s", ["QUETZALES     $", "$payment.qtyTenderGsa", "#fmtDec($payment.totalTenderGsa)"])";
		text "(#fmtDec($payment.totalForeignAmount) * $payment.foreignCurrencyQuote)";
		newline;
	#end
#end
##Euros
#foreach( $payment in $ticket.paymentsTenderControl )
	#if($payment.tenderGsaId == 27 )
		text "#fmt("  %-17.17s  %-4.4s  %12.12s", ["EUROS         $", "$payment.qtyTenderGsa", "#fmtDec($payment.totalTenderGsa)"])";
		text "(#fmtDec($payment.totalForeignAmount) * $payment.foreignCurrencyQuote)";
		newline;
	#end
#end
##Dolar Belicenio
#foreach( $payment in $ticket.paymentsTenderControl )
	#if($payment.tenderGsaId == 26 )
		text "#fmt("  %-17.17s  %-4.4s  %12.12s", ["D. BELICEÑO   $", "$payment.qtyTenderGsa", "#fmtDec($payment.totalTenderGsa)"])";
		text "(#fmtDec($payment.totalForeignAmount) * $payment.foreignCurrencyQuote)";
		newline;
	#end
#end
##Dolar Canadiense
#foreach( $payment in $ticket.paymentsTenderControl )
	#if($payment.tenderGsaId == 28 )
		text "#fmt("  %-17.17s  %-4.4s  %12.12s", ["D. CANADIENSE $", "$payment.qtyTenderGsa", "#fmtDec($payment.totalTenderGsa)"])";
		text "(#fmtDec($payment.totalForeignAmount) * $payment.foreignCurrencyQuote)";
		newline;
	#end
#end
newline;
newline;
text "#fmt("%24.24s  %1.1s%9.9s", ["CONTEO TOTAL DE RETIRO:","$","#fmtDec($ticket.paymentsTotal)"])";
newline;
text "#fmt("%23.23s  %1.1s%10.10s", ["TOTAL RETIRADO ACTUAL:", "$", "#fmtDec($totals.entregado)"])";
newline;