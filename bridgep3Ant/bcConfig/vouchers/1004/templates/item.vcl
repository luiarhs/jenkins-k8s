#set ($voiding = "$item.isVoid()")
#set ($returning = "$item.isReturned()")
#set ($sign = "#gSign($returning $voiding)")
#set ($letter = "#gLet($returning $voiding)")
#if($letter != "")
   #set($isLetter = "-$letter")
#else
   #set($isLetter = "")
#end
			#if ($ticket.additionalSubType == 110)
			text "#fmt("REFERENCIA: %-s", "$ticket.employeeAccount")";
			text "$ticket.serviceKey $item.description";
			#end
#if($ticket.additionalSubType == 111)
	text "REFERENCIA: $service.serviceWalletNumber";
	text "CAPTURA: $service.serviceReferenceNumber";
	text "#fmt("%-5.5s  %25.25s", ["$service.serviceKey", "$service.serviceName"] )";
	text "#fmt("%-25.25s %10.10s", ["$service.serviceDescription", "#fmtDec($ticket.total)"] )";
#elseif($ticket.additionalSubType == 107 || $ticket.additionalSubType == 138)
	text "REFERENCIA: $service.serviceReferenceNumber";
	#if ( $service.isAgencyBSP())
			   text "CAPTURA: $service.serviceCaptura";
	#end
	text "#fmt("%4.4s %1s", ["$service.serviceKey", "$service.serviceName"] )";
	text "#fmt("%1.20s %15s", ["$service.serviceDescription", "#fmtDec($ticket.subtotal)"] )";
