
## Verificamos que exista algún cupon
#if ($ticket.crmDilisaPromotions.size() > 0 ||
     $ticket.crmInternetPromotions.size() > 0 ||
     $ticket.crmSiebelPromotions.size() > 0 ||
     $ticket.crmLoyaltyPromotions.size() > 0 )

   setCharsPerLine 38;
   bitmap "0" center;
   newline;
   setFontSize normal;
   setAlignment center;

   ## User
   #set ($user = "")
   #if ($ticket.couponName)
      #set ($user = $ticket.couponName)
   #end
   #if ($ticket.crmSiebelPromotions.size() > 0)
      #if ($ticket.crmSiebelPromotions.get(0).userCuponCrmSiebel)
         #set ($user = $ticket.crmSiebelPromotions.get(0).userCuponCrmSiebel)
      #end
   #end
   #if ($ticket.crmLoyaltyPromotions.size() > 0)
      #if ($ticket.crmLoyaltyPromotions.get(0).userCuponCrmLoyalty)
         #set ($user = $ticket.crmLoyaltyPromotions.get(0).userCuponCrmLoyalty)
      #end
   #end
   #if ($user.length() > 0)
      text $user;
   #end
   
   text "______________________________________";
   text "______________________________________";
   
   #set ($qtyCoupon = 1)
   
   ## CRM Loyalty
   
   ## CRM Siebel
   
   ## CRM Dilisa
   #if ($ticket.crmDilisaPromotions.size() > 0)
      #foreach( $cuponDilisa in $ticket.crmDilisaPromotions )
         #if ($qtyCoupon <= 3)
            text "$cuponDilisa.printMessage";
            newline;
	      	barcode CODE128 "$cuponDilisa.couponBarCode" 50 2 center below;
	      	text "______________________________________";
            text "______________________________________";
            #set ($qtyCoupon = ($qtyCoupon + 1))
         #end
      #end
   #end
   
   ## CRM Internet
   
   setAlignment center;
 ##text "*** Cupones redimibles sólo una vez al presentarlos y pagando con tarjetas Liverpool. Los cupones de descuento no son acumulables. No aplican en Ventas Nocturnas, ni Ventas Especiales. Consulte restricciones.*** Cupones redimibles sólo una vez al presentarlos y pagando con tarjetas Liverpool. Los cupones de descuento no son acumulables. No aplican en Ventas Nocturnas, ni Ventas Especiales. Consulte restricciones.";
   text " *** Cupones redimibles solo una vez al presentarlos y pagando con tarjetas Liverpool. Los cupones de descuento no son acumulables. No aplican en Ventas Nocturnas, ni Ventas Especiales. Consulte restricciones.*** Cupones redimibles sólo una vez al presentarlos y pagando con tarjetas Liverpool. Los cupones de descuento no son acumulables. No aplican en Ventas Nocturnas, ni Ventas Especiales. Consulte restricciones.";
   newline;
   
   ## TODO
   beginBold;
   newline;
   text "$descriptionData.trailerUrl";
   text "$descriptionData.trailerLabel";
   text "$descriptionData.trailerTelephone";
   endBold;

   newline;
   newline;
   newline;
   newline;
   cutPaperManual;

#end
