#!/bin/sh

mkdir -p testlogs results

function show_help()
{
    echo "$0 <properties_file>"
}

if [ "$#" -ne "1" ]; then
    show_help
    exit -1
fi

jmeter -t container-registry-performance-test.jmx -p "$1" -J registry.perftest.registryRestPassword=${REGISTRY_PASSWORD} -J registry.perftest.registryRestUsername=${REGISTRY_USERNAME} -n
