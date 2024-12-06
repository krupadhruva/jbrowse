# -*- Makefile -*-

# type command is shell builtin and varies between shells
SHELL=bash

APP_NAME=jbrowse
ifeq ($(MACHINE),)
	MACHINE := $(shell uname -m)
endif
ifeq ($(DOCKER_HUB_USERNAME),)
	DOCKER_HUB_USERNAME := $(shell whoami)
endif
IMAGE_NAME=${DOCKER_HUB_USERNAME}/${APP_NAME}-${MACHINE}
DOCKER_IMAGE=docker.io/${IMAGE_NAME}
DOCKER_TAG=latest

DOCKER_IMAGE_ID=$(shell docker image ls -q -f reference=${IMAGE_NAME})
DOCKER_PROCESS_ID=$(shell docker ps -q -f name=${APP_NAME})
DOCKER_CONTAINER_ID=$(shell docker container ls -a -q -f name=${APP_NAME})

RUFF=$(shell 2>/dev/null type -p ruff)

# Run docker in foreground when debugging
ifeq ($(DEBUG),)
	DOCKER_OPTS="-d"
endif

all:
	@echo Run specific commands: lint, clean, build, push, rund, run ...
	@echo Using docker hub username: ${DOCKER_HUB_USERNAME} for push, override by setting DOCKER_HUB_USERNAME

build: stop
	@docker build --build-arg APP_NAME=${APP_NAME} -t ${DOCKER_IMAGE}:${DOCKER_TAG} .

push: build
	@docker push ${DOCKER_IMAGE}:${DOCKER_TAG}

run:
	@if [ -n "${DOCKER_CONTAINER_ID}" ]; then docker container rm ${DOCKER_CONTAINER_ID}; fi
	@docker run --name ${APP_NAME} ${DOCKER_OPTS} --rm -p 8080:80 ${DOCKER_IMAGE}:${DOCKER_TAG}
	@echo "Open http://localhost:8080/"

rund: DOCKER_OPTS=
rund: run

ifneq ($(RUFF),)
lint:
	ruff check --select I --fix jbrowse .
	ruff format jbrowse .
else
lint:
	@echo "warning: ruff not found! More info at https://astral.sh/ruff"
endif

stop:
	@if [ -n "${DOCKER_PROCESS_ID}" ]; then docker stop ${DOCKER_PROCESS_ID}; fi

debug:
	@echo DOCKER_IMAGE_ID=${DOCKER_IMAGE_ID}, DOCKER_PROCESS_ID=${DOCKER_PROCESS_ID}, DOCKER_CONTAINER_ID=${DOCKER_CONTAINER_ID}

shell:
	@if [ -n "${DOCKER_PROCESS_ID}" ]; then docker exec -w /app -u jb2 -it ${DOCKER_PROCESS_ID} bash; fi

clean: stop
	@if [ -n "${DOCKER_CONTAINER_ID}" ]; then docker container rm ${DOCKER_CONTAINER_ID}; fi
	@if [ -n "${DOCKER_IMAGE_ID}" ]; then docker rmi -f ${DOCKER_IMAGE_ID}; fi

.PHONEY: clean lint debug shell build push run rund stop
