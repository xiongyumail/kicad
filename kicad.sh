#!/bin/bash
IMAGE_NAME="kicad"
IMAGE_VERSION="5.1.8"

WORK_PATH=$(cd $(dirname $0); pwd)

if [[ "$(sudo docker images -q "${IMAGE_NAME}:${IMAGE_VERSION}" 2> /dev/null)" == "" ]]; then
  ${WORK_PATH}/tools/gdocker/gdocker.sh install -n ${IMAGE_NAME} -v ${IMAGE_VERSION} -t ${WORK_PATH}/tools/tools.sh
fi

if [[ "$1" == "" ]]; then
  PROJECT=${WORK_PATH}/projects
else
  PROJECT=$1
fi

${WORK_PATH}/tools/gdocker/gdocker.sh start -n ${IMAGE_NAME} -v ${IMAGE_VERSION} -c "/bin/bash /home/${IMAGE_NAME}/workspace/sessions.sh" -p $PROJECT
