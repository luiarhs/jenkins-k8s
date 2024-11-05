
#parse( "1004/templates/shortHeader.vcl" )

#if($ticket.ticketVoidFlag)
   newline;
   newline;
   newline;

   text " * ANULADA *    #formatFecha($date) $time";
#else
   text "NO. ORIGINAL DE TERMINAL            #fmtLft($ticket.terminalCode, 3)";
   text "NO. TRANSACCION CANCELADA          #fmtLft($ticket.originalTicketNumber, 4)";
   text "#fmt("%-24s%16s", [ "MONTO TRANSAC. CANCEL" , "$ #fmtDec($ticket.total)" ] ) ";
   newline;
   
   #set ($isReturn = "#isTrxType($ticket.additionalSubType, 2)")
   
   
   #foreach($payment in $ticket.payments)
      #if($payment.tenderGsaId == 10)
         #if($isReturn == "false" )
            #parse( "1004/templates/epayment.vcl" )
         #end
      #else
      	#set ($msgNumber = "$payment.tenderGsaId")
         #if($payment.tenderGsaId == 8 && $isReturn == "true" )
            #set ($msgNumber = "38")
         #end
         
         #if($payment.tenderGsaId == 11 && $isReturn  == "true" )
            #set ($msgNumber = "39")
         #end
         #if($msgNumber && $payment.additionalData.authorization_code && $payment.additionalData.account )
            text "#fmt("*%02s*      %08s*%-16s", ["$msgNumber", "$payment.additionalData.authorization_code", "$payment.additionalData.account"])";
         #end
      #end
   #end
   
   #if($ticket.additionalSubType == 7 || $ticket.additionalSubType == 157)
       text "#fmt("%23.23s  %1.1s%10.10s", ["TOTAL RETIRADO ACTUAL", "$", "#fmtDec($totals.entregado)"])";
   #end
   
   setCharsPerLine 38;

   text "#prTot($totals.totalComputador,$totals.entregado,$totals.totalDiferencia,$totals.devolucion,$totals.valesPapel)";
   text "TIENDA  $ticket.trxVoucher #formatFecha($date)   $time";
#end