FROM openjdk:17-jdk-slim-bullseye

ARG JMETER_VERSION="5.6.3"
ARG CMDRUNNER_VERSION="2.3"
ARG JMETER_PLUGINS_MANAGER_VERSION="1.9"
ENV JMETER_HOME=/opt/apache-jmeter-${JMETER_VERSION}
ENV JMETER_BIN=${JMETER_HOME}/bin
ENV JMETER_LIB=${JMETER_HOME}/lib
ENV JMETER_PLUGINS=${JMETER_LIB}/ext
ENV JMETER_DOWNLOAD_URL=https://archive.apache.org/dist/jmeter/binaries/apache-jmeter-${JMETER_VERSION}.tgz

RUN apt-get update -qqy && apt-get upgrade -qqy \
&& apt-get install curl wget libfreetype6 -qqy \
&& mkdir -p /tmp/dependencies  \
&& curl -L --silent ${JMETER_DOWNLOAD_URL} >  /tmp/dependencies/apache-jmeter-${JMETER_VERSION}.tgz  \
&& mkdir -p /opt  \
&& tar -xzf /tmp/dependencies/apache-jmeter-${JMETER_VERSION}.tgz -C /opt  \
&& rm -rf /tmp/dependencies

WORKDIR ${JMETER_LIB}

RUN wget https://repo1.maven.org/maven2/kg/apc/cmdrunner/${CMDRUNNER_VERSION}/cmdrunner-${CMDRUNNER_VERSION}.jar

WORKDIR ${JMETER_PLUGINS}

RUN wget https://repo1.maven.org/maven2/kg/apc/jmeter-plugins-manager/${JMETER_PLUGINS_MANAGER_VERSION}/jmeter-plugins-manager-${JMETER_PLUGINS_MANAGER_VERSION}.jar
RUN java -cp ${JMETER_PLUGINS}/jmeter-plugins-manager-${JMETER_PLUGINS_MANAGER_VERSION}.jar org.jmeterplugins.repository.PluginManagerCMDInstaller

ENV PATH=$PATH:$JMETER_BIN:$JMETER_LIB:$JMETER_PLUGINS

RUN PluginsManagerCMD.sh install bzm-rte=3.3