setAlignment center;
setCharsPerLine 200;

#if($ticket.additionalSubType != 123)
	newline;
	text "--------------------------------------";
#end

#if($ticket.trainingModeFlag)
   text "#centerTC("  MODO ENTRENAMIENTO  ", 38, "*")";
   newline;
#else
   text "#center($store.fullStoreName)";
   newline;
   text "#center($store.storeAddress)";
   newline;
#end

#set ($finalTitle = "$ticket.transactionTitle")
#if($ticket.trxOms)
	#if($ticket.employeeTransaction)
		#if($ticket.additionalSubType == 146 || $ticket.additionalSubType == 102 || $ticket.additionalSubType == 115)
			#set ($finalTitle = "VENTA CASA")
		#elseif($ticket.additionalSubType == 105 || $ticket.additionalSubType == 121 || $ticket.additionalSubType == 149)
			#set ($finalTitle = "DEV. CASA");
		#end
	#elseif ($ticket.additionalSubType == 146)
		#set ($finalTitle = "Venta SoftLine OMS");
	#elseif ($ticket.additionalSubType == 102)
		#set ($finalTitle = "Venta BigTicket OMS");
	#elseif ($ticket.additionalSubType == 115)
		#set ($finalTitle = "Venta Mesa OMS");
	#elseif ($ticket.additionalSubType == 105)
		#set ($finalTitle = "Devolución Normal OMS");
	#elseif ($ticket.additionalSubType == 121)
		#set ($finalTitle = "Devolución Mesa OMS");
	#elseif ($ticket.additionalSubType == 149)
		#set ($finalTitle = "Devolución Marketplace OMS");
	#end
#end
text "#center($finalTitle)";

#if ($ticket.additionalSubType == 148 || $ticket.additionalSubType == 149 || $ticket.additionalSubType == 162)
	#set($titleMP = "MARKETPLACE")
  	text "#center($titleMP)";
#end

#if ($ticket.additionalSubType == 103)
	#set($titleMP = "DULCERIA")
  	text "#center($titleMP)";
#end

#if ($ticket.additionalSubType == 146)
	#set($titleMP = "OMNICANAL")
  	text "#center($titleMP)";
#end

newline;

text "#fmt("%-8.8s  %-6.6s  %6.6s  %8.8s", ["TERM","DOCTO","TDA","VEND"])";
text "#fmt("%-8.8s  %-6.6s  %7.7s  %10.10s", ["$ticket.terminalCode", "$ticket.docNumber", "$ticket.storeCode", "$ticket.userName"])";
newline;

text "#fmt("      ATENDIO: %-s", "$ticket.userNameDescription")";
newline;

#if($ticket.numeroOrdenVenta)
   text "#fmt("NO. ORDEN: %-s", $ticket.numeroOrdenVenta)";
#end
newline;

#if ($ticket.additionalSubType == 149)
	#if($ticket.mrkPlaceNumeroPedido)
	  text "#fmt("No. PEDIDO: %-s", "$ticket.mrkPlaceNumeroPedido")";
    newline;
 	#end
#end

#if($ticket.remisionVad)
    text "#fmt("No. PEDIDO: %-s", "$ticket.remisionVad")";
    newline;
#end

#if($ticket.additionalSubType == 119 || $ticket.additionalSubType == 120 || $ticket.additionalSubType == 143 || $ticket.additionalSubType == 144)
	#if($accountPayment.tracePagos)
		newline;
		text "************************************";
   	#if($notSecureAccount == "true")
   		text "Cuenta: $accountPayment.account";
      #else
   		text "Cuenta: #maskAcc($accountPayment.account)";
      #end		
		#if($accountPayment.paymentInputType)
			text "Medio:$accountPayment.paymentInputType";
		#end
		text "************************************";
	#end
#end

#if (!$ticket_is_duplicate)
   #if($ticket.additionalSubType == 118 || $ticket.additionalSubType == 136 || $ticket.additionalSubType == 141 )
      newline;
      #if($notSecureAccount == "true")
   	   text "CUENTA: #maskAcc($monedero.walletAccount)";
      #else
       text "CUENTA: $monedero.walletAccount";
      #end
   #end

   ##Venta Institucional
   #if($ticket.additionalSubType == 136)
      newline;
      text "No. CONVENIO:   $service.serviceKey";
   #end
#end

#if($ticket.cdiPlanData)
  setAlignment left;
  beginBold;
	text "SERVICIOS DE DISEÑO INTERIOR";	  
	text "#fmt("NUMERO DE TARJETA CDI: %-s", "$ticket.cdiPlanData.numeroTarjetaCDI")";
  endBold;
  newline;
#end

#if($ticket.nroComanda)
   text "#fmt("NUMERO DE COMANDA: %-s", "$ticket.nroComanda")";
	newline;
#end

