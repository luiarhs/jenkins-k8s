#if ($imprimeTicket)
	#foreach( $payment in $ticket.payments )
	   #if($payment.tenderGsaId == 8 || $payment.tenderGsaId == 10 || $payment.tenderGsaId == 11 || $payment.tenderGsaId == 19 || $payment.tenderGsaId == 20)
		   #if($ticket.transactionType != 2 && $ticket.transactionType != 112 && !$payment.additionalData.creditNumberHipotecaVerde)
		        #if(!$payment.isNoPrint)
			        #parse( "1001/templates/voucher.vcl" )
			    #end
	       #end
	   #elseif($ticket.transactionType != 2 && $payment.tenderGsaId == 2 && ($payment.additionalData.accountType == 1 || $payment.additionalData.accountType == 2))
			#if(!$payment.isNoPrint)
			    #parse( "1001/templates/voucherLPC.vcl" )
			#end
	   #end
	#end
#end
