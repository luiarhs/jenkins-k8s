#set ($sign = "1")
text "            #fmt("%-4s      %5s      %-4s   %4s", ["TERM","DOCTO","TDA","VEND"])";
text "            #fmt("%03s       %4s      %4s  %8s", ["$ticket.terminalCode", "$ticket.docNumber", "$ticket.storeCode", "$ticket.userName"])";
text "            #fmt("ATENDIO:       %-s", "$ticket.userNameDescription")";
#if($ticket.additionalSubType == 119 || $ticket.additionalSubType == 120 || $ticket.additionalSubType == 143 || $ticket.additionalSubType == 144)
  text "            #fmt("NUM. DE CUENTA: %-s", "$accountPayment.account")";
#end
text "            #fmt("AUTORIZACION      **  %s  **", ["$payment.checkAuthorizationCode"])";
text "            #fmt("CHEQUE   %1s%16s", ["$","#fmtDec($payment.amount,$sign)"])";
text "            #formatFecha($date)    $time";
