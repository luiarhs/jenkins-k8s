#set ($imprimeCF = true);

#if ($ticket.creditNumberHipotecaVerde)
   setAlignment left;
   text "CREDITO INFONAVIT: $ticket.creditNumberHipotecaVerde";
   #if ($ticket.motivoHipotecaVerde)
      #if ($ticket.motivoHipotecaVerde=="0")
         text "Tarjeta virtual";
      #else
         text "Constancia";
      #end
   #end
   newline;
#end

#if($ticket.transactionDiscountAuthorized)
    setAlignment left;
    text "DESC. AUTORIZACION: $ticket.transactionDiscountAuthorizingUser  $ticket.transactionDiscountAuthorizingUserName ";
    newline;
#end

#if($ticket.additionalSubType == 139)
		setAlignment left;
		text "**************************************";
		#if($ticket.datosCentroServ)
	    text "#divStr($ticket.datosCentroServ, 38 )";
	    text "**************************************";
    #end 
    #if($ticket.datosCliente)
	    text "#divStr($ticket.datosCliente, 38 )";
	    text "**************************************";
    #end 
#end 

#if( $ticket.giftsPlanData )
	#if($ticket.giftsPlanData.typeElectronicGift == -1)
		#if($ticket.giftsPlanData.fatherSurname && $ticket.giftsPlanData.motherSurname && $ticket.giftsPlanData.name)
			text "Realiza pago:";
			text "$ticket.giftsPlanData.fatherSurname:$ticket.giftsPlanData.motherSurname:$ticket.giftsPlanData.name";
		#else
		    #if($ticket.nroOrdenPaqueteria)
		    	text "Realiza pago:";
				text "::";
			#end
		#end
	#end
#end

#if($ticket.nroOrdenPaqueteria)
	setAlignment center;
	#set($lblOptionOmnicanal = "")
	### 0 = Click and Collect,  1 = Envio a Domicilio
	#if($ticket.optionSelectedOmnicanal) 
		#if($ticket.optionSelectedOmnicanal == 0)
			#set($lblOptionOmnicanal = " C&C")
		#else
			#set($lblOptionOmnicanal = " ED")
		#end
	#end
	#if($ticket.optionSelectedMarketplacePos)
        #if($ticket.optionSelectedMarketplacePos == 0)
       		#set($lblOptionOmnicanal = " C&C")
       	#else
       		#set($lblOptionOmnicanal = " ED")
       	#end
    #end
	text "#fmt("       No. PEDIDO$lblOptionOmnicanal:  %-s", "$ticket.nroOrdenPaqueteria")";
	newline;
#end

#if ($ticket.dilisaCorporated)
	text "#center("Corporativa no emite monedero")";
	newline;
#end

#if (!($ticket.ticketVoidFlag))
	#if($ticket.voucher)
		text "#center("****    $ticket.voucher    ****")";
		newline;
	#end
#end

#if($ticket.paqueteriaOffLine)
   	beginBold;
    setAlignment center;
	text "**************************************";
	text "**   ESTA REMISION SE DARA DE ALTA  **";
	text "**AUTOMATICAMENTE EL DIA DE MAÑANA  **";
	text "**************************************";
    newline;
    endBold;
#end

#if ($ticket.antiMoneyLaundry)
	text "******** Aviso Antilavado ********";
	newline;
#end

## Necesitamos agregar el newline si hay mensajes de errores
#if ($ticket.listMessageError.size() > 0)
   #foreach($error in $ticket.listMessageError)
      text "$error";
   #end
   newline;
#end

#if($ticket.additionalSubType == 119 || $ticket.additionalSubType == 120 || $ticket.additionalSubType == 143 || $ticket.additionalSubType == 144)
	text "************************************";
	text "#fmt("ABONO A: %-20s", "$accountPayment.account" )";
	#if($accountPayment.accountName)
		text "NOMBRE: $accountPayment.accountName";
	#end
	#if($accountPayment.authorizationCode)
		text "#fmt("1  AUTORIZACION **%-8s**", $accountPayment.authorizationCode )";
	#end
	text "************************************";
	newline;
