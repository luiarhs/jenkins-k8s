#parse( "1003/templates/shortHeader.vcl" )

#parse( "1003/templates/paymentsDetail.vcl" )

#parse( "1003/templates/countDetail.vcl" )

text "#fmt("%10.10s %10.10s %10.10s", ["VENDEDOR", "#formatFecha($date)" , $time])";
newline;
newline;
newline;
newline;