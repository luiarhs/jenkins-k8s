#if($printerType == "2")
    setCharsPerLine 48;
#else
    setCharsPerLine 38;
#end
#foreach( $item in $ticket.items )
	#if($item.villaNevada)
		#parse( "1001/templates/villaNevadaHeader.vcl" )
newline;
setFontSize normal;
		setAlignment left;
		text "#fmt("%02s             SECC %1s", ["$item.description" , "$item.merchandiseHierarchy"])";
		text "#fmt("%010s","$item.code")";
newline;
		#parse("1001/templates/villaNevadaFooter.vcl")
	#end	
#end