#end

#if($ticket.additionalSubType == 119 || $ticket.additionalSubType == 120)
	setAlignment center;
	#if($balance.account)
		beginBold;
		#if($balance.balance)
			text "CUENTA: #maskAcc($balance.account)";
		#else
			text "CUENTA: $balance.account";
		#end
		endBold;
	#end

	#if($balance.name)
		beginBold;
			text "CLIENTE: $balance.name";
		endBold;
	#end

	#if($balance.eicMessage)
		beginBold;
			text "#fmt("%-40.40s", ["$balance.eicMessage"])";
		endBold;
	#else
		#if($balance.balance)
			newline;
			beginBold;
				text "#fmtLftWthFill("SALDO  $",20," ")#fmtLftWthFill($balance.balance,14," ")";
			endBold;
				text "#fmtLftWthFill("SALDO VENCIDO  $",20," ")#fmtLftWthFill($balance.defeatedBalance,14," ")";
			#if($balance.isMiniPayment)
				text "#fmtLftWthFill("PAGO MENSUAL  $",20," ")#fmtLftWthFill($balance.minPayment,14," ")";
				text "#fmtLftWthFill("PAGO QUINCENAL  $",20," ")#fmtLftWthFill($balance.biWeekelyPayment,14," ")";
				#if($balance.nextPaymentDate != "")
					text "#fmtLftWthFill("FECHA DE PAGO  $",20," ")#fmtLftWthFill($balance.nextPaymentDate,14," ")";
					text "#fmtLftWthFill($balance.nextSecondPaymentDate,34," ")";
				#end
			#else
				text "#fmtLftWthFill("PAGO MINIMO  $",20," ")#fmtLftWthFill($balance.minPayment,14," ")";
				text "#fmtLftWthFill("PAGO MIN+MSI  $",20," ")#fmtLftWthFill($balance.paymentWithoutRefinance,14," ")";
				text "#fmtLftWthFill("PAGO N/GEN INT  $",20," ")#fmtLftWthFill($balance.minPaymentWithoutInterest,14," ")";
				beginBold;
					text "#fmtLftWthFill("LIMITE DE PAGO  :",20," ")#fmtLftWthFill($balance.lastPaymentDate,14," ")";

					#if("$!accountHasPIF" != "")
						#if($accountHasPIF)
							text "#fmtLftWthFill("ESTATUS PIF  :",20," ")#fmtLftWthFill("ACTIVO",14," ")";
						#else
							text "#fmtLftWthFill("ESTATUS PIF  :",20," ")#fmtLftWthFill("INACTIVO",14," ")";
						#end
					#end
				endBold;
			#end
			newline;
			text "#fmt("%-40.40s", ["*** SALDO INFORMATIVO Y NO INCLUYE ***"])";
			text "#fmt("%-40.40s", ["***** INTERESES DEL ULTIMO CICLO *****"])";
		#else
			#if((!$balance.printWalletBalance || !$balance.walletBalance) && $ticket.additionalSubType != 154)
				newline;
				beginBold;
					text "***FAVOR DE PASAR A CREDITO***";
				endBold;
			#end
		#end
	#end

	#if($balance.printWalletBalance && $balance.walletBalance)
		#if($balance.balance)
			text "#fmt("%-40.40s", ["------------------------------------"])";
		#end

		beginBold;
			setFontSize wideB;
			text "SALDO MONEDERO";
		endBold;
		setFontSize normal;

		newline;
		beginBold;
			#if($balance.walletBalance == 0)
				text "SALDO A FAVOR:  $  C E R O";
			#else
				text "SALDO A FAVOR:  $  #fmtDec($balance.walletBalance)";
			#end;
		endBold;
	#end;

	#if($balance.cashAvailable)
		newline;
		beginBold;
			text "EFECTIVO DISPONIBLE: $ #fmtDec($balance.cashAvailable)" ;
		endBold;
	#end
