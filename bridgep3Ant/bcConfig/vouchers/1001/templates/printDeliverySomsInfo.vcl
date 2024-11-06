#if($ticket.additionalSubType == 102 || $ticket.additionalSubType == 115)
	#if($ticket.somsOrderData.deliveryNumber > 0 && $ticket.somsOrderData.deliveryType && $ticket.somsOrderData.deliveryType == 1)

		#parse( "1001/templates/shortHeader.vcl" )		
		beginBold;
			setAlignment center;
			text "A SU ARRIBO";
		endBold;

		newline;
		setAlignment left;
		text "**************************************";
		text "En esta fecha hago compra del producto";
		text "especificado en este documento el cual";
		text "se me informó que es bajo pedido y    ";
		text "acepto entrar en fila de espera con el";
		text "no. $ticket.somsOrderData.deliveryNumber con tiempo máximo de entrega";
		text "de 90 días hábiles.                   ";
		text "Firmé copia del presente.             ";
		text "Acepto y recibí copia del presente.   ";
		text "**************************************";		
		newline;
		newline;
		newline;
		setAlignment center;
		text "_____________________________";
		text "FIRMA";
		newline;
		text "TIENDA:  $ticket.trxVoucher #formatFecha($date)   $time";


      cutPaper 90;
      setFontSize normal;
	#end
#end