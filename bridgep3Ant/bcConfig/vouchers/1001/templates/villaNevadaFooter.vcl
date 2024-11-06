setFontSize normal;

#if($printerType == "2")
    setCharsPerLine 48;
#else
    setCharsPerLine 38;
#end

setAlignment left;
      
text "Participa   bajo su   propio   riesgo.";
text "La empresa no se  hace responsable por";
text "accidentes  ocurridos  dentro  de  las";
text "atracciones  que ampara el presente.  ";
text "El  uso  de  este  boleto significa su";
text "total  aceptación   a   lo   anterior.";
text "Niños  a  partir  de  6  años   pueden";
text "participar en las actracciones.       ";
text "El  presente  boleto  es  personal   e";
text "intransferible.";
	  
newline;
setAlignment center;
text "CLIENTE     #formatFecha($date) $time";

cutPaper 90;
setFontSize normal;