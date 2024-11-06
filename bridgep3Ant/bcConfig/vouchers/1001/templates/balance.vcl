#if($printerType == "2")
    setCharsPerLine 48;
#else
    setCharsPerLine 38;
#end

setAlignment center;
#if ($hideLblDate != "true")
	##the 'bitmap' command loads an image file, sends the image data to printer and then prints the image data
 
	##bitmap "#absPath("config/vouchers/templates/liverpool.png")" center;
	#if($printerType == "2")
		bitmap "0" center;
		lineSpacing 2;
		newline;
	#else
		bitmapPreStored 1 center;
	#end
		
	#if($balance.account)
		beginBold;		
		#if($balance.balance)
			text "CUENTA: #maskAcc($balance.account)";
		#else
			text "CUENTA: $balance.account";
		#end
		endBold;
	#end
#end

#if($balance.name)
   beginBold;
     text "CLIENTE: $balance.name";
   endBold;
#end

#if($balance.eicMessage)
	 beginBold;
	   text "#fmt("%-40.40s", ["$balance.eicMessage"])"; 
	 endBold;
  #else
  #if($balance.balance)
     newline;
     beginBold;
		   text "#fmtLftWthFill("SALDO  $",20," ")#fmtLftWthFill($balance.balance,14," ")"; 
	   endBold;
		text "#fmtLftWthFill("SALDO VENCIDO  $",20," ")#fmtLftWthFill($balance.defeatedBalance,14," ")";
	   #if($balance.isMiniPayment)
			text "#fmtLftWthFill("PAGO MENSUAL  $",20," ")#fmtLftWthFill($balance.minPayment,14," ")";
			text "#fmtLftWthFill("PAGO QUINCENAL  $",20," ")#fmtLftWthFill($balance.biWeekelyPayment,14," ")";
			#if($balance.nextPaymentDate != "")
			    text "#fmtLftWthFill("FECHA DE PAGO  $",20," ")#fmtLftWthFill($balance.nextPaymentDate,14," ")";
            	text "#fmtLftWthFill($balance.nextSecondPaymentDate,34," ")";
            #end
		#else
			text "#fmtLftWthFill("PAGO MINIMO  $",20," ")#fmtLftWthFill($balance.minPayment,14," ")";
			text "#fmtLftWthFill("PAGO MIN+MSI  $",20," ")#fmtLftWthFill($balance.paymentWithoutRefinance,14," ")";
			text "#fmtLftWthFill("PAGO N/GEN INT  $",20," ")#fmtLftWthFill($balance.minPaymentWithoutInterest,14," ")";
			beginBold;
				text "#fmtLftWthFill("LIMITE DE PAGO  :",20," ")#fmtLftWthFill($balance.lastPaymentDate,14," ")";

				#if("$!accountHasPIF" != "")
					#if($accountHasPIF)
						text "#fmtLftWthFill("ESTATUS PIF  :",20," ")#fmtLftWthFill("ACTIVO",14," ")";
					#else
						text "#fmtLftWthFill("ESTATUS PIF  :",20," ")#fmtLftWthFill("INACTIVO",14," ")";
					#end
				#end
			endBold;
		#end
		   newline;
		   text "#fmt("%-40.40s", ["*** SALDO INFORMATIVO Y NO INCLUYE ***"])";
		   text "#fmt("%-40.40s", ["***** INTERESES DEL ULTIMO CICLO *****"])";

    #else

    #if((!$balance.printWalletBalance || !$balance.walletBalance) && $ticket.additionalSubType != 154)
       newline;
       beginBold;
	     text "***FAVOR DE PASAR A CREDITO***";
	   endBold;
    #end
  #end
#end

#if($ticket.additionalSubType == 154)
       beginBold;
           setFontSize wideB;
           text "SALDO TARJETA EXTERNA";
       endBold;
       setFontSize normal;

       newline;
       #if($ticket.infoGugaData.gugaCredito != 0 || $ticket.infoGugaData.gugaPorPagar != 0 || $ticket.infoGugaData.gugaPrePago != 0)
            text "#fmt("SALDO: $%-s", "$ticket.infoGugaData.gugaCredito")";
            text "#fmt("POR PAGAR: $%-s", "$ticket.infoGugaData.gugaPorPagar")";
            text "#fmt("DISPONIBLE PARA PAGO: $%-s", "$ticket.infoGugaData.gugaPrePago")";

            newline;
            text "#fmt("%-40.40s", ["------------------------------------"])";

            setFontSize normal;
            #if($ticket.infoGugaData.leyendaGuga)
                setAlignment left;
                text "#divStr($ticket.infoGugaData.leyendaGuga, 38)";
            #end

       #else

            text "NO SE OBTUVIERON SALDOS";
            newline;
            text "***FAVOR DE PASAR A CREDITO***";

       #end
#end

#if($balance.cashAvailable && $balance.cashAvailable != "0.00")
	text "#fmt("%-40.40s", ["------------------------------------"])";
	beginBold;
		text "DISPOSICION DE EFECTIVO";
		newline;
		text "DISPONIBLE: $ #fmtDec($balance.cashAvailable)";
	endBold;
#end

#if (($balance.printWalletBalance && $balance.walletBalance) && ($hideLblDate != "true"))
   #if($balance.balance)
       text "#fmt("%-40.40s", ["------------------------------------"])";
   #end

   beginBold;
       text "SALDO MONEDERO";
   endBold;
   setFontSize normal;

   newline;
   beginBold;
     #if($balance.walletBalance == 0)
        text "SALDO A FAVOR:  $  C E R O";
     #else
        text "SALDO A FAVOR:  $  #fmtDec($balance.walletBalance)";
     #end;
   endBold;
#end;

## Muestra leyenda de garantia PIF
#if($pifWarrantyMessage)
    text "#fmt("%-40.40s", ["------------------------------------"])";
    setFontSize normal;
    beginBold;
    	text "$pifWarrantyMessage";
    endBold;
#end

#if($hideLblDate != "true")
	newline;
	text "#formatFecha($date)   $time";
	cutPaper 90;
	setFontSize normal;
#end