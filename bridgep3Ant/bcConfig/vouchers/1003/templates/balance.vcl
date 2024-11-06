setCharsPerLine 48;
newline;
##the 'bitmap' command loads an image file, sends the image data to printer and then prints the image data
newline;
##bitmap "#absPath("config/vouchers/templates/liverpool.png")" center;
bitmap "0" center;
newline;

newline;
#if($balance.account)
	#if($notSecureAccount == "true")
      text "CUENTA : $balance.account";
 	#else
   	text "CUENTA : #maskAcc($balance.account)";
   #end	
#end
newline;
#if($balance.name)
    text "#fmt("%-10.10s  %-30.30s", ["CLIENTE:  $","$balance.name"])"; 
newline;
#end
#if($balance.eicMessage)
beginBold;
   text "#fmt("%-40.40s", ["$balance.eicMessage"])"; 
endBold;
#end
#if($balance.balance)
beginBold;
    text "#fmt("%-20.20s  %-10.10s", ["SALDO           $","$balance.balance"])"; 
endBold;
text "#fmt("%-20.20s  %-10.10s", ["SALDO VENCIDO   $","$balance.defeatedBalance"])"; 
text "#fmt("%-20.20s  %-10.10s", ["PAGO MINIMO     $","$balance.minPayment"])"; 
text "#fmt("%-20.20s  %-10.10s", ["PAGO S/REFINAN  $","$balance.paymentWithoutRefinance"])"; 
text "#fmt("%-20.20s  %-10.10s", ["PAGO N/GEN INT  $","$balance.minPaymentWithoutInterest"])";
beginBold; 
    text "#fmt("%-20.20s  %-10.10s", ["LIMITE DE PAGO  :","$balance.lastPaymentDate"])";
    newline;
    newline;
    text "#fmt("%-40.40s", ["*** SALDO INFORMATIVO Y NO INCLUYE ***"])";
    text "#fmt("%-40.40s", ["**** INTERESES DEL ULTIMO CICLO ****"])";  
endBold;
#end
newline;
newline;
#if($balance.walletBalance && $balance.balance)
text "#fmt("%-40.40s", ["--------------------------------------"])";
newline;
setAlignment center;
beginBold;
   setFontSize highWide;
   text "SALDO MONEDERO";
endBold;
setFontSize normal;
newline;
#end
#if($balance.walletBalance)
beginBold;
#if($balance.walletBalance == 0)
   text "#fmt("%-20.20s  %-10.10s", ["SALDO A FAVOR:  $","C E R O"])";
#else
   text "#fmt("%-20.20s  %-10.10s", ["SALDO A FAVOR:  $","$balance.walletBalance"])";
#end; 
endBold;
#end
newline;
newline;
	text "#formatFecha($date)   $time";
newline;
newline;
newline;
newline;
newline;
newline;



	
	




