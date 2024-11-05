newline;

#set ($imprimeCF = true);
#set ($socialReason = false);
#set ($rfc = false);
#set ($email = false);
#set ($phone = false);

#if ($ticket.creditNumberHipotecaVerde)
   setAlignment left;
   text "CREDITO INFONAVIT: $ticket.creditNumberHipotecaVerde";
   #if ($ticket.motivoHipotecaVerde)
      #if ($ticket.motivoHipotecaVerde=="0")
         text "Tarjeta virtual";
      #else
         text "Constancia";
      #end
   #end
   newline;
#end

#if($ticket.additionalSubType == 102 || $ticket.additionalSubType == 123)
   setAlignment left;
	   
   #if($ticket.somsOrderData.deliveryNumber > 0 && $ticket.somsOrderData.deliveryType && $ticket.somsOrderData.deliveryType == 1)
      setCharsPerLine 48;
	  text "***********************************************";
      text "En esta fecha hago compra del producto";
      text "especificado en este documento el cual se me";
      text "informó que es bajo pedido y acepto entrar en";
      text "fila de espera con el no. $ticket.somsOrderData.deliveryNumber con tiempo";           
      text "máximo de entrega de 90 días hábiles.";
      text "Firmé copia del presente.";
      text "***********************************************";
      newline;
   #end
   setCharsPerLine 44;
   beginBold;
	   text "********************************************";
       text "  EL CLIENTE ACEPTA LA COMPRA BAJO PEDIDO   ";
       text "DEBIENDO REALIZAR LOS PAGOS DE LA MERCANCIA ";
       text "  CON INDEPENDENCIA DE LA FECHA DE ENTREGA  ";
       text "********************************************";
   endBold;
   newline;
#end

#if($ticket.additionalSubType == 107 || $ticket.additionalSubType == 110)
   setAlignment center;
      
   beginBold;
		text "ESTE TICKET NO AMPARA MERCANCIA";
   endBold;
   newline;
#end									

#if($ticket.transactionType == 2 || $ticket.isGiftsPlan)
    #if($ticket.additionalSubType != 122)
	      setAlignment center;
  	    beginBold;
  	    #if($vale && $vale.vale)
  	    	text "**************************************";
    	  	text "* ESTE DOCTO ES VALIDO PARA COMPRAS  *";
    	  	text "**************************************";
			
	      #else
    	  	text "*ESTE DOCTO NO ES VALIDO PARA COMPRAS*";
    	  #end
    	endBold;     	  
    	setAlignment left;
		#if(!$duplicateAg)
			newline;
			#parse( "1001/templates/signature.vcl" )
    #end
		setAlignment center;
		newline;
		beginBold; 
		  #if ($ticket.additionalSubType == 138)
		     text "ESTE TICKET NO AMPARA MERCANCIA";
		     newline;
		  #end
      	endBold;

    #end

#end

#if($ticket.nroOrdenPaqueteria)
    text "**************************************";
    setAlignment center;
	#set($lblOptionOmnicanal = "")
	### 0 = Click and Collect,  1 = Envio a Domicilio
	#if($ticket.optionSelectedOmnicanal) 
		#if($ticket.optionSelectedOmnicanal == 0)
			#set($lblOptionOmnicanal = " C&C")
		#else
			#set($lblOptionOmnicanal = " ED")
		#end
	#end

	#if($ticket.optionSelectedMarketplacePos)
    	#if($ticket.optionSelectedMarketplacePos == 0)
    		#set($lblOptionOmnicanal = " C&C")
    	#else
    		#set($lblOptionOmnicanal = " ED")
    	#end
    #end
	
    text "#fmt("       No. PEDIDO$lblOptionOmnicanal:  %-s", "$ticket.nroOrdenPaqueteria")";
    text "**************************************";
    newline;
#end

#if($ticket.additionalSubType == 119 || $ticket.additionalSubType == 120 || $ticket.additionalSubType == 143 || $ticket.additionalSubType == 144)
    setAlignment left;
    text "**************************************";
    beginBold;
		   #if($notSecureAccount == "true")
	        text "#fmt("ABONO A: %-20s", "$accountPayment.account" )";
	     #else
	        text "#fmt("ABONO A: %-20s", "#maskAcc($accountPayment.account)" )";
	     #end
    endBold;
    #if($accountPayment.accountName)
        text "NOMBRE: $accountPayment.accountName";
    #end
    #if($accountPayment.authorizationCode)
        text "#fmt("1  AUTORIZACION: **%-8s**", $accountPayment.authorizationCode )";
    #end
    text "**************************************";
