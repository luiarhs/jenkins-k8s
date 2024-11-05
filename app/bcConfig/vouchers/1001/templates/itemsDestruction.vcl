###Validamos si es una devolucion de mercancía para destrucción
#if($ticket.refundCauseJournal == "SERVICIO")
    #foreach( $item in $ticket.items )
        #if(!$item.isVoid() && !$item.isVoided())
			#foreach($i in [1..$item.qty.intValue()])
			    #parse( "1001/templates/itemDestruction.vcl" )
			#end
		#end
    #end
#end