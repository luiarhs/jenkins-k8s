#if($ticket.transactionType == 112)
    #set ($sign = "-1")
#else
    #set ($sign = "1")
#end

#if($payment.bankDescription)
	text "#fmt("%s             %1s%s", ["$payment.bankDescription","$","#fmtDec($payment.amount, $sign)"])";
#else
	text "#fmt("%s             %1s%s", ["$payment.description","$","#fmtDec($payment.amount, $sign)"])";
#end

#if($payment.inputType)
   text "$payment.inputType";
#end

#if($payment.additionalData.account)
	#if($notSecureAccount == "true")
      text "CUENTA: $payment.additionalData.account"; 
   #else
      text "CUENTA: #maskAcc($payment.additionalData.account)";
   #end		
#end

#if($payment.nombre)
   text "NOMBRE: $payment.nombre";
#end

#if($payment.bankAfiliation)
   text"AFILIACIÓN: $payment.bankAfiliation";
#end

#if($payment.criptograma)
   text "ARQC: $payment.criptograma";
#end

#if($payment.aid)
   text "AID: $payment.aid";
#end

newline;
