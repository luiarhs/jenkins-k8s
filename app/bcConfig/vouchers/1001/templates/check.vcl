#foreach( $payment in $ticket.payments )
   cutPaperManual;
   setStation 2;
   newline;
   setCharsPerLine 48;
      #parse( "1001/templates/checkBack.vcl" )
   #if($payment.additionalData.ad_check_type_writing == "10")
      beginRotatePrint left90;
         setCharsPerLine 48;
         #parse( "1001/templates/checkFront.vcl" )
         newline;
      endRotatePrint;
   #end
#end
