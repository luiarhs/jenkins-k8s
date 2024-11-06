#if($ticket.additionalSubType == 117)
		newline;
        #parse( "1003/templates/shortHeader.vcl" )
		newline;
		setAlignment center;
		beginBold;
			text "#fmt("No. ORDEN PAQUETERIA: %-s", "$ticket.nroOrdenPaqueteria")";
		endBold;
		newline;
		newline;
           #parse( "1003/templates/paymentsList.vcl" )
        newline;
		newline;
		beginBold;
			text "**************************************";
			text "**ESTE DOCUMENTO NO AMPARA LA SALIDA**";
			text "**     MERCANCIA DEL ALMACEN        **";
			text "**************************************";
			text "Gracias por su visita!";
		endBold;
		newline;
		newline;
		newline;
  			text "TIENDA:    #formatFecha($date)   $time";
		newline;		
		newline;
		    #parse( "1003/templates/packetDetailTicket.vcl" )		
		newline;
#end
