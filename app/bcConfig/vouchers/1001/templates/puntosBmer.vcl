#if($printerType == "2")
    setCharsPerLine 48;
#else
    setCharsPerLine 38;
#end

#if($printerType == "2")
    bitmap "0" center;
    lineSpacing 2;
    newline;
#else
    bitmapPreStored 1 center;
#end
newline;
setFontSize wideB;
setAlignment center;
beginBold;
   #if($store.storeName)
   		text "$store.storeName";
   #end
endBold;
newline;
setFontSize normal;
setAlignment center;
	#if($store.storeAddress)
		text "$store.storeAddress";
	#end

newline;
text "FECHA #formatFecha($date)    HORA $time";
newline;

#if($bmerPoints)
	setAlignment center;
	setFontSize wideB;
	beginBold;
	text "$bmerPoints.account";
	endBold;

	setFontSize normal;
	beginBold;   
	#if($bmerPoints.bankAfiliation)
       newline;
       text "#fmt("%s %s", ["AFILIACIÓN:","$bmerPoints.bankAfiliation"])";
	#end
	endBold;

	newline;
	text "BBVA CRÉDITO";
	newline;
	text "CONSULTA DE BENEFICIOS";
	text "--------------------------------------";
	setAlignment left;
	text "Puntos BBVA";

	#if ($bmerPoints.poolId)
		text "$bmerPoints.poolId";
	#end

	text "#fmt("Saldo Anterior       %-15s" ,["$bmerPoints.saldoAnteriorPuntos (PTS)"])";
	text "#fmt("%20.20s  %1.1s %14.14s", ["Importe en Pesos  ","$","#fmtDec($bmerPoints.saldoAnteriorPesos)"])";
	newline;
	text "#fmt("Redimidos            %-15s" ,["$bmerPoints.saldoRedimidoPuntos (PTS)"])";
	text "#fmt("%20.20s  %1.1s %14.14s", ["Importe en Pesos  ","$","#fmtDec($bmerPoints.saldoRedimidoPesos)"])";
	newline;
	text "#fmt("Saldo Actual         %-15s" ,["$bmerPoints.saldoPuntos (PTS)"])";
	text "#fmt("%20.20s  %15.15s", ["Saldo Actual      $","$bmerPoints.saldoPesos"])";
	newline;
	text "--------------------------------------";

	#if($bmerPoints.factorExp && $bmerPoints.factorExp != "00" && $bmerPoints.factorExp != "01")
		setAlignment center;
		text "PUNTOS EXPONENCIALES";
		text "--------------------------------------";
		text "#fmt("%20.20s  %15.15s", ["Redimidos         ","$bmerPoints.saldoRedimidoExpPuntos (PTS)"])";
		newline;
		newline;
		text " HOY EN ESTE COMERCIO TUS PUNTOS VALEN: ";
		text "#fmt("%20.20s  %15.15s", ["Saldo Actual      ","$bmerPoints.saldoDispExpPesos (PTS)"])";
		text "#fmt("%20.20s  %15.15s", ["Promoción vigente al ","$bmerPoints.vigenciaPromoExp"])";
		newline;
		text "--------------------------------------";
	#end
#end

#if($masterCardPoints)
  setAlignment center;
  setFontSize wideB;
  beginBold;
    text "$masterCardPoints.account";
	endBold;

	setFontSize normal;
	beginBold;   
	  #if($masterCardPoints.bankAfiliation)
      newline;
		  text "#fmt("%s %s", ["AFILIACIÓN:","$masterCardPoints.bankAfiliation"])";
   #end
	endBold;

	newline;
	#if($masterCardPoints.bankDescription)
		text "$masterCardPoints.bankDescription";
	#end

  newline;
  text "Puntos Bancarios";
  setAlignment left;
  text "--------------------------------------";
  newline;
  text "#fmt("Saldo Puntos       %-15s" ,["$masterCardPoints.saldoPuntos (PTS)"])";
  newline;
  text "#fmt("Saldo Pesos        %-15s" ,["$masterCardPoints.saldoPesos"])";
  newline;
  text "--------------------------------------";
#end

setAlignment center;
text "GRACIAS";

cutPaper 90;
setFontSize normal;