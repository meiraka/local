.PHONY: clean fetch extract build-dep build install
all: build-dep fetch extract build

INSTALL_PREFIX?=${HOME}/local

USER=chjj
REPO=compton
TAG=0.1_beta2

ARCHIVE=v${TAG}.tar.gz
WORKDIR=${REPO}-${TAG}

${ARCHIVE}:
	curl -L https://github.com/${USER}/${REPO}/archive/${ARCHIVE} -o ${ARCHIVE}

${WORKDIR}: ${ARCHIVE}
	tar -xvzf ${ARCHIVE}

clean:
	rm -rf ${WORKDIR}
	rm ${ARCHIVE}

fetch: ${ARCHIVE}
extract: ${WORKDIR}

build-dep:
	-which apt-get > /dev/null && sudo apt-get install libconfig-dev libdbus-1-dev libgl1-mesa-dev asciidoc

build:
	cd ${WORKDIR}; make; make docs

install:
	cd ${WORKDIR}; PREFIX=${INSTALL_PREFIX} make install
