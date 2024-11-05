#if ($imprimeTicket)
	#if($ticket.transactionType == 2)
	
	   #parse( "1001/templates/shortHeader.vcl" )
	
	   #parse( "1001/templates/itemsList.vcl" )
	
	   #parse( "1001/templates/totalDuplicate.vcl" )
	
	   #parse( "1001/templates/duplicate.vcl" )
	   
	   #parse( "1001/templates/itemsMarketplace.vcl" )
	   
	   #parse( "1001/templates/itemsDestruction.vcl" )
	
	#end
#end

