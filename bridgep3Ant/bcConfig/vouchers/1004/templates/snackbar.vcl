#if( $ticket.applySnackBar )
	setFontSize wideB;
	beginBold;
		text "SNACK BAR";
	endBold;
	setFontSize normal;
	newline;
	
	#parse( "1004/templates/shortHeader.vcl" )
	
	newline;
	text "CLIENTE:______________________________";
	newline;
	
	setFontSize wideB;
	beginBold;
   		text "$ticket.transactionTitle";
	endBold;

	setAlignment left;
	setFontSize normal;
	newline;
	text "#fmt("  %-8.8s  %-4.4s  %8.8s  %8.8s", ["TERM","DOCTO","TDA","VEND"])";
	text "#fmt("  %-8.8s  %-5.5s  %8.8s  %8.8s", ["$ticket.terminalCode", "$ticket.docNumber", "$ticket.storeCode", "$ticket.userName"])";
	
	newline;
	newline;
  		text "#fmt("      ATENDIO: %-s", "$ticket.userNameDescription")";
	newline;
	
	#foreach( $item in $ticket.items )
		#if(!$item.isVoid() && !$item.isVoided())
			#if($item.snackBar)
				#parse( "1004/templates/item.vcl" )
			#end
		#end
	#end
		
	newline;
	beginBold;
   		text "* ESTE TICKET NO AVALA SALIDA DE MERCANCIA *";
	endBold;
	
	newline;
	text "CLIENTE   #formatFecha($date)   $time";
	newline;
#end