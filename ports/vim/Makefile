.PHONY: clean fetch extract configure build-dep build install
all:: build-dep build

INSTALL_PREFIX?=$(HOME)/local

PROJ=vim
TAG=v7-4-629

CONFIGURE_ARGS+= --with-features=huge --enable-pythoninterp
CONFIGURE_ARGS+= --enable-luainterp
CONFIGURE_ARGS+= --enable-fail-if-missing
CONFIGURE_ARGS+= --prefix=$(INSTALL_PREFIX)

build-dep:
	-which apt-get > /dev/null && sudo apt-get build-dep -y vim
	-which apt-get > /dev/null && sudo apt-get install -y lua5.2 liblua5.2-dev luajit libluajit-5.1 autoconf automake cproto curl

ARCHIVE=$(TAG).tar.gz
WORKDIR=$(PROJ)-$(TAG)
CONFIG_LOG=$(WORKDIR)/src/auto/config.log

$(ARCHIVE):
	curl -L http://$(PROJ).googlecode.com/archive/$(TAG).tar.gz -o $(TAG).tar.gz

$(WORKDIR):| $(ARCHIVE)
	tar -xf $(ARCHIVE)

$(CONFIG_LOG):| $(WORKDIR)
	cd $(WORKDIR); ./configure $(CONFIGURE_ARGS)

clean:
	rm -rf $(ARCHIVE)
	rm -rf $(WORKDIR)

fetch: $(ARCHIVE)
extract: $(WORKDIR)
configure: $(CONFIG_LOG)
build: configure
	cd $(WORKDIR); make

install:
	cd $(WORKDIR); make install
