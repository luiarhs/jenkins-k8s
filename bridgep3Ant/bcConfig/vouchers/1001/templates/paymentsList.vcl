#set ($isMonederoPrinted = "")
#set ($printInsideMonederoVale = false)
#set ($isDilisaLpc = false)
#if(!$ticket_is_duplicate)
   #foreach( $payment in $ticket.payments )
    #if($payment.amount != "0.00")
   	  #parse( "1001/templates/payment.vcl" )
   	  ##Validamos si tiene un pago con dilisa o LPC 
   	  #if($payment.tenderGsaId && $payment.tenderGsaId == 8 || $payment.tenderGsaId == 10)   	
     	#set ($isDilisaLpc = true)
     	#end
   	#end
   #end

   ## El cambio va luego de los pagos
   #parse("1001/templates/paymentsChange.vcl")
   	 
												   
   ## Originalmente esta linea se encuentra en ChangeLineLiverpool
   #if(!$packetTicket)
    #if($vale.vale)
         ## Si se genera un vale, ademas, es devolucion y se paga con dilisa o lpc no va dentro del ticket
         #if(($ticket.transactionType == 2 && $isDilisaLpc) || $ticket.transactionType == 1)
            text "#fmt("%18s $%17s", ["EMISION POR", "#fmtDecNoSign($vale.benefitedAmount)"] ) ";
         #else
            #set ($printInsideMonederoVale = true)
            text "#fmt("   EMISION POR  $%12.12s", "#fmtDec($vale.benefitedAmount)" ) ";
   		 newline;
            text "   CONTROL $vale.numControl";
   		 newline;
            text "#fmt("   VENCE    %-s", "$vale.vencimiento")";
   		 newline;
   		 #if(!$duplicate || ( !$ticket.additionalSubType == 138 && $duplicate) )
   	     	barcode ITF "$vale.barcode" 50 2 center none;
   	     	newline;
   		 #end
         #end
    #end
   #end

   ## Estado de cuenta del monedero
   #if($monedero.walletAccount)
		#if(!$monedero.vale)
   		 newline;
			 #if($notSecureAccount == "true" || $monedero.accountTypeMonedero == 1)
			      text "#center("-------  $monedero.walletAccount  -------")";
			  #else
				    text "#center("-------  #maskAcc($monedero.walletAccount)  -------")";
			  #end
   			#if($monedero.oldBalance)
   			  text "#fmt("%20s  %1s %14s", ["Saldo anterior ","$","#fmtDec($monedero.oldBalance)"])";
   			#end
   			#if($monedero.paymentAmount)
   			  text "#fmt("%20s  %1s %14s", ["Monto utilizado","$","#fmtDec($monedero.paymentAmount)"])";
   			#end
   			#if($monedero.benefitedAmount)
   			  text "#fmt("%20s  %1s %14s", ["Monto obtenido ","$","#fmtDec($monedero.benefitedAmount)"])";
   			#end
   			#if($monedero.newBalance && $monedero.oldBalance)
   			  text "#fmt("%20s  %1s %14s", ["Saldo actual   ","$","#fmtDec($monedero.newBalance)"])";
   			#end
   		#end
   #end
#end