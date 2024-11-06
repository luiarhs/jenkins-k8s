#if($printerType == "2")
    setCharsPerLine 48;
#else
    setCharsPerLine 38;
#end
##Efectivo
newline;
#foreach( $payment in $ticket.payments )
	#if($payment.tenderGsaId == 15 )
		text "#fmt("%5s %4s   %9s    %9s", ["CONTA", "$payment.count", "#fmtDec($payment.denomination)", "#fmtDec($payment.amount)"])";
	#end
#end
##Cheque
#foreach( $payment in $ticket.payments )
	#if($payment.tenderGsaId == 0 )
		text "#fmt("%5s %4s   %9s    %9s", ["CHEQ.", "$payment.count", "#fmtDec($payment.denomination)", "#fmtDec($payment.amount)"])";
	#end
#end
##Cupones
#foreach( $payment in $ticket.payments )
	#if($payment.tenderGsaId == 1 )
		text "#fmt("%5s %4s   %9s    %9s", ["CUPON", "$payment.count", "#fmtDec($payment.denomination)", "#fmtDec($payment.amount)"])";
	#end
#end
##Monedero
#foreach( $payment in $ticket.payments )
	#if($payment.tenderGsaId == 2 )
		text "#fmt("%5s %4s   %9s    %9s", ["VALE", "$payment.count", "#fmtDec($payment.denomination)", "#fmtDec($payment.amount)"])";
	#end
#end
##Dolares
#foreach( $payment in $ticket.payments )
	#if($payment.tenderGsaId == 30 )
		text "#fmt("%5s %4s   %9s    %9s", ["US 30", "$payment.count", "#fmtDec($payment.denomination)", "#fmtDec($payment.amount)"])";
	#end
#end
##Quetzales
#foreach( $payment in $ticket.payments )
	#if($payment.tenderGsaId == 31 )
		text "#fmt("%5s %4s   %9s    %9s", ["QT 31", "$payment.count", "#fmtDec($payment.denomination)", "#fmtDec($payment.amount)"])";
	#end
#end
##Euros
#foreach( $payment in $ticket.payments )
	#if($payment.tenderGsaId == 27 )
		text "#fmt("%5s %4s   %9s    %9s", ["EU 27", "$payment.count", "#fmtDec($payment.denomination)", "#fmtDec($payment.amount)"])";
	#end
#end
##Dolar Beliceño
#foreach( $payment in $ticket.payments )
	#if($payment.tenderGsaId == 26 )
		text "#fmt("%5s %4s   %9s    %9s", ["DB", "$payment.count", "#fmtDec($payment.denomination)", "#fmtDec($payment.amount)"])";
	#end
#end
##Dolar Canadiense
#foreach( $payment in $ticket.payments )
	#if($payment.tenderGsaId == 28 )
		text "#fmt("%5s %4s   %9s    %9s", ["DC", "$payment.count", "#fmtDec($payment.denomination)", "#fmtDec($payment.amount)"])";
	#end
#end