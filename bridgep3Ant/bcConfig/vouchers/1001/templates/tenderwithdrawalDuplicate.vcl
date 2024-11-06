#parse( "1001/templates/shortHeader.vcl" )

#parse( "1001/templates/paymentsDetail.vcl" )

#parse( "1001/templates/countDetail.vcl" )

setCharsPerLine 38;
text "#fmt("%s   %s     %s", ["VENDEDOR","#formatFecha($date)",$time])";
cutPaper 90;
setFontSize normal;