.PHONY: clean fetch extract build-dep build install
all: extract

INSTALL_PREFIX?=$(HOME)/local

USER=neovim
REPO=python-client
TAG=0.1.0

ARCHIVE=$(TAG).tar.gz
WORKDIR=$(REPO)-$(TAG)
CMAKE_ARGS = -DCMAKE_INSTALL_PREFIX:PATH=$(INSTALL_PREFIX)

test:
	echo $(CMAKE_ARGS)

$(ARCHIVE):
	curl -L https://github.com/$(USER)/$(REPO)/archive/$(ARCHIVE) -o $(ARCHIVE)

$(WORKDIR):| $(ARCHIVE)
	tar -xzf $(ARCHIVE)

clean:
	rm -rf $(WORKDIR)
	rm $(ARCHIVE)

fetch: $(ARCHIVE)
extract: $(WORKDIR)

install:
	cd $(WORKDIR); /usr/bin/python2 setup.py install --user
