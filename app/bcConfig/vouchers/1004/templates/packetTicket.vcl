#if($ticket.additionalSubType == 117)
	
	###if($ticket.nroOrdenPaqueteria)
	    #parse( "1004/templates/shortHeader.vcl" )
		newline;
		newline;
			text "#fmt("No. ORDEN PAQUETERIA: %-s", "$ticket.nroOrdenPaqueteria")";
		newline;
		newline;
		   #parse( "1004/templates/paymentsList.vcl" )
		newline;
		newline;
			text "**************************************";
			text "**ESTE DOCUMENTO NO AMPARA LA SALIDA**";
			text "**     MERCANCIA DEL ALMACEN        **";
			text "**************************************";
			text "Gracias por su visita!";
		newline;
		newline;
		newline;
		text "TIENDA     $date   $time";
		newline;		
		newline;
			#parse( "1004/templates/packetDetailTicket.vcl" )
		newline;
	###end
	
#end
