#if($ticket.transactionType == 2)
    #set ($sign = "-1")
#else
	  #set ($sign = "1")	
#end

#if($payment.tenderGsaId == 8)
#set($flagGsaId = "true")
#end

#if($payment.tenderGsaId == 2 && !$payment.additionalData.ad_isVale && $ticket.transactionType != 2)
	#if($notSecureAccount == "true" || $payment.additionalData.accountType == 3)
   	  text "#fmt("%18s %1s  %16s", ["$payment.additionalData.account","$","#fmtDec($payment.amount,$sign)"])";
 	#else
      text "#fmt("%18s %1s  %16s", ["#maskAcc($payment.additionalData.account)","$","#fmtDec($payment.amount,$sign)"])";
  #end	
#end

#if($payment.tenderGsaId != 2 && $payment.tenderGsaId != 8 && $payment.tenderGsaId != 10 && $payment.tenderGsaId != 11 && $payment.tenderGsaId != 19 && $payment.tenderGsaId != 20 && $payment.tenderGsaId != 30)
	#set ($description = "$payment.getDescription()")
	#if($ticket.transactionType == 2 && $payment.tenderGsaId == 15)
		#set($description = "EFECTIVO")
	#end
	#if(($payment.additionalData.isPaymentEwallet && $payment.additionalData.isPaymentEwallet == "true"))
    #set($description = "P O C K E T")
	#end
	text "#fmt("%18.18s %1.1s  %16.16s", ["$description","$","#fmtDec($payment.amount,$sign)"])";
#end

#if($payment.folio && $payment.isExternalCoupon())
	text "#fmt("%19.19s %17.17s", ["Folio:","$payment.folio"])";
#end

#if($payment.tenderGsaId == 30 )
	text "#fmt("%11.11s  %5.5s  %16.16s", ["DOLARES US:","","#fmtDec($payment.foreignAmount)"])";
	text "#fmt("%15.15s  %1.1s  %16.16s", ["TIPO DE CAMBIO:","","#fmtDec($payment.amountCurrency)"])";
	text "#fmt("%26.26s  %0.0s  %6.6s", ["IMPORTE PAGADO EN DOLARES:","","#fmtDec($payment.amount, $sign)"])";
#end

#if($payment.tenderGsaId == 26 || $payment.tenderGsaId == 27 || $payment.tenderGsaId == 28 || $payment.tenderGsaId == 31)
	#if($payment.tenderTypeCode && $payment.amountCurrency && $payment.foreignAmount)
	  text "#fmt("(%1.2s %6.6s %1.3s%1.5s)", [$payment.tenderTypeCode,"#fmtDec($payment.foreignAmount)","* $","#fmtDec($payment.amountCurrency)"])";
	#end
#end

