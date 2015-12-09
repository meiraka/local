.PHONY: clean fetch extract patch build-dep build install
all: build

INSTALL_PREFIX?=$(HOME)/local


USER=tmux
REPO=tmux
TAG=2.1

ARCHIVE=$(TAG).tar.gz
WORKDIR=$(REPO)-$(TAG)
CONFIGURE_ARGS+= --prefix=$(INSTALL_PREFIX)

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
	-which apt-get > /dev/null && sudo apt-get build-dep -y tmux

truecolor.patch:
	curl -L https://patch-diff.githubusercontent.com/raw/tmux/tmux/pull/112.patch -o truecolor.patch

patch: $(WORKDIR) truecolor.patch
	@cd $(WORKDIR); patch -t -p1 -d ./ < ../truecolor.patch

build: $(WORKDIR) build-dep patch
	cd $(WORKDIR); sh autogen.sh
	cd $(WORKDIR); ./configure $(CONFIGURE_ARGS)
	cd $(WORKDIR); make


install:
	cd $(WORKDIR); make install
