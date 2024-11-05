#if($ticket.transactionType == 112)
    #set ($sign = "-1")
#else
    #set ($sign = "1")
#end

#if($printerType == "2")
    setCharsPerLine 48;
#else
    setCharsPerLine 38;
#end

#if($epayment_is_duplicate)
   #if($printerType == "2")
       bitmap "0" center;
       lineSpacing 2;
       newline;
   #else
       bitmapPreStored 1 center;
   #end
#end

#parse( "1001/templates/shortHeader.vcl" )
newline;	
text "#fmt("NO. ORIGINAL DE TERMINAL           %03s", "$ticket.terminalCode")";
text "#fmt("NO. TRANSACCION CANCELADA        %5s", "$ticket.originalTicketNumber")";
text "#fmt("MONTO TRANSAC. CANCEL  $ %1s", "$ticket.total")";
newline;

beginBold;
   text "#fmt("*****   TOTAL M.N. $     %13s", "#fmtDec($ticket.total,$sign)" ) ";
endBold;

#if ($ticket.accountPaymentData)
  newline;
  text "#fmt("*%2s*      %08s* %s", ["$ticket.accountPaymentData.cardType","$ticket.accountPaymentData.authorizationCode","$ticket.accountPaymentData.account"])";
  newline;
#end

##Indicadores para imprimir únicamente una firma del medio de pago
#set ($hasQps = false)
#set ($hasAutografa = false)
#set ($hasFirmaElectronica = false)
#set ($contactLess = false)

#foreach($payment in $ticket.payments)
   
   #if($payment.tenderGsaId == 8 || $payment.tenderGsaId == 11)
        newline;
        text "#fmt("*%2s*      %08s* %s", ["$payment.tenderGsaId","$payment.authorization_code","$payment.additionalData.account"])";
   #else
      #if($payment.tenderGsaId == 10)
            beginBold;
            newline;
            #if($payment.additionalData.bankdescription)
            	text "#fmt("%-17s  %s   %15s", ["$payment.additionalData.bankdescription","$","#fmtDec($payment.amount,$sign)"])";
            #else
            	text "#fmt("%-17s  %s   %15s", ["$payment.description","$","#fmtDec($payment.amount,$sign)"])";
            #end
            endBold;
            #if($payment.inputType)
                text "$payment.inputType";
            #end
   		    #if($payment.account)
      		    #if($notSecureAccount == "true")
   	                text "CUENTA: $payment.account";
      	        #else
   	                text "CUENTA: #maskAcc($payment.account)";
                #end
   	        #end
            #if($payment.nombre)
                text "NOMBRE: $payment.nombre";
            #end

            #if($payment.bankAfiliation)
                text "AFILIACIÓN: $payment.bankAfiliation";
            #end
            #if($payment.criptograma)
               text "ARQC: $payment.criptograma";
            #end

            #if($payment.aid)
               text "AID: $payment.aid";
            #end

            ##TODO Hacer ajuste, no pueden ser nip y autógrafas como autorizado por firma electrónica
            #if($payment.nip)
                #set ($hasFirmaElectronica = true);
            #elseif($payment.qps)
                #set ($hasQps = true)
            #elseif($payment.sinFirma || $payment.autografa)
                #set ($hasAutografa = true)
            #elseif($payment.contactLess)
                #set ($contactLess = true)
            #end

       #end
   #end
#end
newline;

##Lógica para validar indicadores de firma
#if($hasAutografa)
    newline;
    newline;
    newline;
    newline;
    text "           ------------------           ";
    text "                 Acepto                 ";
#elseif($hasFirmaElectronica)
    text "AUTORIZADO MEDIANTE FIRMA ELECTRÓNICA";
#elseif($hasQps || $contactLess)
    text "         AUTORIZADO SIN FIRMA           ";
#end

newline;
text "   CANCELACIÓN SUJETA A TÉRMINOS Y";
text " CONDICIONES DEL EMISOR DE LA TARJETA";
newline;

#if($epayment_is_duplicate)
   text "#fmt("CLIENTE        %15s  %5s", ["#formatFecha($date)","$time"])";
#else
	text "#fmt("TIENDA %4s   %15s  %5s", ["$ticket.trxVoucher","#formatFecha($date)","$time"])";
#end