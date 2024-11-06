newline;
#if("$ticket.change" != "0.00" )
   text "#fmt("%15.15s %1.1s  %16.16s", ["CAMBIO", "$", "#fmtDec($ticket.change)"])";
#end