#end

#if($ticket.additionalSubType == 119 || $ticket.additionalSubType == 120)
	#set($hideLblDate = true)
	#parse("1001/templates/balance.vcl")
	newline;
#end

## Tarjetas prepago
#foreach( $itemTicketLiverpoolData in $ticket.items )
    #if($itemTicketLiverpoolData.prepaidCardCode)
       #if ($itemTicketLiverpoolData.group == "063352")
         text "#center("******     TARJETAS  INCOMM    ******")";
       #else
       	 text "#center("******    TARJETAS BLACKHAWK   ******")";
       #end
        text "UPC: $itemTicketLiverpoolData.prepaidCardCode.substring(0,12)    PRECIO: $$itemTicketLiverpoolData.originalExtendedPrice";
        text "#maskAcc($itemTicketLiverpoolData.prepaidCardCode.substring(12))   AUT: $itemTicketLiverpoolData.BhAuthorizationCode";
        #if($itemTicketLiverpoolData.prepaidCardOfLine)
            text "#center("F/L PARA ACTIVACIÓN EN 24 HORAS")";
        #end
        text "*************************************";
		newline;
    #end
#end

#if($ticket.additionalSubType == 127)
    setAlignment left;
    text "**************************************";
    text "#fmt("CONFIRMACION: %-20s", "$ticket.confirmationId")";
    text "#fmt("TELEFONO: %-20s", "$ticket.phoneNumber")";
    text "**************************************";

	   
    #foreach ($descriptor in $ticket.descriptors)
  
    	setCharsPerLine 48;
    	setFontSize normal;
    	beginBold;
    	  newline;
		    text "$descriptor";
		  endBold;
	  #end
	  newline;
#end

#if($ticket.additionalSubType == 136 && $ticket_is_duplicate)
   beginBold;
      setAlignment left;
      text "#fmt("ID  CLIENTE: %s", "$service.serviceReferenceNumber" )";
      newline;
      text "Nombre Sr./Sra.: _____________________";
      text "______________________________________";
      newline;
      text "Recibí la cantidad de: $________ pesos";
      text "En Monedero Electrónico.              ";
      newline;
      text "Firma ________________________________";
   endBold;
#end 
#if($ticket.additionalSubType == 139)
        setAlignment left;
        text "**************************************";
        #if($ticket.datosCentroServ)
        setAlignment left;
        text "#divStr($esc.java($ticket.datosCentroServ), 38 )";
        text "**************************************";
    #end 
    #if($ticket.datosCliente)
    	setAlignment left;
        text "#divStr($ticket.datosCliente, 38 )";
        text "**************************************";
        newline;
    #end 
