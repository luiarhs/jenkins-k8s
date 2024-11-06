#if($ticket.transactionType != 112 && ($ticket.additionalSubType == 107 || $ticket.additionalSubType == 138))
	#if($duplicateAg)
		cutPaperManual;

		#if($ticket.isJava8())
  		    setStation 0;
  		#else
  		    setStation 2;
  		#end
  	#end
#end

#if($printerType == "2" || $printerType == "0")
    setCharsPerLine 48;
#else
    setCharsPerLine 38;
#end
		
##the 'bitmap' command loads an image file, sends the image data to printer and then prints the image data
		  
##bitmap "#absPath("config/vouchers/templates/liverpool.png")" center;

lineSpacing 2;
#if(!$duplicate)

	#if($ticket.additionalSubType != 123)
        #if($printerType == "2")
            bitmap "0" center;
            lineSpacing 2;
            newline;
        #else
            bitmapPreStored 1 center;
        #end
	#end
#else
	text " ";
	setFontSize wideB;
	text "** C O P I A **";
#end

#if($ticket.additionalSubType != 138 )								 									 								 									 
	setFontSize normal;
	setAlignment left;
	#foreach( $descriptionLine in $descriptionData.addressDescriptions)
		text "$descriptionLine.description";
	#end
	
	setAlignment center;
	text "--------------------------------------";
	beginBold;
	text "$store.fullStoreName";
	endBold;
	setAlignment center;
	
	#if($store.storeAddressList)
		#foreach( $temp in $store.storeAddressList)
			text "$temp";
		#end
	#end
	   
	#if(!$store.storeAddressList)
		text "$store.storeAddress";
		text "$store.storeAddress2";
		text "Tel $store.telephone";
		text "C.P. $store.zipCode";
		text "$store.storeAddress4";	   				 
	#end
	text "--------------------------------------";	
#else	
	setFontSize normal;
	setAlignment center;
	beginBold;
		text "$store.fullStoreName";
	endBold;
	newline;
	#if($store.storeAddressList)		
		#set ($linea = 1)
		#foreach( $temp in $store.storeAddressList)
			#if( $linea == 2 )
				text "$temp";
			#end
			#set ($linea = ($linea + 1))
		#end
	#end
	newline;
#end

lineSpacing 1;
setFontSize wideB;
setAlignment center;
beginBold;

##if ($ticket.additionalSubType == 154)
  ##text "softline";
  ##text "oms";
  ##else
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
			#set ($finalTitle = " Venta BigTicket OMS");
		#elseif ($ticket.additionalSubType == 115)
			#set ($finalTitle = "Venta Mesa OMS");
		#elseif ($ticket.additionalSubType == 105)
			#set ($finalTitle = "Devolución Normal OMS");
		#elseif ($ticket.additionalSubType == 121)
			#set ($finalTitle = " Devolución Mesa OMS");
		#elseif ($ticket.additionalSubType == 149)
			#set ($finalTitle = "Devolución Marketplace OMS");
		#end
	#end
	text "$finalTitle";
##end

#if ($ticket.additionalSubType == 148 || $ticket.additionalSubType == 149 || $ticket.additionalSubType == 162)
  	text "MARKETPLACE";
#end

#if ($ticket.additionalSubType == 103)
  	text "DULCERIA";
#end

#if ($ticket.additionalSubType == 146 || $ticket.ventaOmnicanal == 5 || ($ticket.additionalSubType == 115 && $ticket.giftsPlanData && $ticket.giftsPlanData.typePlan == 5))
	text "OMNICANAL";
#end

#if ($ticket.additionalSubType == 131)
	setFontSize normal;
	newline;
	beginBold;
	text "SASTRERIA Y ALTERACIONES";
	endBold;
#end

endBold;
newline;

setAlignment left;
setFontSize normal;
text "#fmt("%-4s      %5s      %-4s     %4s", ["TERM","DOCTO","TDA","VEND"])";
text "#fmt("%03s       %4s       %4s    %8s", ["$ticket.terminalCode", "$ticket.docNumber", "$ticket.storeCode", "$ticket.userName"])";

newline;
text "#fmt("      ATENDIO: %-s", "$ticket.userNameDescription")";
##setAlignment center;

#if ($ticket.numeroOrdenVenta)
   newline;
   text "#fmt("NUMERO DE ORDEN  :%20s", $ticket.numeroOrdenVenta)";
#end

#if ($ticket.additionalSubType == 149)
	newline;
	#if($ticket.mrkPlaceNumeroPedido)
	  beginBold;
	  text "#fmt("No. PEDIDO: %-s", "$ticket.mrkPlaceNumeroPedido")";
	  endBold;
	  newline;
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

#if ($ticket.cdiPlanData)
	newline;
	setAlignment left;
	beginBold;
	text "SERVICIOS DE DISEÑO INTERIOR";
	text "#fmt("No. DE TARJETA CDI: %-s", "$ticket.cdiPlanData.numeroTarjetaCDI")";
	endBold;
#end

