# Use OpenJDK 17 as the base image
FROM openjdk:17-jdk-slim-bullseye

# Set the JMeter and plugin versions as build arguments
ARG JMETER_VERSION="5.6.3"
ARG CMDRUNNER_VERSION="2.3"
ARG JMETER_PLUGINS_MANAGER_VERSION="1.9"

# Define environment variables for JMeter
ENV JMETER_HOME=/opt/apache-jmeter-${JMETER_VERSION}
ENV JMETER_BIN=${JMETER_HOME}/bin
ENV JMETER_LIB=${JMETER_HOME}/lib
ENV JMETER_PLUGINS=${JMETER_LIB}/ext
ENV JMETER_DOWNLOAD_URL=https://archive.apache.org/dist/jmeter/binaries/apache-jmeter-${JMETER_VERSION}.tgz

# Install necessary packages
RUN apt-get update -qqy && apt-get upgrade -qqy \
    && apt-get install -y --no-install-recommends \
        curl \
        wget \
        libfreetype6 \
        telnet \
        fontconfig \
    && mkdir -p /tmp/dependencies \
    && curl -L --silent ${JMETER_DOWNLOAD_URL} > /tmp/dependencies/apache-jmeter-${JMETER_VERSION}.tgz \
    && mkdir -p /opt \
    && tar -xzf /tmp/dependencies/apache-jmeter-${JMETER_VERSION}.tgz -C /opt \
    && rm -rf /tmp/dependencies

# Set Java to run in headless mode by default
ENV JAVA_TOOL_OPTIONS="-Djava.awt.headless=true"

# Set the working directory for JMeter libraries
WORKDIR ${JMETER_LIB}

# Download the JMeter Plugins Command Runner
RUN wget https://repo1.maven.org/maven2/kg/apc/cmdrunner/${CMDRUNNER_VERSION}/cmdrunner-${CMDRUNNER_VERSION}.jar

# Set the working directory for JMeter plugins
WORKDIR ${JMETER_PLUGINS}

# Download the JMeter Plugins Manager
RUN wget https://repo1.maven.org/maven2/kg/apc/jmeter-plugins-manager/${JMETER_PLUGINS_MANAGER_VERSION}/jmeter-plugins-manager-${JMETER_PLUGINS_MANAGER_VERSION}.jar \
    && java -cp ${JMETER_PLUGINS}/jmeter-plugins-manager-${JMETER_PLUGINS_MANAGER_VERSION}.jar org.jmeterplugins.repository.PluginManagerCMDInstaller

# Add JMeter binaries and libraries to the PATH
ENV PATH=$PATH:$JMETER_BIN:$JMETER_LIB:$JMETER_PLUGINS

# Install a specific JMeter plugin (e.g., bzm-rte)
RUN PluginsManagerCMD.sh install bzm-rte=3.3

# Clean up the package lists to reduce image size
RUN apt-get clean \
    && rm -rf /var/lib/apt/lists/*