#end

## Tarjetas prepago
#foreach( $itemTicketLiverpoolData in $ticket.items )
    #if($itemTicketLiverpoolData.prepaidCardCode)
        text "#center("******    TARJETAS BLACKHAWK   ******")";
        text "UPC: $itemTicketLiverpoolData.prepaidCardCode.substring(0,12)    PRECIO:$  $itemTicketLiverpoolData.originalExtendedPrice";
        text "  $itemTicketLiverpoolData.prepaidCardCode.substring(12)   AUT:$itemTicketLiverpoolData.BhAuthorizationCode ";
		    #if($itemTicketLiverpoolData.prepaidCardOfLine)
            text "#center("F/L PARA ACTIVACIÓN EN 24 HORAS")";
        #end
		
        text "**************************************";
        newline;
    #end
#end

#if($ticket.additionalSubType == 127)
    newline;
	text "************************************";
	text "#fmt("CONFIRMACION : %-20s", "$ticket.confirmationId" )";
	text "#fmt("TELEFONO : %-20s", "$ticket.phoneNumber" )";
	text "************************************";
	newline;
	beginBold;
	#foreach( $descriptor in $ticket.descriptors )
		text "#center($descriptor)";
	#end
	endBold;
#end

#if($ticket.infoGugaData && $ticket.additionalSubType == 154)
   newline;
   beginBold;
   setAlignment left;
   text "#fmt("REFERENCIA: %-s", "$ticket.infoGugaData.reference")";
   text "#fmt("MONTO: $%-s", "$ticket.infoGugaData.amount")";
   text "#fmt("COMISIÓN: $%-s", "$ticket.infoGugaData.commission")";
   #if($ticket.infoGugaData.lastAuthorizationCodeGuga)
      text "#fmt("AUTORIZACIÓN: %-s", "$ticket.infoGugaData.lastAuthorizationCodeGuga")";
   #end
   #if($ticket.infoGugaData.idGuga)
      text "#fmt("ID: %-s", "$ticket.infoGugaData.idGuga")";
   #end
   #if($ticket.infoGugaData.leyendaGuga)
      text "$ticket.infoGugaData.leyendaGuga";
   #end
   newline;
   endBold;
   setAlignment center;
#end

#if($ticket.infoCare)
	#foreach ($datoIm in $ticket.infoCare)
		text "$datoIm";
	#end
#end

#if($ticket.bitmapWarrantyQR)
   	text "$ticket.valueWarrantyQR";
#end

#if ($ticket.additionalSubType == 101)
	#foreach ($item in $ticket.items)
		#if ($item.code == "1126509525")
			text "No aplica para cambios ni devoluciones";
		#end
	#end
#end

#if ($ticket.transactionType == 1)
	#foreach ($item in $ticket.items)
		#if ($item.supplier == "0000158529")
			#set ($socialReason = "Troquer Fashion S.A.P.I. de C.V.");
			#set ($rfc = "TFA1304188T3");
			#set ($email = "contacto@troquer.com.mx");
			#set ($phone = "55 5351 4488");
			#set ($imprimeCF = false);
		#elseif ($item.supplier == "0000160465")
			#set ($socialReason = "TRENDIER MEXICO, S.A. DE C.V.");
			#set ($rfc = "TME161021SL0");
			#set ($imprimeCF = false);
		#end
	#end
	setAlignment left;
	#if ($socialReason && $rfc && $email && $phone)				
		text "La presente venta es realizada por";
		text "$socialReason con RFC";
		text "$rfc, quien es responsable de esta";
		text "operación. Para generar la factura";
		text "comunícate por correo electrónico a";
		text "$email o al teléfono";
		text "$phone. Distribuidora Liverpool S.A.";
		text "de C.V. únicamente brinda la infraestructura";
		text "para la realización de esta operación";
	#elseif ($socialReason && $rfc)
		text "La presente venta es realizada por";
		text "$socialReason con RFC";
		text "$rfc, quien es responsable de esta";
		text "operación. Distribuidora Liverpool S.A. de";
		text "C.V. únicamente brinda la infraestructura";
		text "para la realización de esta operación";
	#end
	newline;
	setAlignment center;
