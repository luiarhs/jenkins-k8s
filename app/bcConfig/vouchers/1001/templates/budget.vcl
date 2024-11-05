#if($printerType == "2")
    setCharsPerLine 48;
#else
    setCharsPerLine 38;
#end
setAlignment center;
setFontSize high;
beginBold;
   text "PRESUPUESTO";
   newline;
   text "$budget.planName";
endBold;
newline;
text "#fmt("%-20s  %15s", ["EN UNA COMPRA DE  $","#fmtDec($budget.budgetAmount)"])"; 
newline;

setFontSize normal;
setAlignment left;
#foreach( $budgetInstallment in $budget.budgetInstallments)
	text "#fmt("%3s  %-20s  %11s", ["$budgetInstallment.installment", "MENSUALIDADES DE $", "$budgetInstallment.amount"] )";
#end

newline;
setAlignment center;
	text "#formatFecha($date)    $time";


cutPaper 90;
setFontSize normal;