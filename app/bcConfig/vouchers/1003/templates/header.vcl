setCharsPerLine 48;
newline;
##the 'bitmap' command loads an image file, sends the image data to printer and then prints the image data
newline;
##bitmap "#absPath("config/vouchers/templates/liverpool.png")" center;
bitmap "0" center;
newline;

setFontSize normal;
setAlignment left;
text "Distribuidora Liverpool S.A. de C.V.2";
text "Mario Pani, 200";
text "Col  Santa Fe Cuajimalpa C.P. 05348";
text "Del  Cuajimalpa de Morelos D.F.";
text "RFC  DDI-931291-MI0";
text "Regimen general de ley de personas";
text "morales";
setAlignment center;
text "-----------------------------------------";
beginBold;
text "$store.storeName";
endBold;
setAlignment center;
   #if($store.storeAddressList)
	#foreach( $temp in $store.storeAddressList)
		text "$temp";
	#end
#end
#if(!$store.storeAddressList)
	text "$store.storeAddress";
	text "$store.storeAddress2";
	text "Tel $store.telephone";
	text "C.P. $store.zipCode";
	text "$store.storeAddress4";
#end

text "-----------------------------------------";


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

#if($ticket.additionalSubType != 130)
   #if($ticket.employeeAccount)
      beginBold;
      setAlignment left;
      newline;
      text "#fmt("CUENTA CASA: %-s", "#maskAcc($ticket.employeeAccount)")";
      newline;
      endBold;
   #end
#end

#if($ticket.nroComanda)
    beginBold;
    setAlignment left;
	newline;
	  text "#fmt("NUMERO DE COMANDA: %-s", "$ticket.nroComanda")";
	newline;
	endBold;
#end

#if($ticket.watchAccountNumber)
    beginBold;
    setAlignment left;
	  text "#fmt("Nro. de Orden: %-s", "$ticket.watchAccountNumber")";
	newline;
	endBold;
#end

#if( $ticket.giftsPlanData )
   #if(!($ticket.giftsPlanData.eventOrganizer) && $ticket.transactionType != 2 && $ticket.additionalSubType != 102)
      text "$ticket.giftsPlanData.fatherSurname : $ticket.giftsPlanData.motherSurname : $ticket.giftsPlanData.name";
   #end
   #if($ticket.giftsPlanData.typeElectronicGift != -1)
		#if($ticket.giftsPlanData.typeElectronicGift == 1)
			text "#fmt("%-s", "******** REGALO ABIERTO ********")";
		#end
		#if($ticket.giftsPlanData.typeElectronicGift == 2)
			text "#fmt("%-s", "******** JUEGO ABIERTO ********")";
		#end
		#if($ticket.giftsPlanData.typeElectronicGift == 3 || $ticket.giftsPlanData.typeElectronicGift == 4 )
			text "#fmt("%-s", "***** CERTIFICADO CON PRECIO *****")";
		#end
   #else
   		#if($ticket.transactionType != 2)
			text "#fmt("MESA DE REGALOS: %-s", "$ticket.giftsPlanData.typeEventDescription")";
		#else
			text "MESA DE REGALOS:";
		#end
   #end
   #if($ticket.eventNumber && $ticket.transactionType != 2)	
		text "#fmt("NUMERO DE EVENTO: %-s", "#fmtLft($ticket.eventNumber,8)")";
   #end
   #if($ticket.giftsPlanData.cardNumber && $ticket.transactionType != 2)
		text "#fmt("TARJETA: %-s", "$ticket.giftsPlanData.cardNumber")";
   #end
   newline;
#end

#if($ticket.somsOrderData.somsAccountNumber)
    beginBold;
    setAlignment center;
    newline;
	#if($ticket.additionalSubType == 102 || $ticket.additionalSubType == 123)
		text "#fmt("NO. ORDEN DE VENTA: %-s", "$ticket.somsOrderData.somsAccountNumber")";
	#end
	#if($ticket.additionalSubType == 106 || $ticket.additionalSubType == 122)
		text "#fmt("NO. ORDEN DE DEVOLUCION: %-s", "$ticket.somsOrderData.somsAccountNumber")";
	#end
    newline;
    endBold;
#end		

#if($ticket.opticaAccountNumber)
    beginBold;
    setAlignment center;
	#if($ticket.additionalSubType == 128 || $ticket.additionalSubType == 129)
		text "ORDEN VENTA OPTICA: $ticket.opticaAccountNumber";
	#end
    newline;
    endBold;
#end		


#if( $ticket.warrantyReference )
	beginBold;
	text "#fmt("REFERENCIA: %-s", "$ticket.warrantyReference")";
	endBold;
	newline;
	newline;
	setAlignment left;
     barcode ITF "$ticket.warrantyReference" 70 2 left below;
     newline;
#end

#if($ticket.transactionDolar)
	setAlignment center;
	beginBold;
	   text "ADQUISICION DE LOS SIGUIENTES ARTICULOS";
	   text "Y/O SERVICIOS";
	endBold;
	newline;
#end

#if($ticket.additionalSubType == 136)
    text "NUM CONVENIO:          $service.serviceReferenceNumber";
#end