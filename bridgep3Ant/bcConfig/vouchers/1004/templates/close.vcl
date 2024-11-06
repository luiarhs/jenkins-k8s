#parse( "1004/templates/shortHeader.vcl" )

text "COMPUTADOR    $          #fmtDec($totals.totalComputador)";
text "ENTREGADO     $          #fmtDec($totals.entregado)";
text "DIFERENCIA    $          #fmtDec($totals.totalDiferencia)";
text "DEVOLUCION    $          #fmtDec($totals.devolucion)";
text "PUNTOS RIFA   $          0.00";
text "VALES PAPEL   $          #fmtDec($totals.valesPapel)";
newline;
text "*****     $ticket.trxVoucher     *****";
newline;
newline;
text "*****TOTALES DE TERMINAL BORRADOS*****";
text "***********TERMINAL CERRADA***********";
newline;
newline;
#if($ticket.ticketVoidFlag)
	text " * ANULADA *    #formatFecha($date) $time";
#else
	text "TIENDA: #formatFecha($date)   $time";
#end