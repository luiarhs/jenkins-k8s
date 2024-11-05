#if(!$ticket.warrantyReference || $ticket.transactionType == 2)
   #if(!$ticket.transactionType == 7 )
      setFontSize wideB;
   #end
#end
#if(($ticket.transactionType == 112 && !$epayment_is_duplicate) || $ticket.additionalSubType == 105 || $ticket.additionalSubType == 117 || $ticket.additionalSubType == 134)
   setFontSize wideB;
#end

setFontSize normal;
setCharsPerLine 38;
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

#if($ticket.transactionType == 112 || $ticket.transactionType == 2)
   newline;
   setAlignment center;
   #if ($ticket.transactionType == 2)
      setFontSize wideB;
   #end
   beginBold;
      text "$ticket.transactionTitle";
   endBold;
#end

#if ($ticket.additionalSubType == 148 || $ticket.additionalSubType == 149)
  setFontSize wideB;
	setAlignment center;
  beginBold;
  	 text "M P";
  endBold;
  newline;
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

  #if ($ticket.additionalSubType == 149)
  	#if($ticket.mrkPlaceNumeroPedido)
  		setAlignment center;
  		beginBold;
  			text "#fmt("%010s", "$ticket.mrkPlaceNumeroPedido")";
  		endBold;
  	#end
  #end

#if ($ticket.additionalSubType == 135)
  newline;
  setAlignment left;
	beginBold;
	  text "SERVICIOS DE DISEÑO INTERIOR";
	  text "#fmt("NUMERO DE TARJETA CDI: %-s", "$ticket.cdiPlanData.numeroTarjetaCDI")";
	endBold;

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
		  text "NUMERO DE EVENTO: #fmtLft($ticket.eventNumber,8)";
		endBold;
  #end
#end

#if( $ticket.warrantyReference && $ticket_is_duplicate )
  newline;
	beginBold;
		text "#fmt("REFERENCIA: %-s", "$ticket.warrantyReference")";
	endBold;
#end

#if($ticket.somsOrderData.somsAccountNumber)
  beginBold;
	#if($ticket.additionalSubType == 106 || $ticket.additionalSubType == 122 || $ticket.additionalSubType == 151)
    newline;
		text "#fmt("NO. ORDEN DE DEVOLUCION: %-s", "$ticket.somsOrderData.somsAccountNumber")";
	#end
  newline;
  endBold;
#end