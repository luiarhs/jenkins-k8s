##Valida si es Mesa de regalos (115) plan Paquetería (1) o plan Omnicanal (5), si es Paquetería (117), si es CDI de Paquetería (134) plan (1), si es Omnicanal (146), si es marketPlace (148, 162)
##Se agrega marketplace
#if (!$ticket.listaEuropea && ($ticket.nroOrdenPaqueteria || $ticket.cdiPlanData) && ($ticket.additionalSubType == 117 || ($ticket.additionalSubType == 134 && $ticket.cdiPlanData && $ticket.cdiPlanData.type == 1) || ($ticket.additionalSubType == 115 && $ticket.giftsPlanData && ($ticket.giftsPlanData.typePlan == 1 || $ticket.giftsPlanData.typePlan == 5))) || $ticket.additionalSubType == 146 || $ticket.additionalSubType == 148 || $ticket.additionalSubType == 162)
    #parse("1001/templates/shortHeader.vcl")

	#if($ticket.cdiPlanData)
		newline;
		beginBold;
		text "#fmt("NUMERO DE TARJETA CDI: %-s", "$ticket.cdiPlanData.numeroTarjetaCDI")";
		endBold;
	#end
	#if (!$ticket_is_duplicate && (!$ticket.listaEuropea && $ticket.nroOrdenPaqueteria && (($ticket.additionalSubType == 117 || $ticket.additionalSubType == 146 || $ticket.additionalSubType == 148 || $ticket.additionalSubType == 162) || ($ticket.additionalSubType == 134 && $ticket.cdiPlanData && $ticket.cdiPlanData.type == 1) || ($ticket.additionalSubType == 115 && $ticket.giftsPlanData && ($ticket.giftsPlanData.typePlan == 1 || $ticket.giftsPlanData.typePlan == 5)))))
		#if ($ticket.additionalSubType == 117 || $ticket.additionalSubType == 146 || $ticket.additionalSubType == 148 || $ticket.additionalSubType == 162 || ($ticket.additionalSubType == 115 && $ticket.giftsPlanData && ($ticket.giftsPlanData.typePlan == 1 || $ticket.giftsPlanData.typePlan == 5)))
			newline;
		#end
		beginBold;
		text "#fmt("No. PEDIDO: %-s", "$ticket.nroOrdenPaqueteria")";
		endBold;
	#end

	newline;
	#set ($packetTicket = true)
	#parse("1001/templates/paymentsList.vcl")
    newline;
	text "#convertToText($ticket.totalWithTrxDiscounts,38)";
	newline;
	beginBold;
	setAlignment center;
	text "**************************************";
	text "**ESTE DOCUMENTO NO AMPARA LA SALIDA**";
	text "**    DE MERCANCIA DEL ALMACEN      **";
	text "**************************************";
	newline;
	text "Gracias por su visita!";
	endBold;
	newline;

	#if($ticket.paqueteriaOffLine)
		setAlignment center;
		text "**************************************";
		text "**   ESTA REMISION SE DARA DE ALTA  **";
		text "**AUTOMATICAMENTE EL DIA DE MAÑANA  **";
		text "**************************************";
		newline;
	#end

   	text "TIENDA:  $ticket.trxVoucher #formatFecha($date)   $time";

	cutPaper 90;
    #parse("1001/templates/packetDetailTicket.vcl")

	#if($printerType == "2")
      setCharsPerLine 48;
    #else
      setCharsPerLine 38;
    #end
#end