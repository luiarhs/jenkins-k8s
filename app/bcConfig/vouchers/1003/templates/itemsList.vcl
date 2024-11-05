#foreach( $item in $ticket.items )
	#if(!$item.isVoid() && !$item.isVoided())
		#parse( "1003/templates/item.vcl" )
	#end
#end

#if($ticket.additionalSubType == 118 || $ticket.additionalSubType == 141)
		#if($notSecureAccount == "true")
	      text "CUENTA:          $monedero.walletAccount";
	   #else
      	text "CUENTA:          #maskAcc($monedero.walletAccount)";
      #end	
#end

#if($ticket.additionalSubType == 120)
   text "#fmt("%18s %17s", ["Num. segmento", "Importe"] )";
   #foreach( $segment in $accountPayment.segments)
      text "#fmt("      %-12s %17s", ["$segment.segment", "$segment.amount"] )";
	#end
#end
	


