#foreach( $payment in $ticket.payments )
	#parse( "1003/templates/payment.vcl" )
#end

#if($monedero.walletAccount)
  #if(!$monedero.vale)
    newline;
	newline;
    text "-------    $monedero.walletAccount    --------";
    #if($monedero.oldBalance)
		text "#fmt("%16.16s  %1.1s  %12.12s", ["Saldo anterior :","$","#fmtDec($monedero.oldBalance)"])";
	#end
	#if($monedero.paymentAmount)
		text "#fmt("%16.16s  %1.1s  %12.12s", ["Monto utilizado:","$","#fmtDec($monedero.paymentAmount)"])";
	#end
	#if($monedero.benefitedAmount)
		text "#fmt("%16.16s  %1.1s  %12.12s", ["Monto obtenido :","$","#fmtDec($monedero.benefitedAmount)"])";
	#end
	#if($monedero.newBalance)
		text "#fmt("%16.16s  %1.1s  %12.12s", ["Saldo actual   :","$","#fmtDec($monedero.newBalance)"])";
	#end
  #else
    text "#fmt("   EMISION POR  $%12.12s", "#fmtDec($monedero.benefitedAmount)" ) ";	    
  #end	
#end

#foreach($payment in $ticket.payments)
    #if($payment.tenderGsaId == 2 && !$monedero.walletAccount && !$payment.additionalData.ad_isVale)
		#if($payment.tenderGsaId == 2 && !$monedero.walletAccount)
			#if($payment.additionalData.actual_balance != $payment.additionalData.refund_balance)
			    newline;
				newline;
			    text "-------    $payment.additionalData.account    --------";
			    #if($payment.additionalData.old_balance)
					text "#fmt("%16.16s  %1.1s  %12.12s", ["Saldo anterior :","$","#fmtDec($payment.additionalData.old_balance)"])";
				#end
				#if($ticket.transactionType == 2)
				text "#fmt("%16.16s  %1.1s  %12.12s", ["Monto utilizado:","$","0.00"])";
				#end
				#if($payment.amount && $ticket.transactionType != 2)
					text "#fmt("%16.16s  %1.1s  %12.12s", ["Monto utilizado:","$","#fmtDec($payment.amount)"])";
				#end
				#if($payment.additionalData.promo_balance)
					text "#fmt("%16.16s  %1.1s  %12.12s", ["Monto obtenido :","$","#fmtDec($payment.additionalData.promo_balance)"])";
				#end
				#if($payment.additionalData.actual_balance)
					text "#fmt("%16.16s  %1.1s  %12.12s", ["Saldo actual   :","$","#fmtDec($payment.additionalData.actual_balance)"])";
				#end
			#end
		#end
	#end
	#if($payment.additionalData.ad_isVale)
	    text "#fmt("   EMISION POR  $%12.12s", "#fmtDec($payment.additionalData.ad_valeMonto)" ) ";	    
	    text "#fmt("   CONTROL  %20.20s", "#fmtCNum($payment.additionalData.ad_valeNumero)" ) ";
	#end
#end


#parse( "1003/templates/paymentsChange.vcl" )


