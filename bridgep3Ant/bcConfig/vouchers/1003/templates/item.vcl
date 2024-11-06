#set ($voiding = "$item.isVoid()")
#set ($returning = "$item.isReturned()")
#set ($sign = "#gSign($returning $voiding)")
#set ($letter = "#gLet($returning $voiding)")
#if($letter != "")
   #set($isLetter = "-$letter")
#else
   #set($isLetter = "")
#end

#if($ticket.additionalSubType == 111)
   text "REFERENCIA :      $service.serviceWalletNumber";
   text "CAPTURA:          $service.serviceReferenceNumber";
   text "#fmt("%-5.5s  %25.25s", ["$service.serviceKey", "$service.serviceName"] )";
   text "#fmt("%-25.25s %10.10s", ["$service.serviceDescription", "#fmtDec($ticket.total)"] )";
#else
   #if($item.ownBrand)
      text "$item.ownBrand";
   #end
   text "#fmt("%-18.18s   %-4.4s %-3.3s  %s%1s", ["$item.description", "SECC", "$item.merchandiseHierarchy","$item.priceInputTypeIndicator","$isLetter"] )";
   #if($ticket.giftsPlanData.typeElectronicGift)
      #if($item.qty == 1)
         text "#fmt("%-12.12s                %11.11s%1s", ["#fmtLft($item.code,12)", "#fmtDec($item.originalExtendedPrice $sign)","$letter"] )";
      #end
      #if($item.qty != 1 && $item.qty != 0)
         text "#fmt("%-12.12s %14.14s %11.11s%1s", ["#fmtLft($item.code,12)","#fmtDecNoSign($item.actualUnitPrice)*#fmtDecNoSign($item.qty)", "#fmtDec($item.originalExtendedPrice $sign)","$letter"])";
      #end
   #else
      #if($item.qty == 1 && !($item.magnitude))
         text "#fmt("%-10.10s                %11.11s%1s", ["#fmtLft($item.code,10)", "#fmtDec($item.originalExtendedPrice $sign)","$letter"] )";
      #end
      #if($item.qty != 1 && $item.qty != 0)
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
   #if($item.somsDeliveryDate)
       text "Entrega prevista: #formatFecha($item.somsDeliveryDate)";
   #end
   #if($item.somsDeliveryType)
      #if($item.somsDeliveryType == 2)
         text "Cliente Avisa";
      #end
      #if($item.somsDeliveryType == 1)
         text "A Su Arribo";
      #end
   #end
   #if(!($item.isVoid()))
      #set ($sign = "#ngt($sign)")   
      #foreach( $discountData in $item.discounts )
         #if($discountData.type == 1)
             #if($discountData.promo)
                #if($discountData.promo == true)
                    ###foreach( $description in $discountData.descriptions)
                         text "#fmt("%18.18s        %11.11s", ["$discountData.descriptions", "#fmtDec($discountData.discount $sign)"])";
                      ###end
                 #else
                   text "#fmt("%18.18s %1s      %11.11s", ["DESC X PROM", "$", "#fmtDec($discountData.discount $sign)"])";
                #end
             #else
                text "#fmt("%18.18s %1s      %11.11s", ["REBAJA ", "$", "#fmtDec($discountData.discount $sign)"])";   
             #end
          #end
          #if($discountData.type == 2)
            #if($discountData.promo)
                 #if($discountData.promo == true)
                    #foreach( $description in $discountData.descriptions)
                         text "#fmt("%18.18s %1s%6.6s%11.11s", [$description, "%", "#fmtDecNoSign($discountData.percent)","#fmtDec($discountData.discount $sign)"])";
                      #end
                 #else
                    text "#fmt("%18.18s %1s%6.6s%11.11s", ["DESC X PROM", "%", "#fmtDecNoSign($discountData.percent)","#fmtDec($discountData.discount $sign)"])";
                 #end                 
            #else
               text "#fmt("%18.18s %1s%6.6s%11.11s", ["REBAJA ", "%", "#fmtDecNoSign($discountData.percent)","#fmtDec($discountData.discount $sign)"])";   
            #end
          #end
      #end
      #foreach( $benefitData in $item.monederoBenefits )
         text "#center($benefitData.description)";
      #end
      #foreach( $paymentPlan in $item.paymentPlanList )
         text "#center($paymentPlan)";
      #end 
   #end
#end
