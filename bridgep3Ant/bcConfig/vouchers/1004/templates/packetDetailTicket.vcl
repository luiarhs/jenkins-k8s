#if($ticket.additionalSubType == 117)

	###if($ticket.nroOrdenPaqueteria)
		newline;
		newline;
		#parse( "1004/templates/shortHeader.vcl")
		newline;
		newline;
		  text "#fmt("No. ORDEN PAQUETERIA: %-s", "$ticket.nroOrdenPaqueteria")";
		newline;
		newline;
		  #parse( "1004/templates/itemsList.vcl")
		newline;
		newline;
		  text "#fmt("TIPO DE PAGO: %-s", "$ticket.paymentType")";
		newline;
		newline;
		text "DESTINATARIO: ________________________";
		text "______________________________________";
		newline;
		text "E-MAIL: ______________________________";
		text "______________________________________";
		newline;
		text "DIRECCION: ___________________________";
		text "______________________________________";
		newline;
		text "COLONIA: ______________________________";
		text "______________________________________";
		newline;
		text "CP: __________________________________";
		newline;
		text "DEL O MUNICIPIO: _____________________";
		text "______________________________________";		
		newline;
		text "TELEFONO: ____________________________";
		newline;
		text "ENTRE QUE CALLES: ____________________";
		text "_______________________________________";
		text "_______________________________________";
		newline;
		text "NO. DE BULTOS: _______________________";
		newline;
		text "FECHA DE ENTREGA (EFU): ______________";
		newline;
		text "OBSERVACIONES: _______________________";
		text "______________________________________";
		text "______________________________________";
		newline;
		newline;
		  text "TIENDA     $date   $time";
		newline;
		newline;
	###end

#end