#end 
#if($ticket.additionalSubType != 122)
   beginBold;
      setAlignment center;
      #if($ticket.additionalSubType == 136)
         #if($ticket_is_duplicate)
            newline;
            text "   CONSERVAR PARA CONTROL DE TIENDA   ";
           #else
              text "Gracias por su pago!";
           #end
      #else
        ##newline;
        #if($ticket.additionalSubType == 118 || $ticket.additionalSubType == 119 || $ticket.additionalSubType == 120 || $ticket.additionalSubType == 141 || $ticket.additionalSubType == 143 || $ticket.additionalSubType == 144)
             text "Gracias por su pago!";
        #else
            #if($ticket.emailForDownloadableItem)
                endBold;
                setAlignment left;
                #if($ticket.codeDownloadableItem)
					beginBold;
                    text "Su código descargable es: $ticket.codeDownloadableItem";
					text "Para redimirlo siga los siguientes pasos:";
					text "1.- Ingrese a liverpool.com.mx";
					text "2.- Click en Ayuda";
					text "3.- Click en Preguntas frecuentes";
					text "4.- Click en Productos descargables";
					endBold;
                    newline;
                    text "Descarga digital, recuerda que en compras digitales no contamos con cambios ni devoluciones.";
                    text "Productos descargables es un bien no físico creado con unos sistemas informáticos o tecnologías de la información los cuales por naturaleza son de entrega virtual y mediante códigos o links para descarga, los cuales serán enviados mediante el correo electrónico que fue proporcionado durante el proceso de compra.";
                #else
                    text "Se produjo un error al generar su código, por favor, comuníquese a los teléfonos del Centro de Atención Telefónica que se muestran al pie del ticket";
                #end
                newline;
                beginBold;
                setAlignment center;
            #end

			#if ($ticket.additionalSubType == 101)
				#foreach ($item in $ticket.items)
					#if ($item.code == "1126509525")
						text "No aplica para cambios ni devoluciones";
						newline;
					#end
				#end
			#end

			#if ($ticket.transactionType == 1)
				#foreach ($item in $ticket.items)
					#if ($item.supplier == "0000158529")
						#set ($socialReason = "Troquer Fashion S.A.P.I. de C.V.");
						#set ($rfc = "TFA1304188T3");
						#set ($email = "contacto@troquer.com.mx");
						#set ($phone = "55 5351 4488");
						#set ($imprimeCF = false);
					#elseif ($item.supplier == "0000160465")
						#set ($socialReason = "TRENDIER MEXICO, S.A. DE C.V.");
						#set ($rfc = "TME161021SL0");
						#set ($imprimeCF = false);
					#end
				#end
				endBold;
				setAlignment left;
				#if ($socialReason && $rfc && $email && $phone)
					text "La presente venta es realizada por $socialReason con RFC $rfc, quien es responsable de esta operación. Para generar la factura comunícate por correo electrónico a $email o al teléfono $phone. Distribuidora Liverpool S.A. de C.V. únicamente brinda la infraestructura para la realización de esta operación";
					newline;
				#elseif ($socialReason && $rfc)
					text "La presente venta es realizada por $socialReason con RFC $rfc, quien es responsable de esta operación. Distribuidora Liverpool S.A. de C.V. únicamente brinda la infraestructura para la realización de esta operación";
					newline;
				#end
				beginBold;
				setAlignment center;
			#end
			
			#if ($ticket.additionalSubType == 107 || $ticket.additionalSubType == 109 || (($ticket.additionalSubType == 101 || $ticket.additionalSubType == 102) && $ticket.polizaSeguro))
				#foreach ($item in $ticket.items)
					#if ($item.supplier == "0004200476")
						#set ($socialReason = "VIAJES EL CORTE INGLÉS SA DE CV");
						#set ($rfc = "VCI0004041R0");
						#set ($email = "facturas@viajeseci.com.mx");
						#set ($phone = "55 2122 2780");
					#elseif ($item.supplier == "0000099520")
						#set ($socialReason = "VENTA DE BOLETOS POR COMPUTADORA, SA DE CV");
						#set ($rfc = "VBC9106175R1");
						#set ($email = "facturaciontm@ticketmaster.com.mx");
						#set ($phone = "55 5325 9000");
					#elseif ($item.supplier == "0000149581")
						#set ($socialReason = "DESPEGAR.COM MEXICO, SA DE CV");
						#set ($rfc = "DCM000125IY6");
					#elseif ($item.supplier == "0000130088")
						#set ($socialReason = "AIG SEGUROS MEXICO SA DE CV");
						#set ($rfc = "CSM960528CC4");
					#elseif ($item.supplier == "0005604153")
						#set ($socialReason = "ANA COMPAÑÍA DE SEGUROS SA DE CV");
						#set ($rfc = "ANA9509086E3");
					#elseif ($item.supplier == "0004201281")
						#set ($socialReason = "GRUPO NACIONAL PROVINCIAL SAB");
						#set ($rfc = "GNP9211244P0");
					#elseif ($item.supplier == "0000152640")
						#set ($socialReason = "HDI SEGUROS SA DE CV");
						#set ($rfc = "HSE701218532");
					#elseif ($item.supplier == "0004200531")
						#set ($socialReason = "CHUBB SEGUROS MEXICO SA");
						#set ($rfc = "ASE901221SM4");
					#elseif ($item.supplier == "0004200286" || $item.supplier == "0004200287" || $item.supplier == "0004200491" || $item.supplier == "0004200492" || $item.supplier == "0004200526")
						#set ($socialReason = "QUALITAS COMPAÑÍA DE SEGUROS SA DE CV");
						#set ($rfc = "QCS931209G49");
					#elseif ($item.supplier == "0000153335")
						#set ($socialReason = "ASSURANT SA DE CV");
						#set ($rfc = "ASS180119A20");
					#elseif ($item.supplier == "0005607509")
						#set ($socialReason = "AWP MEXICO SA DE CV");
						#set ($rfc = "MAM070727KM5");
					#elseif ($item.supplier == "0005607509")
						#set ($socialReason = "GARANPLUS SA DE CV");
						#set ($rfc = "GAR0310218S9");
					#end
				#end
				endBold;
				setAlignment left;
				#if ($socialReason && $rfc && $email && $phone)
					text "La presente venta es realizada por $socialReason con R.F.C. $rfc quien es responsable de esta operación. Para facturar, escribe a $email o en el número telefónico $phone. Distribuidora Liverpool, S.A. de C.V. únicamente brinda la infraestructura para la realización de esta operación";
				#elseif ($socialReason && $rfc)
					#if ($ticket.additionalSubType == 107)
						text "La presente venta es realizada por $socialReason con R.F.C. $rfc quien es responsable de esta operación y de la expedición, en su caso, del Comprobante fiscal correspondiente mismo que deberá solicitarse exclusivamente al momento de la compra. Distribuidora Liverpool, S.A. de C.V. únicamente brinda la infraestructura para la realización de esta operación";
					#else
						text "La presente venta es realizada por PROMASS, agente de seguros, operación que realiza por cuenta y orden de la aseguradora $socialReason con R.F.C. $rfc quien es responsable de esta operación y de la expedición del comprobante fiscal correspondiente, que puede solicitar directamente en cualquier Oficina de Seguros del almacén. DILISA únicamente brinda la infraestructura para la realización de esta operación";
					#end
				#end
				newline;
				beginBold;
				setAlignment center;
			#end
            #if($ticket.infoGugaData && $ticket.additionalSubType == 154)
                text "Gracias por su pago!";
                newline;
                endBold;
                setAlignment left;
                #if($ticket.infoGugaData.conEtiqueta)
                    #foreach ($datoIm in $ticket.infoGugaData.conEtiqueta)
                	    text "$datoIm";
       			    #end
       			#end
                newline;
                #if($ticket.infoGugaData.imprimeSinEtiqueta)
                    text "$ticket.infoGugaData.imprimeSinEtiqueta";
                #end
                newline;
                #if($ticket.infoGugaData.idGuga)
                    text "#fmt("ID: %-s", "$ticket.infoGugaData.idGuga")";
                #end
                #if($ticket.infoGugaData.leyendaGuga)
                    text "$ticket.infoGugaData.leyendaGuga";
                #end
                newline;
                beginBold;
                setAlignment center;
            #end
            #if($ticket.bitmapWarrantyQR)
				#if($printerType == "7")
                	beginBold;
       				setAlignment center;
                    text "$ticket.legendMasGarantia";
                    endBold;
   			    	barcode ITF "$ticket.bitmapMasGarantia" 50 2 center none;
                    newline;
                    barcode ITF "$ticket.valueWarrantyQR" 50 2 center none;
                    newline;
                #else
					#if ($ticket.digitalTicket)
  				       beginBold;
                       setAlignment center;
                       text "$ticket.legendMasGarantia";
                       endBold;
   					   text "$ticket.valueWarrantyQR";
					#else
                	   setAlignment center;
   				       beginBold;
                	   text "$ticket.legendMasGarantia";
                	   endBold;
					   newline;
                	   bitmap "$ticket.bitmapMasGarantia" left;
   					   bitmap "$ticket.bitmapWarrantyQR" left;
					#end
				#end
   			#end
   			beginBold;
			#if ($ticket.infoCare)
				#foreach ($datoIm in $ticket.infoCare)
					text "$datoIm";
				#end
				newline;
			#end
            setAlignment center;
            text "Gracias por su visita!";
            endBold;
        #end
      #end
   endBold;

   #if($ticket.additionalSubType == 115 || $ticket.giftsPlanData.typeElectronicGift == 1)
     newline;
     setFontSize normalB;
     setAlignment center;
     beginBold;
     text "Esta boleta no garantiza la";
     text "bonificación, sujeta a secciones";
     text "participantes de Mesa de Regalos";
     endBold;
     setFontSize normal;
   #end
   newline;
   #if($ticket.nroOrdenPaqueteria || ($ticket.additionalSubType == 162) || ($ticket.additionalSubType == 115 && ($ticket.giftsPlanData.typePlan == 1 || $ticket.giftsPlanData.typePlan == 4 || $ticket.giftsPlanData.typePlan == 5)))
    #if($ticket.additionalSubType == 162)
        beginBold;
           setAlignment center;
                text "**************************************";
                text "**ESTE DOCUMENTO NO AMPARA LA SALIDA**";
                text "**DE MERCANCIA DEL ALMACEN          **";
                text "**LO INVITAMOS A DARLE SEGUIMIENTO  **";
                text "**A SU PEDIDO EN                    **";
                text "**WWW.LIVERPOOL.COM.MX              **";
                text "**************************************";
            newline;
        endBold;
     #else
		beginBold;
			setAlignment center;
				text "**************************************";
				text "**ESTE DOCUMENTO NO AMPARA LA SALIDA**";
				text "**    DE MERCANCIA DEL ALMACEN      **";
			#if($ticket.listaEuropea)
				text "**               P  C               **";
			#end
			#if($ticket.virtualSplit)
				text "**               R  E               **";
			#end        
				text "**************************************";
			newline;
		endBold;
     #end
   #end
   
   #if($ticket.paqueteriaOffLine)
   		beginBold;
        setAlignment center;
		    text "**************************************";
		    text "**   ESTA REMISION SE DARA DE ALTA  **";
		    text "**AUTOMATICAMENTE EL DIA DE MAÑANA  **";        
		    text "**************************************";
        newline;
      endBold;
   #end

   #if($ticket.transactionType != 2 && $ticket.somsOrderData.printNoAmpara)
     beginBold;
        setAlignment left;
        setCharsPerLine 44;
		text "********************************************";
		text "**   ESTE DOCUMENTO NO AMPARA LA SALIDA   **";
		text "**        DE MERCANCIA DEL ALMACEN        **";
		text "********************************************";
        newline;
      endBold;
   #end

   #if ($ticket.additionalSubType == 115 && $ticket.giftsPlanData.typePlan == 2)
      beginBold;
		setAlignment center;
		text "**************************************";
		text "* ESTE DOCUMENTO NO AMPARA LA SALIDA *";
        text "* MERCANCÍA DEL ALMACEN NI SE ACEPTA *";
        text "*DEVOLUCIÓN ALGUNA POR TRATARSE DE UN*";
        text "*  DEPÓSITO A TERCERO BENEFICIARIO   *";
        text "**************************************";
        newline;
      endBold;
   #end

   ##Etiqueta de marketPlace
   #if ($ticket.additionalSubType == 148 || $ticket.additionalSubType == 162)
	  #set ($imprimeCF = false);
	  #if ($ticket.marketPlaceData)
         #if ($ticket.marketPlaceData.mkpSL)
            setAlignment center;
            text "**SURTIDO Y ENTREGADO POR $ticket.marketPlaceData.sellerVendorName **";
         #else
            setAlignment center;
            text "** VENDIDO POR $ticket.marketPlaceData.sellerVendorName **";
         #end
		 text "PROVEEDOR DE LIVERPOOL";
		 newline;
	  #end
	#end
   
   setCharsPerLine 44;
   #if($ticket.additionalSubType == 136 && $ticket_is_duplicate)
      text "#fmt("TIENDA: %5s %s %s", [" ","#formatFecha($date)",$time])";
   #else
      text "CLIENTE     #formatFecha($date) $time";
	  newline;
   #end
   #if($printerType == "2")
       setCharsPerLine 48;
   #else
       setCharsPerLine 38;
   #end
