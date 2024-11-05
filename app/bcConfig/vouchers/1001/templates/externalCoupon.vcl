#foreach ($payment in $ticket.payments)
	#if ($payment.isExternalCoupon())
		#if ($printerType != "7")
		   cutPaperManual;
		#end

		setStation 2;
		setAlignment left;
		setFontSize normal;
		text "#fmt("%-4s      %5s      %-4s     %4s", ["TERM","DOCTO","TDA","VEND"])";
		text "#fmt("%03s       %4s       %4s    %8s", ["$ticket.terminalCode", "$ticket.docNumber", "$ticket.storeCode", "$ticket.userName"])";
		newline;
		text "#fmt("      ATENDIO: %-s", "$ticket.userNameDescription")";
		newline;
		#if($payment.folio)
			text "Folio: $payment.folio";
		#end
		text "$payment.description $ #fmtDec($payment.amount,$sign)";
        newline;
		text "#formatFecha($date) $time";

		#if (!$ticket.printFranqueo)
		   cutPaper 90;
		#else
		   cutPaperManual;
		#end

		#if ($printerType == "7")
		   cutPaperManual;
		#end
	#end
#end
