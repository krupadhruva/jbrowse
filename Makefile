APP_NAME=jbrowse
IMAGE_NAME=mechanicker/${APP_NAME}
DOCKER_IMAGE=docker.io/${IMAGE_NAME}
DOCKER_TAG=latest

DOCKER_IMAGE_ID=$(shell docker image ls -q -f reference=${IMAGE_NAME})
DOCKER_PROCESS_ID=$(shell docker ps -q -f name=${APP_NAME})
DOCKER_CONTAINER_ID=$(shell docker container ls -a -q -f name=${APP_NAME})

all:
	@echo Run specific commands: build/push/run

build:
	@docker build --build-arg APP_NAME=${APP_NAME} -t ${DOCKER_IMAGE}:${DOCKER_TAG} .

push: build
	@docker push ${DOCKER_IMAGE}:${DOCKER_TAG}

run:
	@if [ -n "${DOCKER_CONTAINER_ID}" ]; then docker container rm ${DOCKER_CONTAINER_ID}; fi
	@docker run --name ${APP_NAME} --rm -p 8080:80 ${DOCKER_IMAGE}:${DOCKER_TAG}
	@echo "Open http://localhost:8080/${APP_NAME}/"

stop:
	@if [ -n "${DOCKER_PROCESS_ID}" ]; then docker stop ${DOCKER_PROCESS_ID}; fi

debug:
	@echo DOCKER_IMAGE_ID=${DOCKER_IMAGE_ID}, DOCKER_PROCESS_ID=${DOCKER_PROCESS_ID}, DOCKER_CONTAINER_ID=${DOCKER_CONTAINER_ID}

shell:
	@if [ -n "${DOCKER_PROCESS_ID}" ]; then docker exec -w /usr/share/nginx/html/${APP_NAME} -it ${DOCKER_PROCESS_ID} bash; fi

clean: stop
	@if [ -n "${DOCKER_CONTAINER_ID}" ]; then docker container rm ${DOCKER_CONTAINER_ID}; fi
	@if [ -n "${DOCKER_IMAGE_ID}" ]; then docker rmi -f ${DOCKER_IMAGE_ID}; fi

.PHONEY: clean debug shell build push run stop
