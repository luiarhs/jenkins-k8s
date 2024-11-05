## Verificamos que exista algún cupon
#if ($ticket.crmCouponPromotions.size() > 0)
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
    newline;
  #end

  setFontSize normal;
  setAlignment center;

  ## User
  #set ($user = "")
  #if ($ticket.couponName)
    #set ($user = $ticket.couponName)
  #end

  #if ($user.length() > 0)
    setFontSize wideB;
    beginBold;
    text "$user";
    endBold;
  #end
	
  newline;
	setFontSize normal;
   
  #if ($ticket.crmCouponPromotions.size() > 0)
	  #foreach( $cuponDilisa in $ticket.crmCouponPromotions )
	  	textNoLF "#parseDinamicCoupon($cuponDilisa.printMessage) ";			
		  setFontSize normal;
      newline;
	    barcode CODE128 "$cuponDilisa.couponBarCode" 50 2 center none;			
	    newline;
    #end
  #end
   
  ## CRM Internet
  ###setAlignment left;
  setAlignment center;
  text "*** Cupones redimibles solo una vez al";
  text "presentarlos. Los cupones de descuento";
  text "no son acumulables. No aplican en";
  text "Ventas Nocturnas ni Ventas Especiales.";
  
  text "Consulte restricciones.";
   
  ## TODO
  ###setAlignment center;
  beginBold;   
  text "$descriptionData.trailerUrl";
  text "$descriptionData.trailerLabel";
  text "$descriptionData.trailerTelephone";
  endBold;
   
  cutPaper 90; 
  setFontSize normal;
#end
