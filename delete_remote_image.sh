#!/bin/sh -e

# command line arguments
# -b baseurl (no need to provide it if the registry type is dockerhub)
# -i image (or repo as docker hub calls it)
# -r registrytype (artifactory, dockerhub)

# environment variables
# REGISTRY_USERNAME
# REGISTRY_PASSWORD

# for dockerhub: https://stackoverflow.com/a/56382628
# https://cloud.docker.com/v2/repositories/$ORGANIZATION/$REPOSITORY/tags/$TAG/
# for artifactory: https://www.jfrog.com/confluence/display/RTF/Artifactory+REST+API#ArtifactoryRESTAPI-DeleteItem
# https://artifactory.dev.skycloudnp.ott.sky/artifactory/perftest-docker-local-dev/perftest/10_10/

# the original intention was to support dockerhub, but their api is not a simple REST api.
# Additionally, even hub-tool is reporting that there is no server to process the request (503)
# after a successful login followed by a hub-tool tag rm -f perftest:10_0 command
# for now, I am giving up on the idea of supporting docker hub.

registry_type="dockerhub"
baseurl=""
image=""
organisation=""
registry_type=""
tag=""

function show_help()
{
    echo "$0 -b <baseurl> -o <organisation> -i <image> -t <tag> -r <registry_type>"
}

while getopts "h?b:i:o:r:t:" opt; do
    case "$opt" in
        h|\?)
            show_help
            exit -1
            ;;
        b)
            baseurl=$OPTARG
            ;;
        i)
            image=$OPTARG
            ;;
        o)
            organisation=$OPTARG
            ;;
        r)
            registry_type=$OPTARG
            ;;
        t)
            tag=$OPTARG
            ;;
        *)
            show_help
            exit -1
            ;;
    esac
done

if [ "${registry_type}" = "dockerhub" ]; then
    baseurl="https://cloud.docker.com/v2/repositories"
fi

if [ -z "${baseurl}" ]; then

    show_help
    exit -1
fi

if [ -z "${organisation}" ]; then
    show_help
    exit -1
fi

if [ -z "${image}" ]; then
    show_help
    exit -1
fi

if [ -z "${REGISTRY_USERNAME}" ]; then
    echo "The REGISTRY_USERNAME environment variable must be set"
    exit -1
fi

if [ -z "${REGISTRY_PASSWORD}" ]; then
    echo "The REGISTRY_PASSWORD environment variable must be set"
    exit -1
fi

if [ -z "${tag}" ]; then
    item_url="${baseurl}/${organisation}/${image}/"
else
    item_url="${baseurl}/${organisation}/${image}/${tag}/"
fi

echo "deleting item ${item_url}"

curl -f -L -u "${REGISTRY_USERNAME}:${REGISTRY_PASSWORD}" -X DELETE "${item_url}"
