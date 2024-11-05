#if($ticket.transactionType == 1 || $ticket.transactionType == 2 || $ticket.transactionType == 5)
	#parse("1004/templates/ticket.vcl")
#end
#if($ticket.additionalSubType == 114)
    #parse("1004/templates/close.vcl" )
#end
#if(($ticket.additionalSubType == 7 || $ticket.additionalSubType == 157) && $ticket.transactionType != 112)
   #parse("1004/templates/tenderwithdrawal.vcl" )
#end
#if($ticket.transactionType == 112)
	#parse("1004/templates/cancel.vcl" )
#end
#if($ticket.isConsulting)
	#parse("1004/templates/balance.vcl" )
#end

#if(!$ticket.ticketVoidFlag)
    #parse("1004/templates/vouchersList.vcl")
#end