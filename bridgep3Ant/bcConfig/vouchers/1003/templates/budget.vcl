setAlignment center;
beginBold;
   setFontSize highWide;
   text "PRESUPUESTO";
   newline;
   setFontSize normal;
   text "$budget.planName";
endBold;
newline;
newline;
text "#fmt("%-20.20s  %-10.10s", ["EN UNA COMPRA DE $","$budget.budgetAmount"])"; 
newline;
newline;
newline;
#foreach( $budgetInstallment in $budget.budgetInstallments)
	text "#fmt("%-5.5s  %-20.20s  %-10.10s", ["$budgetInstallment.installment", "MENSUALIDADES DE $", "$budgetInstallment.amount"] )";
	newline;
#end

newline;
	text "$date   $time";
newline;
newline;
newline;
newline;