.PHONY: clean fetch extract build-dep build install
all: build

INSTALL_PREFIX?=$(HOME)
REQUIRE_APT=git libtool automake cmake libncurses5-dev g++

USER=neovim
REPO=neovim
TAG=0.1.5

ARCHIVE=v$(TAG).tar.gz
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

build: $(WORKDIR) build-dep
	cd $(WORKDIR); make CMAKE_EXTRA_FLAGS="$(CMAKE_ARGS)"

install:
	cd $(WORKDIR); make install

include ../make.rules