## Impresiones de pagos con tarjetas
#if($payment.tenderGsaId == 8 || $payment.tenderGsaId == 10 || $payment.tenderGsaId == 11 || $payment.tenderGsaId == 19 || $payment.tenderGsaId == 20)
	  setAlignment left;
	  beginBold;
   	  #if($payment.additionalData.isPuntosBmerPayed)
   		  text "PAGADO CON PUNTOS BBVA";
   	  #end
   	  #if($payment.additionalData.isPuntosMasterCardPayed)
   		  text "PAGADO CON PUNTOS BANCARIOS";
      #end
      #if($payment.tenderGsaId == 10)
        #set ($sign = "1")
      #end
      #if($payment.bankDescription)
        #set ($description = $payment.bankDescription)
      #end
	    #if(($payment.additionalData.isPaymentEwallet && $payment.additionalData.isPaymentEwallet == "true"))
        #set($description = "P O C K E T")
	    #else
        #set ($description = $payment.description)
      #end
      #if($ticket.transactionType == 2 && ($payment.tenderGsaId == 8 || $payment.tenderGsaId == 11))
        text "#fmt("%-18s %1s%17s", ["$description","$","#fmtDec($payment.amount, $sign)"])";
      #else
        text "#fmt("%-18s %1s%18s", ["$description", "$", "#fmtDec($payment.amount, $sign)"])";
  	  #end
    endBold;

	#if($payment.tenderGsaId == 10)
        #set ($tenderPayment = $payment)
		#if($payment.appLabel)
			text "$payment.appLabel";
		#end
	#end
	#if($payment.inputType)
		text "$payment.inputType";
	#end
	#if($payment.descriptionPrint)
		text "$payment.descriptionPrint";
	#end
	#if(!$payment.additionalData.isCoDi)
        #if($payment.account)
            #if($notSecureAccount == "true")
               text "CUENTA: $payment.account";
            #else
               text "CUENTA: #maskAcc($payment.account)";
            #end
         #end
    #end
  #if($payment.nombre && $payment.nombre != "")
    text "NOMBRE: $payment.nombre";
  #end
	#if($payment.tenderGsaId == 10)
	   #if($payment.bankAfiliation)
	      text "AFILIACION: $payment.bankAfiliation";
	   #end
	#end
	
		## Dilisa y LPC imprimen solo si es MSI
	  #if($payment.isMsi())
   	    ## en devolucion no escribe esta leyenda
        #if($payment.selectedInstallments != 0 && $payment.selectedInstallments != 1 && $payment.selectedInstallmentAmount != 0)
	   	  text "#fmt("%1.2s %24s %-11s", ["$payment.selectedInstallments","PAGOS MENSUALES DE:    $", "#fmtDec($payment.selectedInstallmentAmount)"])";
		  #end
		#end
		#if($payment.tenderGsaId == 10)
          #if ($payment.criptograma)
			text "ARQC: $payment.criptograma";
			#if ($payment.aid)
			  text "AID: $payment.aid";
            #end
            #if($payment.nip)
			  text "AUTORIZADO MEDIANTE FIRMA ELECTRÓNICA";
            #elseif(($payment.contactLess && ($payment.tenderGsaId == 11 || $payment.tenderGsaId == 20)) || ($payment.nip || $payment.sinFirma || ($payment.contactLess && $payment.tenderGsaId != 11 && $payment.tenderGsaId != 20) || $payment.qps || ($payment.isPaymentEwallet && $payment.isPaymentEwallet == "true")))
              text "AUTORIZADO SIN FIRMA";
            #elseif($payment.autografa || (!$payment.qps && !$payment.nip && !$payment.sinFirma))
              text "AUTORIZADO MEDIANTE FIRMA AUTÓGRAFA";
            #end
          #end
	    #end

		#if($payment.restoPuntos)
   		 newline;
   		 text "#fmt("%13.13s  %1.1s  %16.16s", ["TOTAL A PAGAR","$","#fmtDec($payment.restoPuntos)"])";
   	    #end
		
		#if($payment.additionalData.isPuntosBmerCard && $payment.additionalData.puntosBmerSaldoAnteriorPesos)
				
				setAlignment left;
				text "--------------------------------------";
				text "Puntos BBVA";
				text "$payment.additionalData.puntosBmerPoolId";
				text "#fmt("Saldo Anterior       %-15.15s", ["$payment.additionalData.puntosBmerSaldoAnteriorPuntos (PTS)"])";
				###text "#fmt("Importe en pesos     $%-14.14s", ["#fmtDec($payment.additionalData.puntosBmerSaldoAnteriorPesos)"])";
				newline;
				text "#fmt("Redimidos            %-15.15s", ["$payment.additionalData.puntosBmerSaldoRedimidoPuntos (PTS)"])";
				###text "#fmt("Importe en pesos     $%-14.14s", ["#fmtDec($payment.additionalData.puntosBmerSaldoRedimidoPesos)"])";
				newline;
				text "#fmt("Saldo Actual         %-15.15s", ["$payment.additionalData.puntosBmerSaldoPuntos (PTS)"])";
				###text "#fmt("Importe en pesos     $%-14.14s", ["#fmtDec($payment.additionalData.puntosBmerSaldoPesos)"])";
				newline;
				#if($payment.additionalData.puntosBmerfactorExp != "00" && $payment.additionalData.puntosBmerfactorExp != "01")
   				text "--------------------------------------";
   				setAlignment center;
   				text "PUNTOS EXPONENCIALES";
   				text "--------------------------------------";
   				text "#fmt("Redimidos            %-15.15s", ["$payment.additionalData.puntosBmerSaldoRedimidoExpPuntos (PTS)"])";
   				###text "#fmt("Importe en pesos     $%-14.14s", ["#fmtDec($payment.additionalData.puntosBmerSaldoRedimidoExpPesos)"])";
   				newline;
   				text "HOY EN ESTE COMERCIO TUS PUNTOS VALEN: ";
   				newline;
   				text "#fmt("Saldo Actual         %-15.15s", ["$payment.additionalData.puntosBmerSaldoDispExpPuntos (PTS)"])";
   				###text "#fmt("Importe en pesos     $%-14.14s", ["#fmtDec($payment.additionalData.puntosBmerSaldoDispExpPesos)"])";
   				text "#fmt("Promocion vigente al %-15.15s", ["$payment.additionalData.puntosBmerVigenciaPromoExp"])";
   				newline;
				#end

		    text "--------------------------------------";
		#end

		#if($payment.additionalData.isPuntosMasterCardCard)
                setAlignment left;
                text "--------------------------------------";
                text "Puntos bancarios";
                text "#fmt("Saldo Anterior       %-15.15s", ["$payment.additionalData.puntosMasterCardSaldoAnteriorPuntos (PTS)"])";
                newline;
                text "#fmt("Redimidos            %-15.15s", ["$payment.additionalData.puntosMasterCardSaldoRedimidosPuntos (PTS)"])";
                newline;
                text "#fmt("Saldo Actual         %-15.15s", ["$payment.additionalData.puntosMasterCardSaldoPuntos (PTS)"])";
                newline;
                text "--------------------------------------";
        #end
