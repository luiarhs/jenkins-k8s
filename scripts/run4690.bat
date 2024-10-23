F:
cd agent
rem javaebin:java.386 -Dfile.encoding=ISO-8859-1 -Djms.conf=ac-comm-jms.xml -jar /cdrive/f_drive/agent/rslaunch.jar /cdrive/f_drive/agent/4690.prp >> c:/agent.log >>* c:/agent.log
javaebin:java.386 -Djdk.httpserver.maxConnections=500 -Xms512M -Xmx2048M -Dfile.encoding=ISO-8859-1 -Djms.conf=ac-comm-jms.xml -DlogFile=log4j-4690.xml -DfilesAccessPath=filesAccessConfigAgent.xml -Dquartz.config=quartz.properties -Dconfig.path= -Dconfig.filename=config.cfg -Dconfig.isagent=true -jar /cdrive/f_drive/agent/rslaunch.jar /cdrive/f_drive/agent/4690.prp
exit
