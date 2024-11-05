#parse( "1003/templates/shortHeader.vcl" )
text "#fmt("%30.30s %5.5s", ["NO. ORIGINAL DE TERMINAL   ","$ticket.terminalCode"])";
#if($ticket.additionalSubType == 7)	
	text "#fmt("%30.30s %5.5s", ["NO. RETIRO CANCELADO  ","$ticket.originalTicketNumber"])";
	text "#fmt("%25.30s  %5.1s %1.8s", ["MONTO RETIRO CANCELADO  ","$","$ticket.total"])";
	text "#fmt("%23.23s  %1.1s%10.10s", ["TOTAL RETIRADO ACTUAL", "$", "#fmtDec($totals.entregado)"])";
	text "#fmt("      ATENDIO: %-s", "$ticket.userNameDescription")";
	text "* COMPLETA * #formatFecha($date)   $time";
	newline;
	newline;
	newline;
	newline;
	cutPaperManual;
#else
	text "#fmt("%30.30s %5.5s", ["NO. TRANSACCION CANCELADA  ","$ticket.originalTicketNumber"])";
	text "#fmt("%25.30s  %5.1s %1.8s", ["MONTO TRANSAC. CANCEL  ","$","$ticket.total"])";
	
	#foreach($payment in $ticket.payments)
		#if($payment.tenderGsaId == 8 || $payment.tenderGsaId == 10 || $payment.tenderGsaId == 11)
			text "#fmt("*%-2.2s*%-16.16s* %10.1s %-8.8s", ["$payment.tenderGsaId","#maskAcc($payment.additionalData.account)","$","$payment.amount"])";
		#end
	#end
	text "TIENDA:  $ticket.trxVoucher #formatFecha($date)   $time";
	newline;
	newline;
	newline;
	newline;
	cutPaperManual;
	
    #foreach( $payment in $ticket.payments)
        
        #if($payment.additionalData.eglobalCard)
            #set ($epayment_is_duplicate = false)
            #parse( "1003/templates/epayment.vcl" )
            newline;
            newline;
            newline;
            newline;
            cutPaperManual;
            #set ($epayment_is_duplicate = true)
            #parse( "1003/templates/epayment.vcl" )
            newline;
            newline;
            newline;
            newline;
            cutPaperManual;
        #end
    #end
#end