#end

##Logica para venta normal pagada con vale, se debe mostrar informacion del monedero
#if($payment.tenderGsaId == 2 && !$monedero.walletAccount && !$payment.additionalData.ad_isVale && !$monedero.vale)
	#if($payment.additionalData.actual_balance != $payment.additionalData.refund_balance && $isMonederoPrinted=="")
				newline;
		    #if($notSecureAccount == "true" || $payment.additionalData.accountType == 3)
			      text "#center("-------  $payment.additionalData.account  -------")";
			  #else
				    text "#center("-------  #maskAcc($payment.additionalData.account)  -------")";
			  #end	 
		    #set ($isMonederoPrinted = "printed")
			  #if($payment.additionalData.old_balance)
				  text "#fmt("%20s  %1s %14s", ["Saldo anterior ","$","#fmtDec($payment.additionalData.old_balance)"])";
				#end
				#if($ticket.transactionType == 2)
				  text "#fmt("%20s  %1s %14s", ["Monto utilizado","$","0.00"])";
				#end
				#if($payment.amount && $ticket.transactionType != 2)
				  text "#fmt("%20s  %1s %14s", ["Monto utilizado","$","#fmtDec($payment.amount)"])";
				#end
				#if($payment.additionalData.promo_balance)
				  text "#fmt("%20s  %1s %14s", ["Monto obtenido ","$","#fmtDec($payment.additionalData.promo_balance)"])";
				#end
				#if($payment.additionalData.actual_balance)
				  text "#fmt("%20s  %1s %14s", ["Saldo actual   ","$","#fmtDec($payment.additionalData.actual_balance)"])";
				#end
	#end
#end

#if($payment.tenderGsaId == 0)
	###text "#fmt("%s AUTORIZACION **%s**", ["$payment.inputType","$payment.authorizationCode"])";
	text "$payment.inputType";
	text "#fmt("BANDA %s", ["$payment.account"] )";
#end

#if($payment.tenderGsaId == 2 && $payment.additionalData.ad_isVale && $ticket.transactionType != 2 && $payment.additionalData.accountType == 4)
    text "--------------------------";
	text "#fmt("%18s %1s  %16s", ["$payment.additionalData.account","$","#fmtDec($payment.amount,$sign)"])";
	text "--------------------------";
#end

##Bloque para detalle de minipagos de vale de credito al consumo Suburbia
#if($payment.isMiniPayment)
	text "CUENTA: #maskAcc($payment.account)";
	##text para mostrar numero de pagos y monto
	##text "#fmt("%1.2s %24s %-11s", ["$payment.biWeekelySelectedInstallments","PAGOS QUINCENALES DE:    $", "#fmtDec($payment.biWeekelySelectedInstallmentAmount)"])";
	##text para mostrar solo el monto a pagar
	text "#fmt("%24s %-11s", ["PAGOS QUINCENALES DE:    $", "#fmtDec($payment.biWeekelySelectedInstallmentAmount)"])";
	newline;
	#set ($barCodeCC = "$payment.getAccount()-$payment.getBiWeekelySelectedInstallmentAmount()")
	barcode Code93 "$barCodeCC" 50 2 center none;
	newline;
	barcode Code93 "$payment.cbConsutVale" 50 2 center none;
	newline;
#end