newline;
newline;
beginBold;
#if($ticket.additionalSubType == 102)
	setAlignment center;
	#if($ticket.somsOrderData.deliveryNumber > 0 && $ticket.somsOrderData.deliveryType && $ticket.somsOrderData.deliveryType == 1)
		text "**************************************";
		text "En   esta   fecha   hago   pedido  del";
		text "producto  especificado  en  este mismo";
		text "documento el cual se me  informo   que";
		text "esta  agotado  por el momento y acepto";
		text "entrar en fila de espera con el no. $ticket.somsOrderData.deliveryNumber,";
		text "con tiempo aproximado de ____ dias.";
		text "Recibi copia del presente";
		newline;
	#end
  text "*************************************";
  text "*EL CLIENTE ACEPTA INICIAR LOS PAGOS*";
  text "*     DE LA MERCANCIA ADQUIRIDA     *"; 
  text "* INDEPENDIENTEMENTE DE LA FECHA DE *";
  text "*              ENTREGA              *";
  text "*************************************";
	newline;
#end

#if($ticket.transactionType == 2 || $ticket.isGiftsPlan)
    setAlignment center;
    text "*ESTE DOCTO NO ES VALIDO PARA COMPRAS*";
    newline;
	
    #if($payment_ContainsTenderGsa10Refund)
        text "    DEVOLUCION SUJETA A TERMINOS Y";
        text " CONDICIONES DEL EMISOR DE LA TARJETA";
        newline;
    #end
#end

#if( $ticket.giftsPlanData )
	#if($ticket.giftsPlanData.typeElectronicGift == -1 && $ticket.additionalSubType != 102)
		#if($ticket.giftsPlanData.fatherSurname && $ticket.giftsPlanData.motherSurname && $ticket.giftsPlanData.name)
			text "Realiza pago:";			
			text "$ticket.giftsPlanData.fatherSurname : $ticket.giftsPlanData.motherSurname : $ticket.giftsPlanData.name";
		#else
		    #if($ticket.nroOrdenPaqueteria)
		    	text "Realiza pago:";
				text "::";
			#end
		#end
	#end
#end

#if($ticket.nroOrdenPaqueteria)
	setAlignment center;
	text "**************************************";
	text "#fmt("No. ORDEN PAQUETERIA: %-s", "$ticket.nroOrdenPaqueteria")";
	text "**************************************";
	newline;
#end

#if($ticket.additionalSubType == 127)
    newline;
	text "************************************";
	text "#fmt("CONFIRMACION : %-20s", "$ticket.confirmationId" )";
	text "#fmt("TELEFONO : %-20s", "$ticket.phoneNumber" )";
	text "************************************";
	newline;
	beginBold;
	#foreach( $descriptor in $ticket.descriptors )
		text "#center($descriptor)";
	#end
	endBold;
#end

#if($ticket.additionalSubType == 119 || $ticket.additionalSubType == 120)
    newline;
	text "************************************";
	text "#fmt("ABONO A: %-20s", "$accountPayment.account" )";
	#if($accountPayment.accountName)
		text "NOMBRE: $accountPayment.accountName";
	#end
	#if($accountPayment.authorizationCode)
		text "#fmt("1  AUTORIZACION **%-8s**", $accountPayment.authorizationCode )";
	#end
	text "************************************";
	setAlignment center;
	   text "GRACIAS POR SU PAGO";
	newline;
#else
	setAlignment center;
	   text "Gracias por su visita!";
	newline;
#end

## Tarjetas prepago
#foreach( $itemTicketLiverpoolData in $ticket.items )
    #if($itemTicketLiverpoolData.prepaidCardCode)
        text "#center("******    TARJETAS BLACKHAWK   ******")";
        text "UPC: $itemTicketLiverpoolData.prepaidCardCode.substring(0,12)    PRECIO:$  $itemTicketLiverpoolData.extendedPrice";
        text "  #maskAcc($itemTicketLiverpoolData.prepaidCardCode.substring(12))  AUT:$itemTicketLiverpoolData.BhAuthorizationCode ";
        #if($itemTicketLiverpoolData.prepaidCardResponseMessage)
           text "$itemTicketLiverpoolData.prepaidCardResponseMessage";
        #end
        text "**************************************";
        newline;
    #end
#end

#if($ticket.nroOrdenPaqueteria)
	setAlignment center;
	text "**************************************";
    text "**ESTE DOCUMENTO NO AMPARA LA SALIDA**";
    text "**     MERCANCIA DEL ALMACEN        **";
	text "**************************************";
	newline;
#end
#if($ticket.transactionType != 2 && $ticket.somsOrderData.printNoAmpara)
	setAlignment center;
	text "**************************************";
    text "**ESTE DOCUMENTO NO AMPARA LA SALIDA**";
    text "**     MERCANCIA DEL ALMACEN        **";
	text "**************************************";
	newline;
#end
#if($ticket.isGiftsPlan)
	setAlignment center;
   text "**************************************";
   text "*ESTE DOCUMENTO NO AMPARA LA SALIDA **";
   text "*MERCANCIA DEL ALMACEN, NI SE ACEPTA *";
   text "*DEVOLUCION ALGUNA POR TRATARSE DE UN*";
   text "*  DEPOSITO  A  TERCERO BENEFICIARIO *";
   text "**************************************";
	newline;
#end
endBold;
text "CLIENTE   #formatFecha($date)   $time";

newline;
#if($ticket.transactionType == 1)
	beginBold;
	#if($ticket.cfBarcode)
		text "----------------------------------------";
		text "Código de barras para facturar en el";
		text "kiosco y CF para facturar en la web";
		text "www.liverpool.com.mx";
		newline;
		setAlignment center;
		barcode CODE128 "$ticket.cfBarcode" 70 2 center below;
		newline;
	#end
	endBold;
	#if($ticket.tentativeUsed && $ticket.tentativeAmount)
		text "Por   haber pagado esta compra con  su Tarjeta  de  Crédito  Departamental  o Liverpool Premium  Card obtuvo  un  beneficio adicional, ya incluido en   esta transacción, de $ $ticket.tentativeAmount";
		newline;
	#end
	#if(!($ticket.tentativeUsed) && $ticket.tentativeAmount)
		text "Si hubiera realizado su compra con  su Tarjeta  de  Crédito  Departamental  o Liverpool Premium Card habría obtenido un beneficio adicional de $ #fmtDec($ticket.tentativeAmount)";
		newline;
	#end
	setAlignment center;
	#if($ticket.cfBarcode)
		text "CF: #cfData($ticket.cfBarcode)";	
	#end
	text "----------------------------------------";
	#if($ticket.invoiced)
       text "               FACTURADO                ";
	#end
#end
text "www.liverpool.com.mx";
text "Centro de atención telefónica CAT";
text "De la Cd. de México llame al 52-62-99-99";
text "Del interior sin costo al 01-800-713-5555";

newline;
setAlignment center;
     barcode ITF "$ticket.barcode" 70 2 center below;
newline;
newline;
newline;
newline;
newline;
cutPaperManual;