#else
	 #if ($ticket.somsOrderData.printNoAmpara)
        beginBold;
          setAlignment center;
   		    text "**************************************";
		      text "**ESTE DOCUMENTO NO AMPARA LA SALIDA**";
		      text "**    DE MERCANCIA DEL ALMACEN      **";
		      text "**************************************";
          newline;
        endBold;
     #end
#end

#if ($ticket.transactionType == 1 && $ticket.nonBillableWalletPrefix)
   newline;
   beginBold;
   text "NO FACTURABLE";
   endBold;
#end

#if ($ticket.transactionType == 1 && $ticket.additionalSubType != 127)
   #if ($imprimeCF == true && ($ticket.facturable && ($ticket.cfBarcode || ($ticket.additionalSubType == 136 && $ticket_is_duplicate))))
      beginBold;
      #if ($ticket.additionalSubType != 136)
         text "--------------------------------------";
      #end
      endBold;
      setAlignment center; 
      #foreach ($descriptionLine in $descriptionData.invoiceDescriptions)  
		#if ($descriptionLine.printingType == 'TH')
           setFontSize wideB;
        #else 
           #if ($descriptionLine.printingType == 'TH2')
              setFontSize highB;
           #else
              setFontSize normal;
           #end;
        #end;
        beginBold;
        text "$descriptionLine.description";
        newline;
        endBold;
      #end 
      setFontSize normal;
      #if ($ticket.cfBarcode)
		 beginBold;
         text "#underlineNumber("$ticket.cfBarcode", 5, " ")";
		 setFontSize normal;
         barcode Code93 "$ticket.cfBarcode" 50 2 center none;
		 endBold;
         newline;
      #end
   #end
    
    #if($ticket.invoiced)
       setAlignment center;
       beginBold;
         text "Facturación en proceso,";
         text "favor de validar en 72 hrs.";
       endBold;
       newline;
    #end
														 
    #if(!$ticket_is_duplicate)
      beginBold;
        #if ($descriptionData.trailerUrl != "")
           text "$descriptionData.trailerUrl";
        #end;
      
        text "$descriptionData.trailerLabel";
        text "$descriptionData.trailerTelephone";
      endBold;
    #end
    
    #if ($ticket.tentativeUsed && $ticket.tentativeAmount && !$ticket.isSuggestedAcceptedHipotecaVerde())
       #if($printerType == "2")
           setCharsPerLine 48;
       #else
           setCharsPerLine 38;
       #end
       newline;
       beginBold;
         text "Por haber pagado esta compra con su Tarjeta de Crédito Departamental o Liverpool Premium Card obtuvo un beneficio adicional, ya incluido en esta transacción, de $ $ticket.tentativeAmount";
	   endBold;
       newline;
    #end
	
    #if (!($ticket.tentativeUsed) && $ticket.tentativeAmount)
       #if($printerType == "2")
           setCharsPerLine 48;
       #else
           setCharsPerLine 38;
       #end
       newline;
       beginBold;
         text "Si hubiera realizado su compra con su Tarjeta de Crédito Departamental o Liverpool Premium Card habría obtenido un beneficio adicional de $ $ticket.tentativeAmount";
       endBold;
       newline;
    #end

	#if ($ticket.isSuggestedAcceptedHipotecaVerde() && $ticket.creditNumberHipotecaVerde)
	  setCharsPerLine 48;
	  newline;
	  beginBold;
         text "Esta compra está sujeta a los términos y condiciones del Programa de Hipoteca Verde, puedes consultarlas en nuestra página web";
	  endBold;
	  newline;
	#end
	
    setCharsPerLine 48;

      #if($ticket.additionalSubType != 136)
         #if(!$duplicate)
           #if ($ticket.additionalSubType != 118 && $ticket.additionalSubType != 107 && $ticket.additionalSubType != 141 && $ticket.additionalSubType != 143 && $ticket.additionalSubType != 144)
             barcode ITF "$ticket.barcode" 50 2 center none;
			 #if($printerType == "7")
                newline;
                newline;
                newline;
                newline;
             #end
           #end
         #elseif($ticket.transactionDolar)
           newline;
           newline;
           setFontSize highWideB;
           text "* *  C O P I A  * *";
           setFontSize normal;
         #end
      #end			
