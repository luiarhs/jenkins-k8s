	setAlignment center;
	setFontSize normal;
	beginBold;
		 newline;
	   text "VALE PARA COMPRA";
	   newline;
	endBold;
	
	text "#fmt("VALOR      $%1.12s", "#fmtDec($vale.benefitedAmount)")";
		     newline;
         text "   CONTROL  $vale.numControl";
		     newline;
         text "#fmt("   VENCE    %-s", "$vale.vencimiento")";
		     newline;
		     barcode ITF "$vale.barcode" 50 2 center none;
		     newline;
		
setFontSize normalB;
setCharsPerLine 44;
	text "**************************************";
	text "*ESTE DOCTO. ES ACEPTADO POR EL VALOR*";
	text "* QUE SE INDICA EN CUALQUIER ALMACEN *";
	text "*             LIVERPOOL              *";
	text "**************************************";
	newline;
	beginBold;
	  text "Gracias por su visita!";
	endBold;
	newline;
   	text " CLIENTE     #formatFecha($date)     $time";