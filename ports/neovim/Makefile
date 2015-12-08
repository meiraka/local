.PHONY: clean fetch extract build-dep build install
all: build

INSTALL_PREFIX?=$(HOME)/local

USER=neovim
REPO=neovim
TAG=0.1.1

ARCHIVE=v$(TAG).tar.gz
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

build-dep:
	-which apt-get > /dev/null && sudo apt-get install -y git libtool automake cmake libncurses5-dev g++

build: $(WORKDIR) build-dep
	cd $(WORKDIR); make CMAKE_EXTRA_FLAGS="$(CMAKE_ARGS)"


install:
	cd $(WORKDIR); make install