#end

#if($ticket.transactionType == 5 || $ticket.additionalSubType == 105 || $ticket.additionalSubType == 121 || $ticket.additionalSubType == 129 || $ticket.additionalSubType == 132 || $ticket.additionalSubType == 135 || $ticket.additionalSubType == 138 || $ticket.additionalSubType == 149)
   beginBold;
   text "$descriptionData.trailerLabel";
   text "$descriptionData.trailerTelephone";
   endBold;
#end  
#if($ticket.transactionType == 1 && $ticket.additionalSubType == 127)
	beginBold;
   	text "$descriptionData.trailerLabel";
   	text "$descriptionData.trailerTelephone";
   	endBold;
    
    #if ($duplicate)
      newline;   
      setFontSize wideB;
      text "** C O P I A **"; 
    #else
      barcode ITF "$ticket.barcode" 50 2 center none;
    #end
#end

## No quitar este newline, se rompe la impresión en Linux
newline;
#if($printerType == "2")
    setCharsPerLine 48;
#else
    setCharsPerLine 38;
#end

## Muestra leyenda de copia en ticket adicional de disposicion de efectivo
#if($duplicate && $ticket.additionalSubType == 110)
   newline;   
   setFontSize wideB;
   text "** C O P I A **";
#end

## Muestra leyenda de garantia PIF
#if($pifWarrantyMessage)
    text "--------------------------------------";
    setFontSize normal;
    beginBold;
    	text "$pifWarrantyMessage";
    endBold;
#end

#if($messageWarrantyAssurance && (($virtualSplitSegurosOrig && $splitTicket && "$splitTicket.transactionTitle" == "SEGUROS") || !($virtualSplitSegurosOrig)))
    text "--------------------------------------";
    setFontSize normal;
    beginBold;
    	text "$messageWarrantyAssurance";
    endBold;
#end

cutPaper 90;
setFontSize normal;