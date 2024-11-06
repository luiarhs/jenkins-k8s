
#if	($ticket.warrantyReference)
   #if ($printerType != "7")
	  cutPaperManual;
   #end
   setStation 2;

   #set ($ticket_is_duplicate = true)
	#parse( "1001/templates/shortHeader.vcl" )
	newline;
	#foreach( $item in $ticket.items)
	
	  #if ($item.itemWarranty)
	  		text "#fmt("%-20.20s  %-5.5s  %-5.5s", ["$item.parentItemDescription", "SECC", "$item.parentItemMerchandiseHierarchy"] )";		
			text "#fmt("%-15.15s", ["$item.parentItemCode"] )";
		
	    #if ($ticket.additionalSubType  == 113 )
		    text "FECHA DE COMPRA DE ART.#formatFecha($ticket.warrantyDate)";
		 #end
		    
	    newline;
			text "#fmt("%-20.20s  %-5.5s  %-5.5s", ["$item.description", "SECC", "$item.merchandiseHierarchy"] )";
			
		#if($item.qty == "1.00")
			text "#fmt("%-10.10s                %11.11s%1s", ["$item.code","#fmtDec($item.originalExtendedPrice $sign)","$letter"] )";
		#else
			text "#fmt("%010s %14.14s %11.11s%1s", ["$item.code","#fmtDecNoSign($item.actualUnitPrice)*#fmtDecNoSign($item.qty)", "#fmtDec($item.originalExtendedPrice $sign)","$letter"])";		
		#end	
	    	    
	    #if ($ticket.additionalSubType  == 113 )	       
	       text "FECHA DE COMPRA DE ART.#formatFecha($date)";
	    #end
	       
	    newline;
	    	
	  #end

	#end

  text "FECHA DE COMPRA GTIA.#formatFecha($date)";
	
  #if (!$ticket.printFranqueo)
     cutPaper 90;
  #else
     cutPaperManual;
  #end

  #if($printerType == "7")
  	cutPaperManual;
  #end
#end