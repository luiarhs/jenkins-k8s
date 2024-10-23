#!/bin/bash
STATUS_MSG=PRUEBAAAA
echo $STATUS_MSG
    #comandos del reinicio del agente
    # python -c 'import os4690.adxserve as adxserve; adxserve.stopBackgroundApplication("ADX_SPGM:COMMAND.286", parameters="ADX_SPGM:REAGENT.BAT"); adxserve.restartBackgroundApplication("ADX_SPGM:COMMAND.286", parameters="ADX_SPGM:REAGENT.BAT")'
    # sleep 5m #tolerncia despues del reinicio
    # STATUS_MSG=RESTARTED_MONITORING
    # echo $DATE, $KPROC, $NO_FILES, $CLOSE_WAIT, $CURRENT_FREE_CPU, $STATUS_MSG |tee -a $LOG_OPENFILES