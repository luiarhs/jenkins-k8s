newline;
#foreach( $item in $ticket.items )
	#parse( "1001/templates/item.vcl" )
#end

#if($ticket.additionalSubType == 120 || $ticket.additionalSubType == 144)
   text "#fmt("%18s %17s", ["Num. segmento", "Importe"] )";
   #foreach( $segment in $accountPayment.segments)
      text "#fmt("      %-12s %17s", ["$segment.segment", "$segment.amount"] )";
   #end
#end

##Etiqueta de marketPlace
#if($ticket.additionalSubType == 148)
	#if($ticket.marketPlaceData)
		setAlignment center; 
		###0=SL --- 1=BT
		###if($ticket.marketPlaceData.marketPlaceType == 0)	
		
		#if($ticket.marketPlaceData.deliveryDate)
		  #if($printerType == "2")
			text "FECHA ESTIMADA DE ENTREGA: $ticket.marketPlaceData.deliveryDate";	
		  #else
			text "**FECHA ESTIMADA DE ENTREGA: $ticket.marketPlaceData.deliveryDate**";	
		  #end		  
		#else		
			text "***FECHA ESTIMADA DE ENTREGA***";
			text "Pronto tendremos la fecha de entrega.";
            text "Da seguimiento en liverpool.com.mx";
		#end
	#end
#end

##Etiqueta de marketPlace POS
#if($ticket.additionalSubType == 162)
	#if($ticket.marketPlaceData)
		setAlignment center;
		#if($ticket.marketPlaceData.newDeliveryDateFirst && $ticket.marketPlaceData.newDeliveryDateSecond)
		  #if($printerType == "2")
			text "ENTREGA PREVISTA: $ticket.marketPlaceData.newDeliveryDateFirst";
			text "ENTREGA FINAL: $ticket.marketPlaceData.newDeliveryDateSecond";
		  #else
			text "**ENTREGA PREVISTA: $ticket.marketPlaceData.newDeliveryDateFirst**";
            text "**ENTREGA FINAL: $ticket.marketPlaceData.newDeliveryDateSecond**";
		  #end
		#else
			text "***FECHA ESTIMADA DE ENTREGA***";
			text "Pronto tendremos la fecha de entrega.";
            text "Da seguimiento en liverpool.com.mx";
		#end
	#end
#end