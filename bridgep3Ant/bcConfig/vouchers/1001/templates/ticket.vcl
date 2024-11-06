#if ($imprimeTicket)
	#parse( "1001/templates/header.vcl" )
	
	#parse( "1001/templates/itemsList.vcl" )
	
	#parse( "1001/templates/total.vcl" )
	
	#parse( "1001/templates/paymentsList.vcl" )
	
	#parse( "1001/templates/footer.vcl" )
#end
