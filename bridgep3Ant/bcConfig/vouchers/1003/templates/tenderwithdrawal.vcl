#parse( "1003/templates/shortHeader.vcl" )

#parse( "1003/templates/paymentsDetail.vcl" )

#parse( "1003/templates/countDetail.vcl" )

text "#fmt("%8.8s %15.15s %10.10s", ["TIENDA", "#formatFecha($date)" , $time])";
newline;
newline;
newline;
newline;
cutPaperManual;