#if($ticket.referenciaPedidoDeliveryFood)
   text "#fmt("No. DE PEDIDO: %-s", "$ticket.referenciaPedidoDeliveryFood")";
	newline;
#end

#if($ticket.proveedorDeliveryDescripcion)
   text "#fmt("PROVEEDOR: %-s", "$ticket.proveedorDeliveryDescripcion")";
	newline;
#end

#if($ticket.watchAccountNumber)
   text "#fmt("Nro. de Orden: %-s", "$ticket.watchAccountNumber")";
	newline;
#end

#if( $ticket.warrantyReference )
	text "#fmt("REFERENCIA: %-s", "$ticket.warrantyReference")";
	newline;
#end

#if($ticket.additionalSubType != 130 && $ticket.additionalSubType != 110 && $ticket.additionalSubType != 143 && $ticket.additionalSubType != 144)
   #if($ticket.employeeAccount)
      text "#fmt("CUENTA CASA: %-s", "#maskAcc($ticket.employeeAccount)")";
      newline;
   #end
#end

#if($ticket.supervisorNumber)
   text "#fmt("%-12.12s  %-6.6s  %4.4s  %8.8s",["AUTORIZACION  ",$ticket.supervisorNumber,"VEND ",$ticket.supervisorName])";
#end

#if ($ticket.giftsPlanData)
   #if (!($ticket.giftsPlanData.eventOrganizer) && $ticket.transactionType != 2 && $ticket.additionalSubType != 102)
      text "$ticket.giftsPlanData.fatherSurname:$ticket.giftsPlanData.motherSurname:$ticket.giftsPlanData.name";
   #end
   #if ($ticket.giftsPlanData.typeElectronicGift != -1)
		#if ($ticket.giftsPlanData.typeElectronicGift == 1 && !$ticket.giftsPlanData.typePlan == 5)
			beginBold;
			text "*********  REGALO ABIERTO  *********";
			endBold;
		#end
		#if ($ticket.giftsPlanData.typeElectronicGift == 2)
			text "*********  JUEGO ABIERTO  **********";
		#end
		#if ($ticket.giftsPlanData.typeElectronicGift == 3 || $ticket.giftsPlanData.typeElectronicGift == 4)
			text "*****  CERTIFICADO CON PRECIO ******";
		#end
   #else
      #if($ticket.transactionType != 2)
      	beginBold;
			  text "#fmt("MESA DE REGALOS: %-s", "$ticket.giftsPlanData.typeEventDescription")";
			  endBold;
		  #else
			  beginBold;
			  text "MESA DE REGALOS:";
			  endBold;
		  #end
   #end
   #if($ticket.eventNumber)
   		beginBold;
		  text "#fmt("NUMERO DE EVENTO:      %-s", "#fmtLft($ticket.eventNumber,8)")";
		  endBold;
   #end
   #if($ticket.giftsPlanData.cardNumber && $ticket.transactionType != 2)
   			text "TARJETA:      $ticket.giftsPlanData.cardNumber";
   #end
   newline;
#end

#if ($ticket.somsOrderData.somsAccountNumber)
	newline;
	#if ($ticket.additionalSubType == 102 || $ticket.additionalSubType == 115 || $ticket.additionalSubType == 123)
		text "#fmt("NO. ORDEN DE VENTA: %-s", "$ticket.somsOrderData.somsAccountNumber")";
	#end
	#if ($ticket.additionalSubType == 106 || $ticket.additionalSubType == 122 || $ticket.additionalSubType == 151)
		text "#fmt("NO. ORDEN DE DEVOLUCION: %-s", "$ticket.somsOrderData.somsAccountNumber")";
	#end
	newline;
#end

#if($ticket.opticaAccountNumber)
    beginBold;
    setAlignment center;
	#if($ticket.additionalSubType == 128 || $ticket.additionalSubType == 129)
		text "ORDEN VENTA OPTICA: $ticket.opticaAccountNumber";
	#end
    newline;
    endBold;
#end		
#if($ticket.numeroOrdenVenta)
  beginBold;
  setAlignment center;
	#if($ticket.additionalSubType == 139 || $ticket.additionalSubType == 140)
		text "ORDEN VENTA LLANTAS: $ticket.numeroOrdenVenta";
	#end
  newline;
  endBold;
#end

#if ($ticket.poliza)
	newline;
	text "No. DE POLIZA: $ticket.poliza";
	newline;
#end

#if ($ticket.polizaSeguro)
	newline;
	text "No. DE POLIZA: $ticket.polizaSeguro";
	newline;
#end

#if($ticket.transactionDolar)
	text "ADQUISICION DE LOS SIGUIENTES ARTICULOS";
	text "Y/O SERVICIOS";
	newline;
#end

#if($ticket.additionalSubType == 136)
    text "NUM CONVENIO:          $service.serviceReferenceNumber";
#end