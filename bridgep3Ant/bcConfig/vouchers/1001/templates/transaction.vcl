#set ($ticket_is_duplicate = false)
#set($ticketSplitPrint = false)
#set ($epayment_process = false)
#set ($imprimeTicket = true)
#if ("$ticket.storeCode" == "0009" || "$ticket.storeCode" == "0039" || "$ticket.storeCode" == "0362" || "$ticket.storeCode" == "0364" ||
     "$ticket.storeCode" == "0366" || "$ticket.storeCode" == "0370" || "$ticket.storeCode" == "0850" || "$ticket.storeCode" == "0998")
	#set ($imprimeTicket = false)
#end

#if($ticket.transactionSuspended)
   #parse("1001/templates/trxSuspendida.vcl")
   #parse("1001/templates/total.vcl")
#break
#end

#if($ticket.transactionType == 1 || $ticket.transactionType == 2 || $ticket.transactionType == 5)
	#if($ticket.additionalSubType == 123)
	    #set($ticketOrig = $ticket)
		#set($ticket = $ticketLlevaDevuelve)
	#end

    #set($virtualSplitSegurosOrig = $ticket.virtualSplitSeguros)

	#if ($ticket.virtualSplitSeguros)
	  #set($digitalTicket = $ticket.digitalTicket)

      ## Si existe vale en ticket padre
      #if($vale && $vale.vale)
            #set($valePrincipal = $vale)
      #end

	  #foreach( $splitTicket in $ticket.splitTicketsDataMesaMES )
				#if( !($ticket.ticketVoidFlag) && !($splitTicket.ticketVoidFlag) )
					#set($ticketSplitPrint = true)
					#set($ticketOrig = $ticket)
					#set($ticket = $splitTicket)
					#set($seAplica = true)

                    #if (!$digitalTicket)
                        #if($splitTicket.monederoData)
                            #set($monedero = $splitTicket.monederoData)
                        #else
                            #set($monedero = "")
                        #end

                        #if($splitTicket.valeData)
                            #set($vale = $splitTicket.valeData)
                        #else
							#if($valePrincipal && $valePrincipal.vale)
								 #set($seAplica = false)
							#else
								#set($vale = "")
							#end
                        #end

                        #parse("1001/templates/ticket.vcl")
                    #else
                        ## Si existe vale en ticket padre
                        #if($valePrincipal && $valePrincipal.vale)
                            ## No se aplica additionalTickets
                            #set($seAplica = false)
                        #end
                    #end

                    #if($seAplica == true)
                        #parse("1001/templates/additionalTickets.vcl")
                        #set($ticket_is_duplicate = false)
                    #end
				#end
	    #end
	    #if(!$ticketSplitPrint)
			#if (!$digitalTicket)
            	#parse("1001/templates/ticket.vcl")
            #end

			#parse("1001/templates/additionalTickets.vcl")
		#else
		    ## Si existe vale en ticket padre
			#if($valePrincipal && $valePrincipal.vale)
				#set($vale = $valePrincipal)
				#parse("1001/templates/additionalTickets.vcl")
			#end
		#end
	#else
		#if($ticket.additionalSubType == 115 )
		    #foreach( $splitTicket in $ticket.splitTicketsDataMesaMES )
					#if( !($ticket.ticketVoidFlag) && !($splitTicket.ticketVoidFlag) )
						#set($ticketSplitPrint = true)
						#set($ticketOrig = $ticket)
						#set($ticket = $splitTicket)

    	                #if (!$ticket.digitalTicket)

    	                    #if($splitTicket.monederoData)
    	                        #set($monedero = $splitTicket.monederoData)
    	                    #else
    	                        #set($monedero = "")
    	                    #end

    	                    #if($splitTicket.valeData)
    	                        #set($vale = $splitTicket.valeData)
    	                    #else
    	                        #set($vale = "")
    	                    #end

    	                    #parse("1001/templates/ticket.vcl")

    	                #end

						#parse("1001/templates/additionalTickets.vcl")
						#set($ticket_is_duplicate = false)
					#end
		    #end

			#if(!$ticketSplitPrint)
				#if (!$ticket.digitalTicket)
    	        	#parse("1001/templates/ticket.vcl")
    	        #end

				#parse("1001/templates/additionalTickets.vcl")
			#end
		#else
		    #if($ticket.additionalSubType == 162 )
                #foreach( $splitTicket in $ticket.splitTicketsDataMesaMES )
                    #if( !($ticket.ticketVoidFlag) && !($splitTicket.ticketVoidFlag) )
                        #set($ticketSplitPrint = true)
                        #set($ticketOrig = $ticket)
                        #set($ticket = $splitTicket)
                        #if (!$ticket.digitalTicket)
                            #if($splitTicket.monederoData)
                                #set($monedero = $splitTicket.monederoData)
                            #else
                                #set($monedero = "")
                            #end

                            #if($splitTicket.valeData)
                                #set($vale = $splitTicket.valeData)
                            #else
                                #set($vale = "")
                            #end

                            #parse("1001/templates/ticket.vcl")

                        #end

                        #parse("1001/templates/additionalTickets.vcl")
                        #set($ticket_is_duplicate = false)
                    #end
                #end
            #if(!$ticketSplitPrint)
                #if (!$ticket.digitalTicket)
                   #parse("1001/templates/ticket.vcl")
                #end

                #parse("1001/templates/additionalTickets.vcl")
            #end
            #else
                #if (!$ticket.digitalTicket)
                    #parse("1001/templates/ticket.vcl")
                #end

                #if($ticket.additionalSubType == 122)
                    #set($ticket = $ticketOrig)

                    #if (!$ticket.digitalTicket)
                        #parse("1001/templates/ticket.vcl")
                    #end

                    #set($ticket = $ticketLlevaDevuelve)

                    #parse ( "1001/templates/ticketDuplicate.vcl")

                    #set($ticket = $ticketOrig)
                #end

                #parse("1001/templates/additionalTickets.vcl")

				#if($ticket.additionalSubType == 136)
					#set ($ticket_is_duplicate = true)
					#parse("1001/templates/ticket.vcl")
                #end
            #end

		#end
	#end
