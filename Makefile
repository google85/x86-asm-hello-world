SRC_FILE := hello_world

SRC_DIR := ./src
BUILD_DIR := ./build
SRC_IN := ${SRC_DIR}/${SRC_FILE}.asm
BIN_OUT := ${BUILD_DIR}/${SRC_FILE}.o
BUILD_CC:=nasm
BUILD_FLAGS:=-f elf32

.PHONY: help
help:
	@echo "Usage":
	@sed -n 's/^##//p' ${MAKEFILE_LIST} |  sed -e 's/^/ /'

## build: Build the application
.PHONY: build
build:
	@mkdir -p ${BUILD_DIR} && chown 1000:1000 ${BUILD_DIR}
	${BUILD_CC} $(BUILD_FLAGS) -o ${BIN_OUT} ${SRC_IN}
	hexdump -C ${BIN_OUT}

## clean: Clean-up the build binaries
.PHONY: clean
clean:
	@echo "Cleaning up..."
	@rm -rf ${BUILD_DIR}