#if($ticket.nroComanda)
	newline;
    beginBold;
    setAlignment left;
	text "#fmt("No. DE COMANDA: %-s", "$ticket.nroComanda")";
	endBold;
	newline;
#end

#if($ticket.referenciaPedidoDeliveryFood)
	newline;
	text "#fmt("No. DE PEDIDO: %-s", "$ticket.referenciaPedidoDeliveryFood")";
#end

#if($ticket.proveedorDeliveryDescripcion)
	newline;
	text "#fmt("PROVEEDOR: %-s", "$ticket.proveedorDeliveryDescripcion")";
#end

#if($ticket.watchAccountNumber)
	newline;
	text "#fmt("No. DE ORDEN: %-s", "$ticket.watchAccountNumber")";
#end

#if ($ticket.warrantyReference)
	newline;
	beginBold;
	text "#fmt("REFERENCIA: %-s", "$ticket.warrantyReference")";
	endBold;
	newline;
	barcode ITF "$ticket.warrantyReference" 50 2 left none;
	newline;
#end

#if($ticket.additionalSubType != 130 && $ticket.additionalSubType != 110 && $ticket.additionalSubType != 143 && $ticket.additionalSubType != 144)
   #if($ticket.employeeAccount)
	  newline;
      beginBold;
      text "#fmt("CUENTA CASA: %-s","#maskAcc($ticket.employeeAccount)")";
      endBold;
	  newline;
   #end
#end

#if ($ticket.giftsPlanData)
	newline;
	beginBold;
	#if ($ticket.giftsPlanData.typeElectronicGift != -1)
		#if ($ticket.giftsPlanData.typeElectronicGift == 1 && !$ticket.giftsPlanData.typePlan == 5)
			text "*********  REGALO ABIERTO  *********";
		#end
		#if ($ticket.giftsPlanData.typeElectronicGift == 2)
			text "*********  JUEGO ABIERTO  **********";
		#end
		#if ($ticket.giftsPlanData.typeElectronicGift == 3 || $ticket.giftsPlanData.typeElectronicGift == 4)
			text "*****  CERTIFICADO CON PRECIO ******";
		#end
	#else
		#if ($ticket.transactionType != 2)
			text "#fmt("MESA DE REGALOS: %-s", "$ticket.giftsPlanData.typeEventDescription")";
		#end
	#end
	#if($ticket.giftsPlanData.cardNumber && $ticket.transactionType != 2)
		text "TARJETA: $ticket.giftsPlanData.cardNumber";
	#else
		text "No. DE EVENTO: #fmtLft($ticket.eventNumber,8)";
	#end
	endBold;
#end

#if($ticket.additionalSubType == 136 && !$ticket_is_duplicate)
	newline;
	setAlignment center;
	beginBold;
    text "MONEDERO ELECTRÓNICO INSTITUCIONAL";
	endBold;
	newline;
	setAlignment left;
#end

#if ($ticket.somsOrderData.somsAccountNumber)
	newline;
	setAlignment left;
	beginBold;
    #if ($ticket.additionalSubType == 102 || $ticket.additionalSubType == 115 || $ticket.additionalSubType == 123)
	  text "#fmt("No. ORDEN DE VENTA: %-s", "$ticket.somsOrderData.somsAccountNumber")";
	#end
	#if ($ticket.additionalSubType == 106 || $ticket.additionalSubType == 122 || $ticket.additionalSubType == 151)
	  text "#fmt("No. ORDEN DE DEVOLUCION: %-s", "$ticket.somsOrderData.somsAccountNumber")";
	#end
	endBold;
	newline;
#end

#if($ticket.opticaAccountNumber)
	newline;
    beginBold;
    setAlignment left;
	#if($ticket.additionalSubType == 128 || $ticket.additionalSubType == 129)
		text "No. ORDEN DE VENTA OPTICA: $ticket.opticaAccountNumber";
	#end
    endBold;
	newline;
#end

#if($ticket.numeroOrdenVenta)
	newline;
	beginBold;
	setAlignment left;
	#if($ticket.additionalSubType == 139 || $ticket.additionalSubType == 140)
		text "No. ORDEN DE VENTA LLANTAS: $ticket.numeroOrdenVenta";
	#end
	endBold;
	newline;
#end

#if ($ticket.poliza)
	newline;
	beginBold;
  	setAlignment left;
	text "No. DE POLIZA: $ticket.poliza";
	endBold;
	newline;
#end

#if ($ticket.polizaSeguro)
	newline;
	beginBold;
  	setAlignment left;
	text "No. DE POLIZA: $ticket.polizaSeguro";
	endBold;
#end

#if($ticket.transactionDolar && $ticket.additionalSubType != 119 && $ticket.additionalSubType != 120)
	newline;
	setCharsPerLine 44;
	setAlignment center;
	beginBold;
	text "ADQUISICION DE LOS SIGUIENTES ARTICULOS";
	text "Y/O SERVICIOS";
	endBold;
	setAlignment left;
	newline;
#end