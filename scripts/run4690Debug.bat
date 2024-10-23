F:
cd agent
rem javaebin:java.386 -Dfile.encoding=ISO-8859-1 -Djms.conf=ac-comm-jms.xml -jar /cdrive/f_drive/agent/rslaunch.jar /cdrive/f_drive/agent/4690.prp >> c:/agent.log >>* c:/agent.log
javaebin:java.386 -Xms256M -Xmx512M -Dfile.encoding=ISO-8859-1 -classic -Xdebug -Xnoagent -Djava.compiler=NONE -Xrunjdwp:transport=dt_socket,address=8787,server=y,suspend=y -Djms.conf=ac-comm-jms.xml -DlogFile=log4j-4690.xml -Dquartz.config=quartz.properties -Dconfig.path= -Dconfig.filename=config.cfg -jar /cdrive/f_drive/agent/rslaunch.jar /cdrive/f_drive/agent/4690.prp
rem exit
