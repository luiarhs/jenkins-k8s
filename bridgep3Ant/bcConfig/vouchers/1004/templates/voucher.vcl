#if($payment.amount != "0.00")
  ## no quitar este newline, se rompe la impresión de Linux
  newline;
  setCharsPerLine 38;
  setAlignment center;
  setFontSize normal;
  beginBold;
  text "$store.fullStoreName";
  endBold;
  newline;
  text "$store.storeAddress";
  newline;
  setFontSize wideB;
  beginBold;
  text "$ticket.transactionTitle";
  endBold;

  setAlignment left;
  setFontSize normal;
  newline;

  text "#fmt("%-4s      %5s      %-4s     %4s", ["TERM","DOCTO","TDA","VEND"])";
  text "#fmt("%03s       %4s       %4s    %8s", ["$ticket.terminalCode", "$ticket.docNumber", "$ticket.storeCode", "$ticket.userName"])";
 
  newline;
  text "#fmt("      ATENDIO: %-s", "$ticket.userNameDescription")";

  #if(!$ticket_is_duplicate && (!$ticket.listaEuropea && $ticket.nroOrdenPaqueteria && ($ticket.additionalSubType == 117 || ($ticket.additionalSubType == 134 && $ticket.cdiPlanData && $ticket.cdiPlanData.type == 1) || ($ticket.additionalSubType == 115 && ($ticket.giftsPlanData && $ticket.giftsPlanData.typePlan == 1) ))))
    newline;
    beginBold;
    text "#fmt("No. PEDIDO: %-s", "$ticket.nroOrdenPaqueteria")";
    endBold;
  #end

  #if ($ticket.additionalSubType == 110)
    setAlignment center;
    newline; 
    beginBold;
	  text "DISPOSICION EFECTIVO";
	  endBold;
	  setAlignment left;
  #end

  beginBold;
  newline;
  text "#fmt("*****   TOTAL M.N. $ %16s", "#fmtDec($payment.amount,$sign)" ) ";
  newline;
  #if($payment.additionalData.isPuntosBmerPayed)
		text "PAGADO CON PUNTOS BBVA";
  #end
  #if($payment.additionalData.isPuntosMasterCardPayed)
		text "PAGADO CON PUNTOS MASTERCARD";
  #end

  #if(($payment.additionalData.isPaymentEwallet && $payment.additionalData.isPaymentEwallet == "true"))
     #set($description = "P O C K E T ")
  #elseif($payment.bankdescription)
     #set($description = $payment.bankdescription)
  #else
     #set ($description = $payment.description)
  #end

  text "#fmt("%-17s  %s %16s", ["$description","$","#fmtDec($payment.amount)"])";
  endBold;

  setAlignment left;

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

  #if(!$payment.additionalData.isCoDi)
    #if($payment.account)
      text "CUENTA: #maskAcc($payment.account)";
    #end
  #end

  #if($payment.nombre)	
	  text "NOMBRE: $payment.nombre";
  #end

  #if($payment.tenderGsaId == 10)
	  #if($payment.bankAfiliation)	
		  text "AFILIACION: $payment.bankAfiliation";
	  #end
	  #if($payment.criptograma)
		  text "ARQC: $payment.criptograma";
	  #end
	  #if($payment.aid)
		  text "AID: $payment.aid";
	  #end
	  #if($payment.restoPuntos)
      newline;
	    text "#fmt("%13.13s  %1.1s  %16.16s", ["TOTAL A PAGAR","$","#fmtDec($payment.restoPuntos)"])";
    #end
  #end

  newline;

  setCharsPerLine 48;
  setAlignment left;
  beginBold;
  text "Distribuidora Liverpool S.A. de C.V.";
  text "Prol. Vasco de Quiroga, 4800 Torre 2 Piso 3";
  text "Col. Santa Fe Cuajimalpa";
  text "Del. Cuajimalpa de Morelos, C.P. 05348 CDMX";
  text "Tel. 5268-3000, R.F.C. DLI-931201-MI9";
  newline;
  setAlignment left;
  text "Por  este  pagaré  me obligo  incondicionalmente";
  text "a  pagar a la  orden del  banco  acreditante  el";
  text "importe  de este  titulo.  Este  pagaré  procede";
  text "del  contrato  de  apertura  de  crédito  que el";
  text "banco  acreditante y el  tarjetahabiente  tienen";
  text "celebrado.";
  
  #if($payment.tenderGsaId == 11 || $payment.tenderGsaId == 8)
    text "Algunos  de  los  adeudos a su cargo han sido o ";
    text "podrán ser cedidos a un fideicomiso.            ";
  #end

  newline;
  setAlignment center;

  #if($payment.nip)
     text "AUTORIZADO MEDIANTE FIRMA ELECTRÓNICA";
  #elseif(($payment.contactLess && ($payment.tenderGsaId == 11 || $payment.tenderGsaId == 20)) || ($payment.nip || $payment.sinFirma || ($payment.contactLess && $payment.tenderGsaId != 11 && $payment.tenderGsaId != 20) || $payment.qps || ($payment.isPaymentEwallet && $payment.isPaymentEwallet == "true")))
     text "AUTORIZADO SIN FIRMA";
  #elseif($payment.autografa || (!$payment.qps && !$payment.nip && !$payment.sinFirma))
     newline;
     newline;
     text "___________________";
     text "   Acepto";
  #end

  endBold;

  newline;
  text "PAGARE NEGOCIABLE UNICAMENTE CON";
  text "INSTITUCIONES DE CREDITO";

  setCharsPerLine 38;
  newline;
  text "#fmt("%s %s", ["#formatFecha($date)",$time])";

  cutPaper 90;
  setFontSize normal;
#end