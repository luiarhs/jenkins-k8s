#if($printerType != "7")
	cutPaperManual;
#end

#set ($epayment_process = false)
#if(!$ticket.isDigitalTicket())
    setStation 2;
#end
#if($ticket.additionalSubType == 7 || $ticket.additionalSubType == 157)
	#if($printerType == "7")
		setFontSize normal;
		text "#fmt("NO. ORIGINAL DE TERMINAL           %03s", "$ticket.terminalCode")";
		text "#fmt("NO. RETIRO CANCELADO        %5s", "$ticket.originalTicketNumber")";
		text "#fmt("MONTO RETIRO CANCELADO   $ %13s", "$ticket.total")";
		text "#fmt("TOTAL RETIRADO ACTUAL   $%14s", "#fmtDec($totals.entregado)")";
		text "#fmt("     ATENDIO :%-s", "$ticket.userNameDescription")";
		text       " * COMPLETA *       #formatFecha($date)    $time";
	#else
		newline;
		setCharsPerLine 44;
		text "#fmt("NO. ORIGINAL DE TERMINAL           %03s", "$ticket.terminalCode")";
		text "#fmt("NO. RETIRO CANCELADO        %5s", "$ticket.originalTicketNumber")";
		text "#fmt("MONTO RETIRO CANCELADO   $ %13s", "$ticket.total")";
		text "#fmt("TOTAL RETIRADO ACTUAL   $%14s", "#fmtDec($totals.entregado)")";
		text "#fmt("     ATENDIO :%-s", "$ticket.userNameDescription")";
		text       " * COMPLETA *       #formatFecha($date)    $time";
	#end

#else
    #parse( "1001/templates/shortHeader.vcl" )
    newline;
    text "#fmt("NO. ORIGINAL DE TERMINAL           %03s", "$ticket.terminalCode")";
    text "#fmt("NO. TRANSACCION CANCELADA        %5s", "$ticket.originalTicketNumber")";
    text "#fmt("MONTO TRANSAC. CANCEL        $%1s", "$ticket.total")";
    newline;
    #if ($ticket.accountPaymentData)

      text "#fmt("*%2s*      %08s*%s", ["$ticket.accountPaymentData.cardType","$ticket.accountPaymentData.authorizationCode","$ticket.accountPaymentData.account"])";

    #end

	#foreach($payment in $ticket.payments)
		#if ($payment.authorization_code && ($payment.tenderGsaId == 8 || $payment.tenderGsaId == 11))
			text "#fmt("*%2s*      %08s* %s", ["$payment.tenderGsaId","$payment.authorization_code","$payment.additionalData.account"])";
		#end
		#if($ticket.additionalSubType != 105 && $ticket.additionalSubType != 138)
            #if($payment.additionalData.eglobalCard || $payment.tenderGsaId == 10)
                #set ($epayment_process = true)
                beginBold;
                    #if($payment.additionalData.bankdescription)
                        text "#fmt("%-17s  %s   %15s", ["$payment.additionalData.bankdescription","$","#fmtDec($payment.amount,$sign)"])";
                    #else
                        text "#fmt("%-17s  %s   %15s", ["$payment.description","$","#fmtDec($payment.amount,$sign)"])";
                    #end
                endBold;
                #if($payment.inputType)
                    text "$payment.inputType";
                #end
                #if($payment.account)
                    #if($notSecureAccount == "true")
                        text "CUENTA: $payment.account";
                    #else
                        text "CUENTA: #maskAcc($payment.account)";
                    #end
                #end
                #if($payment.nombre)
                    text "NOMBRE: $payment.nombre";
                #end
                #if($payment.bankAfiliation)
                    text "AFILIACIÓN: $payment.bankAfiliation";
                #end
                #if($payment.criptograma)
                    text "ARQC: $payment.criptograma";
                #end
                #if($payment.aid)
                    text "AID: $payment.aid";
                #end
            #end
		#end
	#end
#end

newline;

#if($ticket.additionalSubType != 7)	   
   text "#fmt("TIENDA %4s   %15s  %5s", ["$ticket.trxVoucher","#formatFecha($date)","$time"])";
#end

#if (!$ticket.printFranqueo)
    cutPaper 90;
#else
    cutPaperManual;
#end

#if($printerType == "7")
	cutPaperManual;
#end

setFontSize normal;