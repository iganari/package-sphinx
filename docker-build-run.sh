#!/bin/bash

set -xeu

_I_TAG='pkg-dojo'
BASEPATH=$(cd `dirname $0`; pwd)
DIREPATH=`echo $BASEPATH | awk -F\/ '{print $NF}'`

set +eu
docker rm -f ${_I_TAG}
set -eu

docker build . -t ${_I_TAG}

# docker run --rm \
#     -it \
#     -v $BASEPATH:/opt/hejda/$DIREPATH \
#     -w /opt/hejda/$DIREPATH \
#     -h ${_I_TAG} \
#     --name ${_I_TAG} \
#     -p 8080:80 \
#     ${_I_TAG} \
#     /bin/ash

docker run -d \
    -v $BASEPATH:/opt/hejda/$DIREPATH \
    -w /opt/hejda/$DIREPATH \
    -h ${_I_TAG} \
    --name ${_I_TAG} \
    -p 8080:80 \
    ${_I_TAG}