#end

#if($ticket.additionalSubType == 114)

    #parse("1001/templates/close.vcl" )
	
    #parse("1001/templates/closeVoucher.vcl" )
	
#end

#if(($ticket.additionalSubType == 7 || $ticket.additionalSubType == 157) && $ticket.transactionType != 112)
   #parse("1001/templates/tenderwithdrawal.vcl" )
   #parse("1001/templates/tenderwithdrawalDuplicate.vcl" )
#end

#if($ticket.transactionType == 112)
	##Validacion para realizar doble franqueo de cancelacion-Agencia de viajes
	#if($ticket.additionalSubType == 107 )
	    #foreach($payment in $ticket.payments)
    		#if($payment.additionalData.eglobalCard || $payment.tenderGsaId == 10)
    		   #set ($epayment_process = true)
    		#end
        #end

		##Si existe por lo menos un pago con tarjeta externa
		#if($epayment_process)
		   #set ($epayment_is_duplicate = false)
		   #parse( "1001/templates/epayment.vcl" )

		   cutPaper 90;
		   setFontSize normal;
		   #set ($epayment_is_duplicate = true)
		   #parse( "1001/templates/epayment.vcl" )

		   cutPaper 90;
		   setFontSize normal;

		   #set ($epayment_is_duplicate = false)
		   #parse( "1001/templates/epayment.vcl" )

		   cutPaper 90;
		   setFontSize normal;
		   #set ($epayment_is_duplicate = true)
		   #parse( "1001/templates/epayment.vcl" )
		   cutPaper 90;
		   setFontSize normal;
		#end

		#if(!$ticket.isJava8())
		    #parse("1001/templates/cancel.vcl")
		#end
	#end

    #if($ticket.additionalSubType != 107 && $ticket.additionalSubType != 105 && $ticket.additionalSubType != 138)
        #foreach($payment in $ticket.payments)
            #if($payment.additionalData.eglobalCard || $payment.tenderGsaId == 10)
               #set ($epayment_process = true)
            #end
        #end
        #if($epayment_process)
           #set ($epayment_is_duplicate = false)
           #parse( "1001/templates/epayment.vcl" )

           cutPaper 90;
           setFontSize normal;
           #set ($epayment_is_duplicate = true)
           #parse( "1001/templates/epayment.vcl" )

           cutPaper 90;
           setFontSize normal;
        #end
    #end

	#parse("1001/templates/cancel.vcl" )

	#if($ticket.additionalSubType == 138 && !$ticket.isJava8())
		#parse("1001/templates/cancel.vcl")
	#end
#end

## Disposición de efectivo
#if($ticket.additionalSubType == 110)
	###Se agrega bandera para leyendas de copia en disposicion de efectivo
	#set ($duplicate = true)
	#parse("1001/templates/ticket.vcl")
#end

## Dolar
#if($ticket.transactionType != 112  && $ticket.additionalSubType != 7)
	#if($ticket.transactionDolar && $ticket.additionalSubType != 119 && $ticket.additionalSubType != 120)
	  #set ($duplicate = true)
		#parse("1001/templates/ticket.vcl")
	#end
#end

#if($ticket.transactionType != 112 && ($ticket.additionalSubType == 107 || $ticket.additionalSubType == 138))
	#set ($duplicateAg = true)
	#set ($duplicate = true)
	#parse("1001/templates/ticket.vcl")
#end

## Reimpresión por sección y proveedor
#if ($ticket.duplicateTicketSeccionProveedor)
	#set ($duplicate = true)
	#parse("1001/templates/ticket.vcl")
#end