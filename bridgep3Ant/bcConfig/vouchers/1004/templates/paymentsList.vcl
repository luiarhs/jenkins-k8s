#set ($isMonederoPrinted = "")
#foreach( $payment in $ticket.payments )
	#parse( "1004/templates/payment.vcl" )
#end

newline;
## Impresion de totales por pago con monedero
#foreach($payment in $ticket.payments)
	#if($payment.tenderGsaId == 2 && !$monedero.walletAccount && !$payment.additionalData.ad_isVale)
		#if($payment.additionalData.actual_balance != $payment.additionalData.refund_balance && $isMonederoPrinted=="")
			##newline;
			##text "#center("-------  $payment.additionalData.account  -------")";
			#if($notSecureAccount == "true")
               text "#center("-------  $payment.additionalData.account  -------")";
            #else
               text "#center("-------  #maskAcc($payment.additionalData.account)  -------")";
            #end
	    	#set ($isMonederoPrinted = "printed")
		   #if($payment.additionalData.old_balance)
			   text "#fmt("%20s  %1s %14s", ["Saldo anterior ","$","#fmtDec($payment.additionalData.old_balance)"])";
			#end
			#if($ticket.transactionType == 2)
			   text "#fmt("%20s  %1s %14s", ["Monto utilizado","$","0.00"])";
			#end
			#if($payment.amount && $ticket.transactionType != 2)
				text "#fmt("%20s  %1s %14s", ["Monto utilizado","$","#fmtDec($payment.amount)"])";
			#end
			#if($payment.additionalData.promo_balance)
				text "#fmt("%20s  %1s %14s", ["Monto obtenido ","$","#fmtDec($payment.additionalData.promo_balance)"])";
			#end
			#if($payment.additionalData.actual_balance)
				text "#fmt("%20s  %1s %14s", ["Saldo actual   ","$","#fmtDec($payment.additionalData.actual_balance)"])";
			#end
			newline;
		#end
	#end
#end

## El cambio va luego de los pagos
#parse( "1004/templates/paymentsChange.vcl" )

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

## Siempre despues del cambio comienza con una linea en blanco
newline;

#if($monedero.walletAccount)
   #if(!$monedero.vale)
      ##newline;
      text "#center("-------  $monedero.walletAccount  -------")";
       #if($monedero.oldBalance)
         text "#fmt("%20s  %1s %14s", ["Saldo anterior ","$","#fmtDec($monedero.oldBalance)"])";
       #end
	   #if($monedero.paymentAmount)
	   	text "#fmt("%20s  %1s %14s", ["Monto utilizado","$","#fmtDec($monedero.paymentAmount)"])";
	   #end
	   #if($monedero.benefitedAmount)
	   	text "#fmt("%20s  %1s %14s", ["Monto obtenido ","$","#fmtDec($monedero.benefitedAmount)"])";
	   #end
	   #if($monedero.newBalance)
	   	text "#fmt("%20s  %1s %14s", ["Saldo actual   ","$","#fmtDec($monedero.newBalance)"])";
	   #end
	   newline;
   #end
#end