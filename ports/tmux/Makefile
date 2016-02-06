.PHONY: clean fetch extract patch build-dep build install
all: build

INSTALL_PREFIX?=$(HOME)
REQUIRE_APT=libevent-dev

USER=tmux
REPO=tmux
TAG=2.1

ARCHIVE=master.zip
#ARCHIVE=$(TAG).tar.gz
WORKDIR=tmux-master
#WORKDIR=$(REPO)-$(TAG)
CONFIGURE_ARGS+= --prefix=$(INSTALL_PREFIX)

$(ARCHIVE):
	curl -L https://github.com/$(USER)/$(REPO)/archive/$(ARCHIVE) -o $(ARCHIVE)

$(WORKDIR):| $(ARCHIVE)
	#tar -xzf $(ARCHIVE)
	unzip $(ARCHIVE)

clean:
	rm -rf $(WORKDIR)
	rm $(ARCHIVE)

fetch: $(ARCHIVE)
extract: $(WORKDIR)
build-dep: apt

build: $(WORKDIR) build-dep
	cd $(WORKDIR); sh autogen.sh
	cd $(WORKDIR); ./configure $(CONFIGURE_ARGS)
	cd $(WORKDIR); make

install:
	cd $(WORKDIR); make install

include ../make.rules
