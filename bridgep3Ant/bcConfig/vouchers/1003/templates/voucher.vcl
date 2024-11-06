setCharsPerLine 48;
setAlignment center;
beginBold;
   setFontSize highWide;
text "$store.storeName";
endBold;
setFontSize normal;
text "$store.storeAddress";
newline;
beginBold;
   setFontSize highWide;
   text "$ticket.transactionTitle";
endBold;

setAlignment left;
setFontSize normal;
newline;

text "#fmt("  %-8.8s  %-4.4s  %8.8s  %8.8s", ["TERM","DOCTO","TDA","VEND"])";
text "#fmt("  %-8.8s  %-5.5s  %8.8s  %8.8s", ["$ticket.terminalCode", "$ticket.docNumber", "$ticket.storeCode", "$ticket.userName"])";
 
newline;
  text "#fmt("      ATENDIO: %-s", "$ticket.userNameDescription")";
newline;
#if($payment.additionalData.isPuntosBmerPayed)
	beginBold;
	text "PAGADO CON PUNTOS";
	endBold;
#end
#if($payment.additionalData.bankdescription)
	text "#fmt("%13.13s  %1.1s  %16.16s", ["$payment.additionalData.bankdescription","$","#fmtDec($payment.amount)"])";
#else
	text "#fmt("%13.13s  %1.1s  %16.16s", ["$payment.description","$","#fmtDec($payment.amount)"])";
#end
setAlignment left;
#if($payment.inputType)
	text "$payment.inputType";
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
#if($payment.tenderGsaId == 10)
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
newline;
newline;
newline;	

beginBold;

text "  Distribuidora Liverpool S.A. de C.V.  ";
newline;
newline;
newline;
text "Mario Pani, 200 Col. Santa Fe Cuajimalpa";
text "Del.  Cuajimalpa  de  Morelos C.P. 05348";
text "              México, D.F.              ";
text "  TEL. 5268-3000 R.F.C. DLI-931201-MI9  ";
newline;
newline;
newline;
text "Por  el  presente  PAGARE,  me  obligo a";
text "pagar  incondicionalmente  a la orden de";
text "Distribuidora  Liverpool  SA de C.V. y/o";
text "del  emisor de la  tarjeta, en la ciudad";
text "de México DF, o en cualquier otra que se";
text "me requiera,  el dia ___de ___ de ___ la";
text "cantidad  de   \$_____________.";
text "El  presente   causara  interés  mensual";
text "de_____% sobre el importe de este pagaré";
text " y  en  caso  de  incumplimiento, pagaré";
text "además  un  interés  moratorio  del ___%";
text "mensual   en   términos   del   contrato";
text "suscrito.";
text "Algunos  de  los  adeudos a su cargo han";
text "sido   o   podrán   ser   cedidos  a  un";
text "fideicomiso";
newline;
newline;
newline;
newline;
newline;

#if($payment.nip || $payment.autografa)	
	text "  AUTORIZADO MEDIANTE FIRMA ELECTRONICA ";
#end

#if($payment.qps || $payment.contactLess)
	text "         AUTORIZADO SIN FIRMA           ";
#end

#if($payment.sinFirma)	
	text "    PAGARE NEGOCIABLE UNICAMENTE CON    ";
	text "        INSTITUCIONES DE CREDITO        ";
#end

#if(!$payment.sinFirma && !$payment.qps && !$payment.nip && !$payment.autografa)	
	text "           ------------------           ";
	text "                 Acepto                 ";
	newline;
	text "    PAGARE NEGOCIABLE UNICAMENTE CON    ";
	text "        INSTITUCIONES DE CREDITO        ";
#end	
endBold;
newline;
newline;
newline;
text "TIENDA:  $payment.additionalData.nroVoucher #formatFecha($date)   $time";
newline;
newline;
newline;
newline;
newline;

cutPaperManual;
