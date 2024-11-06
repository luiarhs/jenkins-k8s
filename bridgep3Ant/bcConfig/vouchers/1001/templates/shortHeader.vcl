#if(!$ticket.warrantyReference || $ticket.transactionType == 2)
   #if(!$ticket.transactionType == 7 )
      setFontSize wideB;
   #end
#end
#if(($ticket.transactionType == 112 && !$epayment_is_duplicate) || $ticket.additionalSubType == 105 || $ticket.additionalSubType == 117 || $ticket.additionalSubType == 134)
   setFontSize wideB;
#end

setFontSize normal;
#if($printerType == "2")
    setCharsPerLine 48;
#else
    setCharsPerLine 38;
#end
#### No quitar este newline
newline;
###
beginBold;
	setAlignment center;				  
	#if($ticket.transactionType == 112)
    	text "$store.fullStoreName";
    #else
    	text "$store.storeName";
    #end
endBold;

newline;

text "$store.storeAddress";

#set ($finalTitle = "$ticket.transactionTitle");
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

#if($ticket.transactionType == 112 || $ticket.transactionType == 2)
   newline;
   setAlignment center;
   #if ($ticket.transactionType == 2)
      setFontSize wideB;
   #end
   beginBold;
   text "$finalTitle";
   endBold;
#end

#if ($ticket.additionalSubType == 148 || $ticket.additionalSubType == 149 || $ticket.additionalSubType == 162)
	setFontSize wideB;
	setAlignment center;
	beginBold;
    #if($ticket.additionalSubType == 148 || $ticket.additionalSubType == 162)
       newline;
       text "$finalTitle";
    #end
  	text "MARKETPLACE";
	endBold;
#end

setAlignment left;
setFontSize normal;
#if( $ticket.warrantyReference && $ticket_is_duplicate)
	setAlignment center;
	newline;
	newline;
	text "PROGRAMA DE GARANTIA EXTENDIDA";
	setAlignment left;
#end
newline;
text "#fmt("%-4s      %5s     %-4s     %4s", ["TERM","DOCTO","TDA","VEND"])";
text "#fmt("%03s       %4s      %4s    %8s", ["$ticket.terminalCode", "$ticket.docNumber", "$ticket.storeCode", "$ticket.userName"])";

newline;
text "#fmt("      ATENDIO: %-s", "$ticket.userNameDescription")";

#if ($ticket.numeroOrdenVenta)
   newline;
   text "#fmt( "NUMERO DE ORDEN  :%20s", $ticket.numeroOrdenVenta )";
   newline;
#end

#if ($ticket.additionalSubType == 149)
	#if($ticket.mrkPlaceNumeroPedido)
		newline;
		beginBold;
		text "#fmt("No. PEDIDO: %-s", "$ticket.mrkPlaceNumeroPedido")";
		endBold;
		newline;
 	#end
#end

#if ($ticket.additionalSubType == 135)
	newline;
	setAlignment left;
	beginBold;
	text "SERVICIOS DE DISEÑO INTERIOR";
	text "#fmt("No. DE TARJETA CDI: %-s", "$ticket.cdiPlanData.numeroTarjetaCDI")";
	endBold;
	newline;
#end

#if($ticket.giftsPlanData)
	newline;
	#if($ticket.giftsPlanData.typeElectronicGift == -1)
		#if ($ticket.giftsPlanData.typePlan != 1)
			#if ($ticket.transactionType != 2)
			   beginBold;
			   text "#fmt("MESA DE REGALOS: %-s", "$ticket.giftsPlanData.typeEventDescription")";
			   endBold;
			#end
		#end
	#end
	#if ($ticket.eventNumber)
		beginBold;
		text "No. DE EVENTO: #fmtLft($ticket.eventNumber,8)";
		endBold;
	#end
#end

#if( $ticket.warrantyReference && $ticket_is_duplicate )
	newline;
	beginBold;
	text "#fmt("REFERENCIA: %-s", "$ticket.warrantyReference")";
	endBold;
	newline;
#end

#if($ticket.somsOrderData.somsAccountNumber)
	newline;
	beginBold;
	#if($ticket.additionalSubType == 106 || $ticket.additionalSubType == 122 || $ticket.additionalSubType == 151)
		text "#fmt("No. ORDEN DE DEVOLUCION: %-s", "$ticket.somsOrderData.somsAccountNumber")";
		newline;
	#end
	endBold;
#end