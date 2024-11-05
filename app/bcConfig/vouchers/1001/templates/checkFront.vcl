#set ($sign = "1")

#if($payment.ad_check_printer_format == 1 || $payment.ad_check_printer_format == 3 || $payment.ad_check_printer_format == 4 || $payment.ad_check_printer_format == 6 || $payment.ad_check_printer_format == 7)
   #set ($espacio1 = 2)
#end

#if($payment.ad_check_printer_format == 2 || $payment.ad_check_printer_format == 5)
   #set ($espacio1 = 3)
#end

#if($payment.ad_check_printer_format == 1 || $payment.ad_check_printer_format == 2 || $payment.ad_check_printer_format == 4)
   #set ($espacio2 = 1)
#end

#if($payment.ad_check_printer_format == 7)
   #set ($espacio2 = 2)
#end

#if($payment.ad_check_printer_format == 3 || $payment.ad_check_printer_format == 5 || $payment.ad_check_printer_format == 6)
   #set ($espacio2 = 3)
#end

newline;
text "#fmt("%76s","#formatFecha($date)")" 96;


#set($start = 1)
#set($range = [$start..$espacio2])
#foreach($i in $range)
   newline;
#end

text "#fmt("********DISTRIBUIDORA LIVERPOOL S.A. DE C.V.********              *$ %6s **", ["#fmtDec($payment.amount, $sign)"])" 96;
newline;
text "#convertToText($payment.amount, 38)" 96;

#set($start = 1)
#set($range = [$start..$espacio1])
#foreach($i in $range)
   newline;
#end