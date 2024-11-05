#if($ticket.transactionType == 112)
    #set ($sign = "-1")
#else
    #set ($sign = "1")
#end
setCharsPerLine 48;
 newline;
 ##the 'bitmap' command loads an image file, sends the image data to printer and then prints the image data
 newline;
 ##bitmap "#absPath("config/vouchers/templates/liverpool.png")" center;
 bitmap "0" center;
 newline;
 
#parse( "1003/templates/shortHeader.vcl" )

newline;
newline;
text "#fmt("%30.30s %5.5s", ["NO. ORIGINAL DE TERMINAL   ","$ticket.terminalCode"])";
text "#fmt("%30.30s %5.5s", ["NO. TRANSACCION CANCELADA  ","$ticket.originalTicketNumber"])";
text "#fmt("%25.30s  %5.1s %1.8s", ["MONTO TRANSAC. CANCEL  ","$","$ticket.total"])";
newline;
#if($payment.tenderGsaId == 8)
	text "#fmt("*%-2.2s*%-16.16s* %10.1s %-8.8s", ["$payment.tenderGsaId","#maskAcc($payment.additionalData.account)","$","$payment.amount"])";
#else
    #if($payment.tenderGsaId == 10)
    
        setFontSize high;
        beginBold;
        text "#fmt("***** TOTAL $%12.12s", "#fmtDec($payment.amount,$sign)" ) ";
        newline;
        endBold;
        setFontSize normal;
    
        #if($payment.additionalData.bankdescription)
            text "#fmt("%13.13s  %1.1s  %16.16s", ["$payment.additionalData.bankdescription","$","#fmtDec($payment.amount,$sign)"])";
        #else
            text "#fmt("%13.13s  %1.1s  %16.16s", ["$payment.description","$","#fmtDec($payment.amount,$sign)"])";
        #end
        #if($payment.inputType)
            text "$payment.inputType";
        #end
		#if($payment.account)
   		#if($notSecureAccount == "true")
	        text "CUENTA :  $payment.account";
   	   #else
	        text "CUENTA :  #maskAcc($payment.account)";
         #end	
	    #end
	    #if($payment.nombre)
	        text "NOMBRE :   $payment.nombre";
	    #end
	    #if($payment.bankAfiliation)
	        text"AFILIACION :            $payment.bankAfiliation";
	    #end
        #if($payment.criptograma)
            text "ARQC: $payment.criptograma";
        #end
        #if($payment.aid)
            text "AID: $payment.aid";
        #end
        newline;
        #parse( "1003/templates/signature.vcl" )
        newline;
        text "   CANCELACION SUJETA A TERMINOS Y";
        text " CONDICIONES DEL EMISOR DE LA TARJETA";
    #end
#end
newline;
newline;
#if($epayment_is_duplicate)
    text "CLIENTE  #formatFecha($date)   $time";
#else
    text "TIENDA   #formatFecha($date)   $time";
#end