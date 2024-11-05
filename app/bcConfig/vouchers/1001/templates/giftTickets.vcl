#if($ticket.transactionType == 1)
	#foreach( $item in $ticket.items )
	    #if( $item.isGiftItem())
				#if(!$item.isVoid() && !$item.isVoided())
					#foreach($i in [1..$item.qty.intValue()])
					    #parse( "1001/templates/giftTicket.vcl" )
		      #end
				#end
		  #end  
	#end
#end