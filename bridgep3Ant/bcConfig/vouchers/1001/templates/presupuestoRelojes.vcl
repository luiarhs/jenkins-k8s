setCharsPerLine 48;

setAlignment center;
setFontSize normal;
beginBold;
   text "$store.storeName";
endBold;
newline;
text "$store.storeAddress";
setAlignment left;
setFontSize normal;
newline;
beginBold;
text "#fmt("ATENDIO: %-s", "$ticket.userNameDescription")";
newline;
text "Fecha:  #formatFecha($date)    $time";
newline;

text "#fmt("Nro. de Orden: %-s", "$ticket.presupuestoRelojesData.numeroDeOrden")";
endBold;
newline;

#if($ticket.presupuestoRelojesData.NIP)
   text "#fmt("NIP: %-s", "$ticket.presupuestoRelojesData.NIP")";
#end
#if($ticket.presupuestoRelojesData.nombreCliente)
   text "#fmt("Nombre: %-s", "$ticket.presupuestoRelojesData.nombreCliente")";
#end
#if($ticket.presupuestoRelojesData.apellidoCliente)
   text "#fmt("Apellido: %-s", "$ticket.presupuestoRelojesData.apellidoCliente")";
#end
#if($ticket.presupuestoRelojesData.telefonoCliente)
   text "#fmt("Telefono: %-s", "$ticket.presupuestoRelojesData.telefonoCliente")";
#end
#if($ticket.presupuestoRelojesData.eMailCliente)
   text "#fmt("Mail: %-s", "$ticket.presupuestoRelojesData.eMailCliente")";
#end
#if($ticket.presupuestoRelojesData.marcaReloj)
   text "#fmt("Marca del Reloj: %-s", "$ticket.presupuestoRelojesData.marcaReloj")";
#end
#if($ticket.presupuestoRelojesData.modeloReloj)
   text "#fmt("Modelo del Reloj: %-s", "$ticket.presupuestoRelojesData.modeloReloj")";
#end
#if($ticket.presupuestoRelojesData.materialReloj)
   text "#fmt("Material del Reloj: %-s", "$ticket.presupuestoRelojesData.materialReloj")";
#end
#if($ticket.presupuestoRelojesData.relojFuncionando)
   text "Funciona el Reloj?  SI";
#else
   text "Funciona el Reloj?  NO";
#end
#if($ticket.presupuestoRelojesData.relojPiezaDeMostrador)
   text "Es reloj de mostrador?  SI";
#else
   text "Es reloj de mostrador?  NO";
#end
#if($ticket.presupuestoRelojesData.relojConGarantia)
   text "Tiene garantía el reloj?  SI";
#else
   text "Tiene garantía el reloj?  NO";
#end
#if($ticket.presupuestoRelojesData.fechaGarantia)
   text "#fmt("Fecha de garantía:  %-s", "$ticket.presupuestoRelojesData.fechaGarantia")";
#end
#if($ticket.presupuestoRelojesData.reparacionPreaceptada)
   text "El cliente pre-acepta la reparación?  SI";
#else
   text "El cliente pre-acepta la reparación?  NO";
#end
#if($ticket.presupuestoRelojesData.costoPreaceptado)
   text "Costo pre-aceptado de la reparación:";
   text "$ticket.presupuestoRelojesData.costoPreaceptado";
#end
#if($ticket.presupuestoRelojesData.motivoReparacion)
   text "Motivo de la reparación:";
   text "#divStr($ticket.presupuestoRelojesData.motivoReparacion, 38 )";
#end
text "Estado del reloj:";
#foreach($reparacionDetalleData in $ticket.presupuestoRelojesData.reparacionDetalle)
   text "#fmt("Parte       %-s", "$reparacionDetalleData.parte")";
   text "#fmt("Comentario  %-s", "$reparacionDetalleData.comentario")";

#end
text "Dibujo:";
bitmap  $ticket.presupuestoRelojesData.bitmapPath left;
text "FIRMA   :_____________________________";
