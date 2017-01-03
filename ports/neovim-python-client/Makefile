.PHONY: clean fetch extract build-dep build install
all: build-dep extract

REQUIRE_APT=python-setuptools python3-setuptools python-dev python3-dev
USER=neovim
REPO=python-client
TAG=0.1.9

ARCHIVE=$(TAG).tar.gz
WORKDIR=$(REPO)-$(TAG)
CMAKE_ARGS = -DCMAKE_INSTALL_PREFIX:PATH=$(INSTALL_PREFIX)

$(ARCHIVE):
	curl -L https://github.com/$(USER)/$(REPO)/archive/$(ARCHIVE) -o $(ARCHIVE)

$(WORKDIR):| $(ARCHIVE)
	tar -xzf $(ARCHIVE)

clean:
	rm -rf $(WORKDIR)
	rm $(ARCHIVE)

fetch: $(ARCHIVE)
extract: $(WORKDIR)
build-dep: apt

install:
	cd $(WORKDIR); /usr/bin/python2 setup.py install --user

include ../../share/make/apt.rules
