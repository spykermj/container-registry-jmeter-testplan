#!/bin/sh

./jmeter/apache-jmeter-5.5/bin/jmeter -t container-registry-performance-test.jmx -p perftest.properties -n
