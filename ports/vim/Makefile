.PHONY: clean fetch extract build-dep build install
all: build-dep fetch extract build

INSTALL_PREFIX?=${HOME}/local

PROJ=vim
TAG=v7-4-585

ARCHIVE=${TAG}.tar.gz
WORKDIR=${PROJ}-${TAG}

${ARCHIVE}:
	curl -L http://${PROJ}.googlecode.com/archive/${TAG}.tar.gz -o ${TAG}.tar.gz

${WORKDIR}: ${ARCHIVE}
	tar -xvzf ${ARCHIVE}

clean:
	rm -rf ${ARCHIVE}
	rm ${WORKDIR}

fetch: ${ARCHIVE}
extract: ${WORKDIR}

build-dep:
	-which apt-get > /dev/null && sudo apt-get build-dep vim
	-which apt-get > /dev/null && sudo apt-get install lua5.2 liblua5.2-dev luajit libluajit-5.1 autoconf automake cproto

CONFIGURE_ARGS+= --with-features=huge --enable-pythoninterp
CONFIGURE_ARGS+= --enable-luainterp
CONFIGURE_ARGS+= --enable-fail-if-missing
CONFIGURE_ARGS+= --prefix=${INSTALL_PREFIX}

build:
	cd ${WORKDIR}; ./configure ${CONFIGURE_ARGS}; make

install: 
	cd ${WORKDIR}; make install