#else

	#if($item.ownBrand && $item.ownBrand.length() > 0 && $item.merchandiseHierarchy != 633 && $item.merchandiseHierarchy != 640 && $item.merchandiseHierarchy != 910 && $ticket.additionalSubType != 109 && $ticket.additionalSubType != 110 && $ticket.additionalSubType != 127 && $ticket.additionalSubType != 137 && $ticket.additionalSubType != 139)
		text "$item.ownBrand";
	#end

   ## Items anulados no se imprimen
	#if(!($item.isVoid()))	
     #if($ticket.additionalSubType == 137 && $ticket.tariffPlan)
				text "#fmt("%-18.18s   %-4.4s %-3.3s  %s%1s", ["$ticket.tariffPlan.descripcionMaestro", "SECC", "$ticket.tariffPlan.grupoPlan","$ticket.tariffPlan.priceInputTypeIndicator","$isLetter"] )";
     #elseif($ticket.additionalSubType == 109 || ($ticket.transactionType == 2 && $ticket.poliza))
        text "#fmt("%-18s   %-4s %-3.3s  %s%1s", ["$item.description", "SECC", "$item.merchandiseHierarchy","$item.priceInputTypeIndicator",""] )";
        #if($item.crediAssurance)
         text "CREDISEGURO";
        #end  
     #elseif($ticket.additionalSubType == 110)
         text "#fmt("%-18s      %11.11s%1s", ["$item.description", "#fmtDec($item.originalExtendedPrice $sign)","$letter"] )";
     #else
         text "#fmt("%-18s   %-4s %-3.3s  %s%1s", ["$item.description", "SECC", "$item.merchandiseHierarchy","$item.priceInputTypeIndicator",""] )";
     #end
  
	   #if($ticket.giftsPlanData.typeElectronicGift > 0)
	   	#if($item.qty == "1.00")
	   		text "#fmt("%-12.12s                %11.11s%1s", ["#fmtLft($item.code,12)", "#fmtDec($item.originalExtendedPrice $sign)","$letter"] )";
	   	#end
	   	#if($item.qty != "1.00" && $item.qty != "0.00")
	   		text "#fmt("%-12.12s %14.14s %11.11s%1s", ["#fmtLft($item.code,12)","#fmtDecNoSign($item.actualUnitPrice)*#fmtDecNoSign($item.qty)", "#fmtDec($item.originalExtendedPrice $sign)","$letter"])";
	   	#end
	   #else
	   #if($ticket.additionalSubType != 110)
        #if($ticket.additionalSubType != 136)
         ## Articulos por Peso
         #if($item.magnitude)

	   		#if($item.magnitude == 1)
	   			text "#fmt("%010s                %11.11s%1s", ["$item.code", "#fmtDec($item.originalExtendedPrice $sign)","$letter"] )";
	   		#else
	   			text "#fmt("%010s %14.14s %11.11s%1s", ["$item.code","#fmtDecNoSign($item.actualUnitPrice)*#fmtDecNoSign($item.magnitude)", "#fmtDec($item.originalExtendedPrice $sign)","$letter"])";
	   		#end

         #else
	   	   ## No se vendio por cantidad
	   	   #if($item.qty == "1.00")
		   	    #if($ticket.additionalSubType == 137 && $ticket.tariffPlan)
	            text "#fmt("%-10.10s                %11.11s%1s", ["#fmtLft($ticket.tariffPlan.skuPlan,10)", "#fmtDec($item.originalExtendedPrice $sign)","$letter"] )";
	          #else
		   	   	  text "#fmt("%010s                %11.11s%1s", ["$item.code", "#fmtDec($item.originalExtendedPrice $sign)","$letter"] )";
		   	   	#end
	   	   #else
	   	      ## Vendido por cantidad, si cantidad esta en 0 no imprime
	   	      #if($item.qty != "0.00")
	   	      	text "#fmt("%010s %14.14s %11.11s%1s", ["$item.code","#fmtDecNoSign($item.actualUnitPrice)*#fmtDecNoSign($item.qty)", "#fmtDec($item.originalExtendedPrice $sign)","$letter"])";
	   	      #end
	   	   #end
	   	#end
        #else
			newline;
	   #end
	   #end
	   #end
		#set ($sign = "#ngt($sign)")

		#foreach( $discountData in $item.discounts )
			#if($discountData.promo)
               #foreach( $description in $discountData.descriptions)
                  #if($discountData.type == 2)
                        text "#fmt("%18.18s %1s%6.6s%11.11s", [$description, "%", "#fmtDecNoSign($discountData.percent)","#fmtDec($discountData.discount $sign)"])";
                  #end
				  #if($discountData.type == 1)
                     	text "#fmt("%18.18s %1s      %11.11s", [$description, "$", "#fmtDec($discountData.discount $sign)"])";
         		  #end
               #end
           #else    
              #if($ticket.additionalSubType == 136)
                 text "#fmt("%18s %6s%1s %11s", ["DESC POR CONVENIO", "#fmtDecNoSign($discountData.percent)", "%" ,"#fmtDec($discountData.discount $sign)"])";   
              #else
                 #if($discountData.type == 1)
                    text "#fmt("%18.18s %1s      %11.11s", ["REBAJA ", "$", "#fmtDec($discountData.discount $sign)"])";   
                 #elseif ( $discountData.type == 2 )
                    #set ($rc = "AutomaticDiscount")
                    #if($discountData.reasonCode && $discountData.reasonCode == $rc )
                        text "#fmt("%18.18s %1s      %11.11s", ["DESC TDA FRONTERIZ ", "$", "#fmtDec($discountData.discount $sign)"])";
                    #else
                        text "#fmt("%18.18s %1s%6.6s%11.11s", ["REBAJA ", "%", "#fmtDecNoSign($discountData.percent)","#fmtDec($discountData.discount $sign)"])";
                    #end
                 #end
              #end
           #end
		#end
		
		##Se agregan descuentos prorrateados
        #if($item.proratedDiscountsTotal)
        	#foreach( $discountProratedData in $item.proratedDiscountsTotal )
        		text "#fmt("%-21s       %8s%1s", ["$discountProratedData.description", "#fmtDec($discountProratedData.discountAmountTlog $sign)","$letter"] )";
        	#end
        #end
		
        #if($ticket.additionalSubType == 137 && $ticket.tariffPlan)
        	newline;
			    text "**************************************";
			    newline;
			    text "Tel�fono celular asignado al plan";
			    text "$item.code";
			    text "$item.description";
			    newline;
		      text "**************************************";
        #end

		#if($item.paymentPlanList)
			#foreach( $paymentPlan in $item.paymentPlanList )
				text "#center($paymentPlan)";
			#end
		#end

		#if($item.monederoBenefits)
			#foreach( $benefitData in $item.monederoBenefits )
				text "#center($benefitData.description)";
			#end
		#end

      ## Si el item esta anulado, grabamos su anulacion seguida de este
      #if($item.isVoided())

         #set ($letter = "C")
         #set ($isLetter = "-C")
         text "#fmt("%-18.18s   %-4.4s %-3.3s  %s%1s", ["$item.description", "SECC", "$item.merchandiseHierarchy","$item.priceInputTypeIndicator","$isLetter"] )";

         #if($item.qty == "1.00" && !($item.magnitude))
	   		text "#fmt("%-10.10s                %11.11s%1s", ["#fmtLft($item.code,10)", "#fmtDec($item.originalExtendedPrice $sign)","$letter"] )";
	   	#end
	   	#if($item.qty != "1.00" && $item.qty != "0.00")
	   		text "#fmt("%-10.10s %14.14s %11.11s%1s", ["#fmtLft($item.code,10)","#fmtDecNoSign($item.actualUnitPrice)*#fmtDecNoSign($item.qty)", "#fmtDec($item.originalExtendedPrice $sign)","$letter"])";
	   	#end
	   	#if($item.magnitude)
	   		#if($item.magnitude == 1)
	   			text "#fmt("%-10.10s                %11.11s%1s", ["#fmtLft($item.code,10)", "#fmtDec($item.originalExtendedPrice $sign)","$letter"] )";
	   		#else
	   			text "#fmt("%-10.10s %14.14s %11.11s%1s", ["#fmtLft($item.code,10)","#fmtDecNoSign($item.actualUnitPrice)*#fmtDecNoSign($item.magnitude)", "#fmtDec($item.originalExtendedPrice $sign)","$letter"])";
	   		#end
	   	#end

      #end

	#end

