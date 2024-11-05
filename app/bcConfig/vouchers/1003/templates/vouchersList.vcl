#foreach( $payment in $ticket.payments )
	#if($payment.tenderGsaId == 8 || $payment.tenderGsaId == 10 || $payment.tenderGsaId == 11)
		#if($ticket.transactionType != 2)
	    #parse( "1003/templates/voucher.vcl" )
	  #end
	#end
#end
