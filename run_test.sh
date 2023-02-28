#!/bin/sh

mkdir -p testlogs results

./jmeter/apache-jmeter-5.5/bin/jmeter -t container-registry-performance-test.jmx -p docker.properties -n
