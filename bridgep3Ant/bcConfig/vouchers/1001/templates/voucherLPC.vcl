#if($payment.amount != "0.00")
#parse( "1001/templates/shortHeader.vcl" )

newline;
setAlignment center;
#if($payment.additionalData.accountType == 2)
	text "VENTA CON MONEDERO";
#else
	text "VENTA CON MONEDERO DILISA";
#end

newline;
setAlignment left;
text "#fmt("%1s%1s", ["MONEDERO   $","$payment.amount"])";
##text "#fmt("%22.22s  %1.1s  %10.10s", ["LIVERPOOL PREMIUM CARD","$","$payment.amount"])";
text "AUTORIZACION: $payment.additionalData.authorization_code";
text "CUENTA: #maskAcc($payment.additionalData.account)";

newline;
setCharsPerLine 48;

beginBold;
   text "Distribuidora Liverpool S.A. de C.V.";
   text "Prol. Vasco de Quiroga, 4800 Torre 2 Piso 3";
   text "Col. Santa Fe Cuajimalpa";
   text "Del. Cuajimalpa de Morelos, C.P. 05348 CDMX";
   text "Tel. 5268-3000, R.F.C. DLI-931201-MI9";

   #if(!$payment.sinFirma && !$payment.qps && !$payment.nip && !$payment.autografa)
      newline;
      newline;
      setAlignment center;
      text "___________________";
      text "Acepto";
   #end
   #if($payment.qps)
      newline;
      setAlignment center;
      text "AUTORIZADO SIN FIRMA";
   #end

endBold;
setCharsPerLine 38;
newline;
text "#fmt("TIENDA: %5s %s %s", ["$payment.additionalData.nroVoucher","#formatFecha($date)",$time])";

cutPaper 90;
setFontSize normal;
#end