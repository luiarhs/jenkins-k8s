#if($vale && $vale.vale && !$printInsideMonederoVale )

   setCharsPerLine 48;
   setAlignment center;
   
	 #parse( "1001/templates/shortHeader.vcl" )
	 #parse( "1001/templates/valeBody.vcl" )
	
	 newline;
	 
   cutPaper 90;
   setFontSize normal;
 
#end