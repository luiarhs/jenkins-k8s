###Validamos si es una devolucion de Marketplace
#if($ticket.additionalSubType == 149)
	#if($ticket.marketPlaceData)
	    #foreach( $item in $ticket.items )
            #if(!$item.isVoid() && !$item.isVoided())
				#foreach($i in [1..$item.qty.intValue()])
				    #parse( "1001/templates/itemMarketPlace.vcl" )
				#end
		    #end
	    #end
	#end
#end