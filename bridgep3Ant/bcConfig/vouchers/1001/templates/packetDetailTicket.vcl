##Valida si es Paqueteria(117), si es CDI de paqueteria (134) plan (1), si es mesa de regalo (115) plan paqueteria (1), si es marketPlace (148)
#if(!$ticket.listaEuropea && $ticket.nroOrdenPaqueteria && ($ticket.additionalSubType == 117 || ($ticket.additionalSubType == 134 && $ticket.cdiPlanData && $ticket.cdiPlanData.type == 1) || ($ticket.additionalSubType == 115 && $ticket.giftsPlanData.typePlan == 1)) || $ticket.additionalSubType == 148)
    #parse( "1001/templates/shortHeader.vcl")

	#if($ticket.cdiPlanData)
		newline;
		beginBold;
		text "#fmt("NUMERO DE TARJETA CDI: %-s", "$ticket.cdiPlanData.numeroTarjetaCDI")";
		endBold;
	#end
	#if(!$ticket_is_duplicate && (!$ticket.listaEuropea && $ticket.nroOrdenPaqueteria && (($ticket.additionalSubType == 117 || $ticket.additionalSubType == 148) || ($ticket.additionalSubType == 134 && $ticket.cdiPlanData && $ticket.cdiPlanData.type == 1) || ($ticket.additionalSubType == 115 && ($ticket.giftsPlanData && $ticket.giftsPlanData.typePlan == 1)))))
		#if ($ticket.additionalSubType == 117)
			newline;
		#end
		beginBold;
		text "#fmt("No. PEDIDO: %-s", "$ticket.nroOrdenPaqueteria")";
		endBold;
	#end

	newline;

	#foreach ($item in $ticket.items)
		#if(!$item.isVoid() && !$item.voided)
			#if ($item.ownBrand && $item.ownBrand.length() > 0)
				text "$item.ownBrand";
			#end

			text "#fmt("%-18s   %-4s %-3.3s  %s%1s", ["$item.description", "SECC", "$item.merchandiseHierarchy","$item.priceInputTypeIndicator",""] )";

			## Vendido por cantidad, si cantidad esta en 0 no imprime
			#if ($item.qty != "0.00")
		  		text "#fmt("%010s  %11.11s", ["$item.code","*#fmtDecNoSign($item.qty)"])";
			#else
				text "#fmt("%010s  %11.11s", ["$item.code","*1.00"])";
			#end
		#end
	#end

	setAlignment left;		
	text "#fmt("TIPO DE PAGO: %-s", "$ticket.paymentType")";
	newline;

	#if($ticket.additionalSubType == 117)
		text "DESTINATARIO: ________________________";
		newline;
		text "______________________________________";
		newline;
		text "E-MAIL: ______________________________";
		newline;
		text "______________________________________";
	#else
		##debe escribir datos por default si esta habilitada la bandera xxx, falta incluir esa logica
		#if($ticket.giftsPlanData.selectedBeneficiary)
			text "#fmt("DESTINATARIO: %-s", "$ticket.giftsPlanData.selectedBeneficiary")";
		#else
			text "DESTINATARIO: ________________________";		  
		#end
		newline;
		#if($ticket.giftsPlanData.selectedBeneficiaryDelegation)
			text "#fmt("DEL. O MUNICIPIO: %-s", "$ticket.giftsPlanData.selectedBeneficiaryDelegation")";
		#else
			text "DEL. O MUNICIPIO: ____________________";
		#end

		newline;

		#if($ticket.giftsPlanData.selectedBeneficiaryState)
		text "#fmt("ESTADO: %-s", "$ticket.giftsPlanData.selectedBeneficiaryState")";
		#else
			text "ESTADO: ______________________________";
		#end

		newline;

		#if($ticket.giftsPlanData.name)
			text "#fmt("REMITENTE: %-s", "$ticket.giftsPlanData.name $ticket.giftsPlanData.fatherSurname $ticket.giftsPlanData.motherSurname")";
		#else
			text "REMITENTE: ___________________________";
		#end

		newline;

		#if($ticket.giftsPlanData.email)
			text "#fmt("E-MAIL: %-s", "$ticket.giftsPlanData.email")";
		#else
			text "E-MAIL: ______________________________";
		#end
	#end

	newline;
	text "DIRECCION: ___________________________";
	newline;
	text "______________________________________";
	newline;
	text "COLONIA: _____________________________";
	newline;
	text "______________________________________";
	newline;
	text "C.P.: ________________________________";
	newline;
	text "DEL. O MUNICIPIO: ____________________";
	newline;
	text "TELEFONO: ____________________________";
	newline;
	text "ENTRE QUE CALLES: ____________________";
	newline;
	text "______________________________________";
	newline;
	text "______________________________________";
	newline;
	text "NO. DE BULTOS: _______________________";
	newline;
	text "FECHA DE ENTREGA (EFU): ______________";
	newline;
	text "OBSERVACIONES: _______________________";
	newline;
	text "______________________________________";
	newline;
	text "______________________________________";
	newline;

	text "FECHA:   #formatFecha($date)   $time";

	newline;
	beginBold;
	setAlignment center;
	text "**************************************";
	text "**    LA MERCANCIA NO SE SURTIRA    **";
	text "*AUTOMATICAMENTE (APROVISIONAMIENTO),*";
	text "**SE DEBE PROCESAR DESDE TU ALMACEN **";
	text "**************************************";
    newline;
    endBold;

	#if($printerType == "2")
       setCharsPerLine 48;
    #else
       setCharsPerLine 38;
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

	cutPaper 90;
	setFontSize normal;
#end