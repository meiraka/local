.PHONY: clean fetch extract patch build-dep build install
all: build

INSTALL_PREFIX?=$(HOME)/local


USER=sunaku
REPO=tmux
TAG=2.1

ARCHIVE=24bit-color.zip
#ARCHIVE=$(TAG).tar.gz
WORKDIR=tmux-24bit-color
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

build-dep:
	-which apt-get > /dev/null && sudo apt-get build-dep -y tmux

build: $(WORKDIR) build-dep
	cd $(WORKDIR); sh autogen.sh
	cd $(WORKDIR); ./configure $(CONFIGURE_ARGS)
	cd $(WORKDIR); make


install:
	cd $(WORKDIR); make install
