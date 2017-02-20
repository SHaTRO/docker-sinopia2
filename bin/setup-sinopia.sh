#!/bin/bash


export SINOPIA_BASE=/opt/sinopia

cd $SINOPIA_BASE

prepdir() {
    local SUBDIR=${1}
    local SUBDESC=${2:-$1}
    local NEWDIR=${SINOPIA_BASE}/${SUBDIR}
    if [ ! -d ${NEWDIR} ]; then
        echo "Creating $SUBDESC directory..."
        mkdir -p ${NEWDIR}
    fi
}

prepdir conf configuration
prepdir log
prepdir storage

CONFIG_FILE=${SINOPIA_BASE}/conf/config.yml
if [ ! -f ${CONFIG_FILE} ]; then 
    echo "Config file doesn't exist, initializing it..."
    BASE_CONFIG=/home/sinopia/base-config.yml
    if [ -f ${BASE_CONFIG} ]; then
        echo "Copying base into proper location..."
        cp ${BASE_CONFIG} ${CONFIG_FILE}
    else
        echo "Can't copy base into proper location (base config ${BASE_CONFIG} doesn't exist)..."
    fi
else
    echo "Starting with existing configuration..."
fi

/home/sinopia/node_modules/sinopia2/bin/sinopia -c ${CONFIG_FILE} || tail -f /home/sinopia/setup-sinopia.sh


