#if($ticket.additionalSubType == 102)
	setAlignment center;
	#if($ticket.somsOrderData.deliveryNumber > 0 && $ticket.somsOrderData.deliveryType && $ticket.somsOrderData.deliveryType == 1)
		#parse( "1003/templates/shortHeader.vcl" )
		newline;
		newline;
		beginBold;
			text "A SU ARRIBO";
		endBold;
		newline;
		newline;
		text "**************************************";
		text "En   esta   fecha   hago   pedido  del";
		text "producto  especificado  en  este mismo";
		text "documento el cual se me  informo   que";
		text "esta  agotado  por el momento y acepto";
		text "entrar en fila de espera con el no. $ticket.somsOrderData.deliveryNumber,";
		text "con tiempo aproximado de ____ dias.";
		newline;
		newline;
		text "**************************************";
		newline;
		newline;
		newline;
		text "_____________________________";
		text "FIRMA";
		newline;
		newline;
		text "TIENDA:  $ticket.trxVoucher #formatFecha($date)   $time";
		newline;
		newline;
		newline;
		newline;
		newline;
	#end
#end