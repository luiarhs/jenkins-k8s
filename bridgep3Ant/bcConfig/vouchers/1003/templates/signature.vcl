#if($payment.nip || $payment.autografa)
    text "  AUTORIZADO MEDIANTE FIRMA ELECTRONICA ";
#else
    #if($payment.qps)
        text "         AUTORIZADO SIN FIRMA           ";
    #else 
        #if(!$payment.sinFirma)
            newline;
            newline;
            newline;
            newline;
            text "           ------------------           ";
            text "                 Acepto                 ";
            newline;
        #end
        text "    PAGARE NEGOCIABLE UNICAMENTE CON    ";
        text "        INSTITUCIONES DE CREDITO        ";
    #end
#end