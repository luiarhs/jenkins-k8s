#if($tenderPayment)
    #if($tenderPayment.nip || $tenderPayment.autografa)
        ##text "AUTORIZADO MEDIANTE FIRMA ELECTRONICA";
    #else
        #if($tenderPayment.qps)
            ##text "         AUTORIZADO SIN FIRMA           ";
        #else
            #if(!$tenderPayment.sinFirma)
                ##newline;
                ##newline;
                ##newline;
                ##newline;
                ##text "           ------------------           ";
                ##text "                 Acepto                 ";
                ##newline;
            #end
            #if($ticket.transactionType == 2)
               text "     DEVOLUCION SUJETA A TERMINOS Y     ";
               text "  CONDICIONES DEL EMISOR DE LA TARJETA  ";
            #elseif($ticket.transactionType != 112)
               text "    PAGARE NEGOCIABLE UNICAMENTE CON    ";
               text "        INSTITUCIONES DE CREDITO        ";
            #end
        #end
    #end
#end