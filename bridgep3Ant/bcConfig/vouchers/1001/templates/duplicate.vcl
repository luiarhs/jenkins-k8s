beginBold;
setAlignment center;
#set ($sign = "-1")
text "D U P L I C A D O";
endBold;
newline;
#if($monedero.walletAccount)
	#if(!$monedero.vale)
		#if($monedero.benefitedAmount)
		  text "#fmt("EMISION POR $%5s", "#fmtDec($monedero.benefitedAmount)")";
		  newline;
		#end
	#end
#end
#foreach( $payment in $ticket.payments )
	#if($payment.tenderGsaId == 8 || $payment.tenderGsaId == 10 || $payment.tenderGsaId == 11 || $payment.tenderGsaId == 19 || $payment.tenderGsaId == 20)
		setAlignment left;
		beginBold;
			text "#fmt("%-18s %1s%17s", ["$payment.description","$","#fmtDec($payment.amount,$sign)"])";
		endBold;

		#if("$payment.puntosBmerPoolId")
			text "$payment.puntosBmerPoolId";
		#end

		#if($payment.tenderGsaId == 10)
			#if($payment.appLabel)
				text "$payment.appLabel";
			#end
		#end

		#if($payment.inputType)
			text "$payment.inputType";
		#end

		#if($payment.descriptionPrint)
			text "$payment.descriptionPrint";
		#end

		#if($payment.account)
			#if ($payment.tenderGsaId == 10)
				text "CUENTA: #maskAcc($payment.account)";
			#else
				text "CUENTA: $payment.account";
			#end	      
		#end

		#if($payment.nombre)
			text "NOMBRE: $payment.nombre";
		#end

		#if($payment.tenderGsaId == 10 && $ticket.transactionType == 2)
			#set ($duplicate_contains_tender_Gsa10_Return = true)
			#if($payment.bankAfiliation)
			   text "AFILIACION: $payment.bankAfiliation";
			#end
			#if($payment.criptograma)
			   text "ARQC: $payment.criptograma";
			#end
			#if($payment.aid)
			   text "AID: $payment.aid";
			#end
		#end
		newline;
	#end
#end

beginBold;
text "*ESTE DOCTO NO ES VALIDO PARA COMPRAS*";
endBold;
newline;
newline;
text "NOMBRE Y FIRMA:_______________________";
newline;
newline;

#if($duplicate_contains_tender_Gsa10_Return)
    text "    DEVOLUCIÓN SUJETA A TÉRMINOS Y";
    text " CONDICIONES DEL EMISOR DE LA TARJETA";
    newline;
#end

setFontSize normal;
text "#fmt("TIENDA: %5s %s %s", ["$ticket.trxVoucher","#formatFecha($date)",$time])";
setFontSize normal;

cutPaper 90;
setFontSize normal;