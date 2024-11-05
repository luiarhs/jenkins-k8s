##Efectivo
#foreach( $payment in $ticket.payments )
	#if($payment.tenderGsaId == 15 )
		text "#fmt("  %-8.8s  %-4.4s  %8.8s  %8.8s", ["CONTA", "$payment.count", "#fmtDec($payment.denomination)", "#fmtDec($payment.amount)"])";
	#end
#end
##Cheques
#foreach( $payment in $ticket.payments )
	#if($payment.tenderGsaId == 0 )
		text "#fmt("  %-8.8s  %-4.4s  %8.8s  %8.8s", ["CHEQ.", "$payment.count", "#fmtDec($payment.denomination)", "#fmtDec($payment.amount)"])";
	#end
#end
##Cupones
#foreach( $payment in $ticket.payments )
	#if($payment.tenderGsaId == 1 )
		text "#fmt("  %-8.8s  %-4.4s  %8.8s  %8.8s", ["CUPON", "$payment.count", "#fmtDec($payment.denomination)", "#fmtDec($payment.amount)"])";
	#end
#end
##Monedero
#foreach( $payment in $ticket.payments )
	#if($payment.tenderGsaId == 2 )
		text "#fmt("  %-8.8s  %-4.4s  %8.8s  %8.8s", ["VALE", "$payment.count", "#fmtDec($payment.denomination)", "#fmtDec($payment.amount)"])";
	#end
#end
##Dolares
#foreach( $payment in $ticket.payments )
	#if($payment.tenderGsaId == 30 )
		text "#fmt("  %-8.8s  %-4.4s  %8.8s  %8.8s", ["US 30", "$payment.count", "#fmtDec($payment.denomination)", "#fmtDec($payment.amount)"])";
	#end
#end
##Quetzales
#foreach( $payment in $ticket.payments )
	#if($payment.tenderGsaId == 31 )
		text "#fmt("  %-8.8s  %-4.4s  %8.8s  %8.8s", ["QT 31", "$payment.count", "#fmtDec($payment.denomination)", "#fmtDec($payment.amount)"])";
	#end
#end
##Euros
#foreach( $payment in $ticket.payments )
	#if($payment.tenderGsaId == 27 )
		text "#fmt("  %-8.8s  %-4.4s  %8.8s  %8.8s", ["EU 27", "$payment.count", "#fmtDec($payment.denomination)", "#fmtDec($payment.amount)"])";
	#end
#end
##Dolar Beliceño
#foreach( $payment in $ticket.payments )
	#if($payment.tenderGsaId == 26 )
		text "#fmt("  %-8.8s  %-4.4s  %8.8s  %8.8s", ["DB   ", "$payment.count", "#fmtDec($payment.denomination)", "#fmtDec($payment.amount)"])";
	#end
#end
##Dolar Canadiense
#foreach( $payment in $ticket.payments )
	#if($payment.tenderGsaId == 28 )
		text "#fmt("  %-8.8s  %-4.4s  %8.8s  %8.8s", ["DC   ", "$payment.count", "#fmtDec($payment.denomination)", "#fmtDec($payment.amount)"])";
	#end
#end