#end

##Etiqueta de Marketplace
#if ($ticket.additionalSubType == 148 || $ticket.additionalSubType == 162)
	#set ($imprimeCF = false);
	#if ($ticket.marketPlaceData)
		#if ($ticket.marketPlaceData.mkpSL)
			setAlignment center;
            text "**SURTIDO Y ENTREGADO POR $ticket.marketPlaceData.sellerVendorName **";
            text "PROVEEDOR DE LIVERPOOL";
        #else
            setAlignment center;
            text "** VENDIDO POR $ticket.marketPlaceData.sellerVendorName **";
            text "PROVEEDOR DE LIVERPOOL";
        #end
	#end
#end

#if ($ticket.digitalTicket)
	text "Ticket digital";
	#else
	text "Ticket impreso";
#end
newline;

#if ($ticket.transactionType == 1 && $ticket.nonBillableWalletPrefix)
   text "NO FACTURABLE";
   newline;
#end

setCharsPerLine 38;
text "#prTot($totals.totalComputador,$totals.entregado,$totals.totalDiferencia,$totals.devolucion,$totals.valesPapel)";
##newline;

#if($ticket.ticketVoidFlag)
   text " * ANULADA *    #formatFecha($date) $time";
#else
   #if($ticket.additionalSubType != 122)
   	#if($ticket.voucher && $ticket.nroOrdenPaqueteria)
   		text "TIENDA:  $ticket.voucher #formatFecha($date)   $time";
   	#else
   		text " CLIENTE   #formatFecha($date)   $time";
   	#end
   #end
#end

#if	(!($ticket.ticketVoidFlag))
	#if	($ticket.transactionType == 1 && $ticket.additionalSubType != 109 && $ticket.additionalSubType != 127 && $ticket.additionalSubType != 107 && $ticket.additionalSubType != 110)
		#if	($ticket.cfBarcode && $imprimeCF == true)
			text "--------------------------------------";
			newline;
			text "Visita, factura y evalúanos en liverpool.com.mx";
			newline;
			text "CÓDIGO DE FACTURACIÓN";
			newline;
			text "Tiendas | Kioscos";
			newline;
			text "$ticket.cfBarcode";
		#end
		
		#if ($ticket.invoiced)
			newline;
			text "Facturación en proceso,";
			text "favor de validar en 72 hrs.";
		#end
		
	#end
	
	#if($ticket.transactionType == 1)
		#if($ticket.tentativeUsed && $ticket.tentativeAmount && !$ticket.isSuggestedAcceptedHipotecaVerde())
			setCharsPerLine 400;
		    newline;
			text "Por haber pagado esta compra con su Tarjeta de";
			text "Crédito Departamental o Liverpool Premium Card obtuvo";
			text "un beneficio adicional, ya incluido en esta transacción, de";
			setCharsPerLine 200;
			text "#center("$ $ticket.tentativeAmount ")";
		#end
		
		#if(!($ticket.tentativeUsed) && $ticket.tentativeAmount)
			setCharsPerLine 400;
		    newline;
			text "Si hubiera realizado su compra con su Tarjeta de";
			text "Crédito Departamental o Liverpool Premium Card habría";
			text "obtenido un beneficio adicional de";
			setCharsPerLine 200;
			text "#center("$ $ticket.tentativeAmount ")";
		#end
		
		#if ($ticket.isSuggestedAcceptedHipotecaVerde() && $ticket.creditNumberHipotecaVerde)
		   setCharsPerLine 400;
		   newline;
		   text "Esta compra está sujeta a los términos y";
		   text "condiciones del Programa de Hipoteca Verde,";
		   text "puedes consultarlas en nuestra página web";
		#end
	#end
#end