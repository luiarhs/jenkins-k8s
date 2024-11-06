#foreach( $item in $ticket.items )
    #if( $item.isGiftItem())
		#if(!$item.isVoid() && !$item.isVoided())
			#parse( "1003/templates/giftTicket.vcl" )
		#end
	#end  
#end
