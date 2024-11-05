#if( $ticket.applySnackBar )

	setFontSize highWide;
	setAlignment center;
	beginBold;
		text "SNACK BAR";
	endBold;
	newline;
	
	setFontSize normal;	
	beginBold;	
		text "$store.storeName";
	endBold;
	
	text "$store.storeAddress";
	
	newline;
	text "CLIENTE:______________________________";			
	newline;
	
	setFontSize wideB;	  
	beginBold;
	  text "$ticket.transactionTitle";
	endBold;

	newline;	 
	setAlignment left;
	setFontSize normal;
	text "#fmt("%-4s      %5s     %-4s     %4s", ["TERM","DOCTO","TDA","VEND"])";
	text "#fmt("%03s       %4s      %4s    %8s", ["$ticket.terminalCode", "$ticket.docNumber", "$ticket.storeCode", "$ticket.userName"])";
	newline;
	  text "#fmt("      ATENDIO: %-s", "$ticket.userNameDescription")";
	newline;
	
	#foreach( $item in $ticket.items )
		#if(!$item.isVoid() && !$item.isVoided())
			#if($item.snackBar)
				#parse( "1001/templates/item.vcl" )
			#end
		#end
	#end
	newline;
	beginBold;
	   setCharsPerLine 44;
      text "* ESTE TICKET NO AVALA SALIDA DE MERCANCIA *";
      setCharsPerLine 38;
	endBold;
	
	newline;
	setAlignment center;
	text "#formatFecha($date)    $time";
	cutPaper 90;
#end