newline;
text "RESUMEN DE CONTEO DE RETIRO";
newline;
newline;
text "#fmt("%15.15s %5.5s  %10.10s", ["TIPO DE PAGO", "CNT", "MONTO"])";
newline;
#foreach( $payment in $ticket.paymentsTenderControl )
	#if($payment.tenderGsaId == 15 )
		text "#fmt("  %-10.10s  %-4.4s  %12.12s", ["CONTA", "$payment.qtyTenderGsa", "#fmtDec($payment.totalTenderGsa)"])";
	#end
#end
##Monedero
#foreach( $payment in $ticket.paymentsTenderControl )
	#if($payment.tenderGsaId == 2 )
		text "#fmt("  %-10.10s  %-4.4s  %12.12s", ["VALE", "$payment.qtyTenderGsa", "#fmtDec($payment.totalTenderGsa)"])";
	#end
#end
##Dolares
#foreach( $payment in $ticket.paymentsTenderControl )
	#if($payment.tenderGsaId == 30 )
		text "#fmt("  %-10.10s  %-4.4s  %12.12s", ["US 30", "$payment.qtyTenderGsa", "#fmtDec($payment.totalTenderGsa)"])";
	#end
#end
##Quetzales
#foreach( $payment in $ticket.paymentsTenderControl )
	#if($payment.tenderGsaId == 31 )
		text "#fmt("  %-10.10s  %-4.4s  %12.12s", ["QT 31", "$payment.qtyTenderGsa", "#fmtDec($payment.totalTenderGsa)"])";
	#end
#end
##Euros
#foreach( $payment in $ticket.paymentsTenderControl )
	#if($payment.tenderGsaId == 27 )
		text "#fmt("  %-10.10s  %-4.4s  %12.12s", ["EU 27", "$payment.qtyTenderGsa", "#fmtDec($payment.totalTenderGsa)"])";
	#end
#end
##Dolar Belicenio
#foreach( $payment in $ticket.paymentsTenderControl )
	#if($payment.tenderGsaId == 26 )
		text "#fmt("  %-10.10s  %-4.4s  %12.12s", ["DB", "$payment.qtyTenderGsa", "#fmtDec($payment.totalTenderGsa)"])";
	#end
#end
##Dolar Canadiense
#foreach( $payment in $ticket.paymentsTenderControl )
	#if($payment.tenderGsaId == 28 )
		text "#fmt("  %-10.10s  %-4.4s  %12.12s", ["DC", "$payment.qtyTenderGsa", "#fmtDec($payment.totalTenderGsa)"])";
	#end
#end
newline;
newline;
text "#fmt("%24.24s  %1.1s%9.9s", ["CONTEO TOTAL DE RETIRO:","$","#fmtDec($ticket.paymentsTotal)"])";
newline;
text "#fmt("%23.23s  %1.1s%10.10s", ["TOTAL RETIRADO ACTUAL:", "$", "#fmtDec($totals.entregado)"])";
newline;



