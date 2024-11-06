newline;
text "------------------------------------";
text "************************************";
text "#center("CONSULTA")";
text "************************************";   
#if($ticket.terminalCode)                                  
	text "#fmt("%-10.10s  %-30.30s", ["TERMINAL ", "$ticket.terminalCode"])";    
#end  
#if($balance.account)                          
	#if($notSecureAccount == "true")
	   text "#fmt("%-10.10s  %-30.30s", ["CONSULTA A:  ", "$balance.account"])";    
	#else
   		text "#fmt("%-10.10s  %-30.30s", ["CONSULTA A:  ", "#maskAcc($balance.account)"])";    
  	#end		
#end     
#if($balance.name)
    text "#fmt("%-10.10s  %-30.30s", ["NOMBRE:  ","$balance.name"])"; 
#end
text "#formatFecha($date)   $time";      
text "************************************";
text "------------------------------------";