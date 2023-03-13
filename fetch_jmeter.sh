#!/bin/sh -e
#
# download, extract and prepare jmeter for use with this repository
# this downloads and prepares jmeter, but does not put it into your
# path. Be sure to add jmeter/apache-jmeter-${JMETER_VERSION}/bin
# to your path if you want the run script to function correctly

JMETER_HOME=jmeter
JMETER_VERSION="5.5"
PROMETHEUS_PLUGIN_VERSION="0.6.0"
PROMETHEUS_PLUGIN_FILENAME="jmeter-prometheus-plugin-${PROMETHEUS_PLUGIN_VERSION}.jar"
JSON_LIB_VERSION="2.4"
JSON_LIB_FILENAME=json-lib-${JSON_LIB_VERSION}-jdk15.jar

mkdir -p ${JMETER_HOME}


curl https://dlcdn.apache.org//jmeter/binaries/apache-jmeter-${JMETER_VERSION}.tgz | tar xzf - -C ${JMETER_HOME}
curl -L https://search.maven.org/remotecontent?filepath=com/github/johrstrom/jmeter-prometheus-plugin/${PROMETHEUS_PLUGIN_VERSION}/${PROMETHEUS_PLUGIN_FILENAME} -o jmeter/apache-jmeter-${JMETER_VERSION}/lib/ext/${PROMETHEUS_PLUGIN_FILENAME}
curl -L https://search.maven.org/remotecontent?filepath=net/sf/json-lib/json-lib/${JSON_LIB_VERSION}/${JSON_LIB_FILENAME} -o jmeter/apache-jmeter-${JMETER_VERSION}/lib/ext/${JSON_LIB_FILENAME}
