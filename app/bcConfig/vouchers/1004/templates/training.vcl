#parse( "1004/templates/header.vcl" )

#parse( "1004/templates/total.vcl" )

#if($ticket.trainingModeFlag)
   text "#centerTC("  MODO ENTRENAMIENTO  ", 38, "*")";
#end
