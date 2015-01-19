.PHONY: clean fetch extract build-dep build install
all: fetch extract build-dep build

USER=chjj
REPO=compton
TAG=0.1_beta2

v${TAG}.tar.gz:
	curl -L https://github.com/${USER}/${REPO}/archive/v${TAG}.tar.gz -o v${TAG}.tar.gz


${REPO}-${TAG}: v${TAG}.tar.gz
	tar -xvzf v${TAG}.tar.gz

clean:
	rm -rf ${REPO}-${TAG}
	rm v${TAG}.tar.gz

fetch: v${TAG}.tar.gz
extract: ${REPO}-${TAG}

build-dep:
	sudo apt-get install libconfig-dev libdbus-1-dev libgl1-mesa-dev asciidoc

build:
	cd ${REPO}-${TAG}; make; make docs

install:
	cd ${REPO}-${TAG}; PREFIX=~/local make install
