#if( $ticket.warrantyReference )
	#parse( "1003/templates/shortHeader.vcl" )
	newline;
	newline;
	#foreach( $item in $ticket.items)
	
	  #if ($item.itemWarranty)
	  		text "#fmt("%-10.10s  %-5.5s  %-5.5s", ["$item.parentItemDescription", "SECC", "$item.parentItemMerchandiseHierarchy"] )";		
			text "#fmt("%-15.15s", ["$item.parentItemCode"] )";
	    
	    #if ($ticket.additionalSubType  == 113 )
		    text "FECHA DE COMPRA DE ART.:  #formatFecha($ticket.warrantyDate)";
		#end
		    
	    newline;
	    
	    text "#fmt("%-10.10s  %-5.5s  %-5.5s", ["$item.description", "SECC", "$item.merchandiseHierarchy"] )";
	    text "#fmt("%-15.15s          %10.10s", ["$item.code", "$item.originalExtendedPrice"] )";
	    	    
	    #if ($ticket.additionalSubType  == 113 )	       
	       text "FECHA DE COMPRA DE ART.   #formatFecha($date)";
	    #end
	       
	    newline;
	    	
	  #end

	#end	
	newline;
	newline;
	text "FECHA DE COMPRA GTIA.   #formatFecha($date)";
	newline;
	newline;
	newline;
	newline;
	newline;
#end