#end

#if($ticket.transactionType != 112 && $ticket.additionalSubType == 107 || $ticket.additionalSubType == 138)
	#if(!($item.isVoid()))
		#set ($sign = "#ngt($sign)")
		#foreach($discountData in $item.discounts )
			#if($discountData.promo)
               #foreach( $description in $discountData.descriptions)
                  #if($discountData.type == 2)
                        text "#fmt("%18.18s %1s%6.6s%11.11s", [$description, "%", "#fmtDecNoSign($discountData.percent)","#fmtDec($discountData.discount $sign)"])";
                  #end
				  #if($discountData.type == 1)
                     	text "#fmt("%18.18s %1s      %11.11s", [$description, "$", "#fmtDec($discountData.discount $sign)"])";
         		  #end
               #end
           #else
				#if($discountData.type == 1)
					text "#fmt("%18.18s %1s      %11.11s", ["REBAJA ", "$", "#fmtDec($discountData.discount $sign)"])";
				#elseif ($discountData.type == 2)
				  text "#fmt("%18.18s %1s%6.6s%11.11s", ["REBAJA ", "%", "#fmtDecNoSign($discountData.percent)","#fmtDec($discountData.discount $sign)"])";
				#end
			#end
		#end
	#end
	#if($item.proratedDiscountsTotal)
 		#foreach( $discountProratedData in $item.proratedDiscountsTotal )
 			text "#fmt("%-21s       %8s%1s", ["$discountProratedData.description", "#fmtDec($discountProratedData.discountAmountTlog $sign)","$letter"] )";
 		#end
  #end
#end
#if($item.somsDeliveryDate && !$item.itemWarranty)
    text "Entrega prevista: #formatFecha($item.somsDeliveryDate)";
#end
#if($item.somsDeliveryLastDate && !$item.itemWarranty)
    text "Entrega fecha final: #formatFecha($item.somsDeliveryLastDate)";
#end

#if($ticket.additionalSubType == 101 && $ticket.ticketVoidFlag && $ticket.employeeAccount &&  $item.promotions)
    #foreach( $benefitData in $item.promotions )
         text "#fmt("%26.26s%10.10s%1s", ["$benefitData.printerMessage", "$benefitData.value","-"] )";
    #end
#end

#if($item.cellPhone)
	text "IMEI: $item.imei";
	#if($item.lineNumber)
		text "$item.lineNumber";
	#end
#end