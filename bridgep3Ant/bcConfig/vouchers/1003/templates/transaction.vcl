#if($ticket.transactionType == 1 || $ticket.transactionType == 2 || $ticket.transactionType == 5)

	#parse("1003/templates/ticket.vcl")

#end
#if($ticket.additionalSubType == 114)
    
    #parse("1003/templates/close.vcl" )
    
    #parse("1003/templates/closeVoucher.vcl" )
    
#end
#if($ticket.additionalSubType == 7 && $ticket.transactionType != 112)
   
   #parse("1003/templates/tenderwithdrawal.vcl" )
   
   #parse("1003/templates/tenderwithdrawalDuplicate.vcl" )
   
#end
#if($ticket.transactionType == 112)

	#parse("1003/templates/cancel.vcl" )
#end  

