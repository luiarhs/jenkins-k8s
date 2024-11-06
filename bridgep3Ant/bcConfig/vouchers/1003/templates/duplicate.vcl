beginBold;
setAlignment center;
text "   D   U   P   L   I   C   A   D   O ";
endBold;
newline;
setAlignment left;
#foreach( $payment in $ticket.payments )
    #if($payment.tenderGsaId == 8 || $payment.tenderGsaId == 10 || $payment.tenderGsaId == 11)
        text "#fmt("%13.13s  %1.1s  %16.16s", ["$payment.description","$","$payment.amount"])";
        #if($payment.originalAuthorization && $payment.inputType)
            text "$payment.inputType";
        #end
        #if($payment.authorizationCode)
            text "#fmt("%1.1s@%1.1s %-13.13s **%-8.8s**", ["$payment.inputDescriptor","$payment.authorizationType","AUTORIZACION    ","$payment.authorizationCode"])";
        #end
        #if($payment.descriptionPrint)
            text "$payment.descriptionPrint";
        #end
        
        #if($payment.account)
            text "#fmt("%-13.13s  %-20.20s", ["CUENTA: ","#maskAcc($payment.account)"])";
        #end
        #if($payment.nombre)
            text "#fmt("%-13.13s  %-20.20s", ["NOMBRE: ","$payment.nombre"])";
        #end
        
        #if($payment.tenderGsaId == 10 && $ticket.transactionType == 2)
            #set ($duplicate_contains_tender_Gsa10_Return = true)
            #if($payment.bankAfiliation)
                text "#fmt("%-13.13s  %-20.20s", ["AFILIACION: ","$payment.bankAfiliation"])";
            #end
            #if($payment.criptograma)
                text "ARQC: $payment.criptograma";
            #end
            #if($payment.aid)
                text "AID: $payment.aid";
            #end
        #end
        
    #end
#end
newline;
beginBold;
newline;
text "*ESTE DOCTO NO ES VALIDO PARA COMPRAS*";
endBold;
newline;
text "NOMBRE : _____________________________";
newline;
newline;
newline;
text "DIRECC.: _____________________________";
newline;
newline;
newline;
text "______________________________________";
newline;
newline;
newline;
text "TELEF. : _____________________________";
newline;
newline;
newline;
text "FIRMA  : _____________________________";
newline;
newline;
newline;
#if($duplicate_contains_tender_Gsa10_Return)
    text "    DEVOLUCION SUJETA A TERMINOS Y";
    text " CONDICIONES DEL EMISOR DE LA TARJETA";
    newline;
#end
setFontSize normal;
text "TIENDA:  $ticket.trxVoucher #formatFecha($date)   $time";
newline;
newline;
newline;
newline;
cutPaperManual;