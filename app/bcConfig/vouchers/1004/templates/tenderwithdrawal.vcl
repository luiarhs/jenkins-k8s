#parse( "1004/templates/shortHeader.vcl" )

#parse( "1004/templates/paymentsDetail.vcl" )

#parse( "1004/templates/countDetail.vcl" )

newline;
text "#prTot($totals.totalComputador,$totals.entregado,$totals.totalDiferencia,$totals.devolucion,$totals.valesPapel)";
newline;
text "#fmt("%8.8s %15.15s %10.10s", ["TIENDA", "#formatFecha($date)" , $time])";