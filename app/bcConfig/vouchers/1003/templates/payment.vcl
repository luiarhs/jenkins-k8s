#if($ticket.transactionType == 2)
    #set ($sign = "-1")
    #if($payment.tenderGsaId == 10)
        #set ($payment_ContainsTenderGsa10Refund = true)
    #end
#else
	#set ($sign = "1")	
#end
#if($payment.tenderGsaId == 2 && !$payment.additionalData.ad_isVale && $ticket.transactionType != 2)
	#if($notSecureAccount == "true")
      text "#fmt("%13.13s %1.1s  %16.16s", ["$payment.additionalData.account","$","#fmtDec($payment.amount,$sign)"])";
 	#else
	   text "#fmt("%13.13s %1.1s  %16.16s", ["#maskAcc($payment.additionalData.account)","$","#fmtDec($payment.amount,$sign)"])";
   #end	
#end
#if($payment.tenderGsaId != 2 && $payment.tenderGsaId != 8 && $payment.tenderGsaId != 10 && $payment.tenderGsaId != 11 && $payment.tenderGsaId != 30)
	text "#fmt("%18.18s %1.1s  %16.16s", ["$payment.description","$","#fmtDec($payment.amount,$sign)"])";
#end

#if($payment.tenderGsaId == 30 )
	text "#fmt("%13.13s  %3.3s  %16.16s", ["DOLARES","US:","#fmtDec($payment.foreignAmount)"])";
	text "#fmt("%15.15s  %1.1s  %16.16s", ["TIPO DE CAMBIO:","$","#fmtDec($payment.amountCurrency)"])";
	text "#fmt("%23.23s  %1.1s  %6.6s", ["IMPORTE PAGADO EN DOLARES","$","#fmtDec($payment.amount, $sign)"])";
	
#end

#if($payment.tenderGsaId == 27 || $payment.tenderGsaId == 31 || $payment.tenderGsaId == 26 || $payment.tenderGsaId == 28)	
	#if($payment.tenderTypeCode && $payment.amountCurrency && $payment.foreignAmount)
	  text "#fmt("(%4.4s %6.6s %4.4s %6.6s )", [$payment.tenderTypeCode,"#fmtDec($payment.foreignAmount)"," * $","#fmtDec($payment.amountCurrency)"])";
	#end
	newline;
#end
#if($payment.tenderGsaId == 8 || $payment.tenderGsaId == 10 || $payment.tenderGsaId == 11)
	#if($payment.restoPuntos)
		newline;
		text "#fmt("%13.13s  %1.1s  %16.16s", ["REVOLVENTE","$","#fmtDec($payment.restoPuntos)"])";
	#end
	#if($payment.additionalData.isPuntosBmerPayed)
		text "PAGADO CON PUNTOS";
	#end
	#if($payment.additionalData.bankdescription)
		newline;
		text "#fmt("%13.13s  %1.1s  %16.16s", ["$payment.additionalData.bankdescription","$","#fmtDec($payment.amount)"])";
	#else
		newline;
		text "#fmt("%13.13s  %1.1s  %16.16s", ["$payment.description","$","#fmtDec($payment.amount)"])";
	#end
	setAlignment left;
        #if($payment.inputType)
            text "$payment.inputType";
        #end
	#if($payment.descriptionPrint)
		text "$payment.descriptionPrint";
	#end
	#if($payment.account)
		#if($notSecureAccount == "true")
         text "CUENTA :  $payment.account";
    	#else
   	   text "CUENTA :  #maskAcc($payment.account)";
      #end	      
    #end
    #if($payment.nombre)
        text "NOMBRE :   $payment.nombre";
    #end
	#if($payment.tenderGsaId == 10)
	    #if($payment.bankAfiliation)
	        text"AFILIACION :            $payment.bankAfiliation";
	    #end
	#end
	#if(!($payment.additionalData.ad_paymentPlanPresDif))
		#if($payment.selectedInstallments!=0 && $payment.selectedInstallments!=1)
			text "#fmt("%2.2s %21.21s %8.8s", ["$payment.selectedInstallments","PAGOS MENSUALES DE: $","$payment.selectedInstallmentAmount"])";
		#end
	#end
        #if($payment.tenderGsaId == 10)
		#if($payment.criptograma)
			text "ARQC:$payment.criptograma";
		#end
            #if($payment.aid)
                text "AID: $payment.aid";
            #end
            #if($ticket.transactionType == 2)
                #parse( "1003/templates/signature.vcl" )
            #end
	#end
	#if($payment.additionalData.isPuntosBmerCard && $payment.additionalData.puntosBmerSaldoAnteriorPesos)
		text "--------------------------------------";
		setAlignment left;
		text "Puntos Bancomer";
		text "#fmt("Saldo Anterior       %-15.15s", ["$payment.additionalData.puntosBmerSaldoAnteriorPuntos (PTS)"])";
		text "#fmt("Importe en pesos     $%-14.14s", ["#fmtDec($payment.additionalData.puntosBmerSaldoAnteriorPesos)"])";
		newline;
		text "#fmt("Redimidos            %-15.15s", ["$payment.additionalData.puntosBmerSaldoRedimidoPuntos (PTS)"])";
		text "#fmt("Importe en pesos     $%-14.14s", ["#fmtDec($payment.additionalData.puntosBmerSaldoRedimidoPesos)"])";
		newline;
		text "#fmt("Saldo Actual         %-15.15s", ["$payment.additionalData.puntosBmerSaldoPuntos (PTS)"])";
		text "#fmt("Importe en pesos     $%-14.14s", ["#fmtDec($payment.additionalData.puntosBmerSaldoPesos)"])";
		newline;
		#if($payment.additionalData.puntosBmerfactorExp != "00" && $payment.additionalData.puntosBmerfactorExp != "01")
			text "--------------------------------------";
			setAlignment center;
			text "PUNTOS EXPONENCIALES";
			text "--------------------------------------";
			text "#fmt("Redimidos            %-15.15s", ["$payment.additionalData.puntosBmerSaldoRedimidoExpPuntos (PTS)"])";
			text "#fmt("Importe en pesos     $%-14.14s", ["#fmtDec($payment.additionalData.puntosBmerSaldoRedimidoExpPesos)"])";
			newline;
			text "HOY EN ESTE COMERCIO TUS PUNTOS VALEN: ";
			newline;
			text "#fmt("Saldo Actual         %-15.15s", ["$payment.additionalData.puntosBmerSaldoDispExpPuntos (PTS)"])";
			text "#fmt("Importe en pesos     $%-14.14s", ["#fmtDec($payment.additionalData.puntosBmerSaldoDispExpPesos)"])";
			text "#fmt("Promoción vigente al %-15.15s", ["$payment.additionalData.puntosBmerVigenciaPromoExp"])";
		#end
		newline;
	   text "--------------------------------------";
		newline;
	#end
#end
#if($payment.tenderGsaId == 0)
	text "#fmt("%s AUTORIZACION **%s**", ["$payment.inputType","$payment.authorizationCode"])";
	text "#fmt("BANDA %s", ["$payment.account"] )";
#end