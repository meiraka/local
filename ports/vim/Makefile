.PHONY: clean fetch extract configure build-dep build install
all:: build-dep build

INSTALL_PREFIX?=$(HOME)
REQUIRE_APT=lua5.2 liblua5.2-dev luajit autoconf automake cproto curl

USER=vim
REPO=vim
TAG=7.4.1328

CONFIGURE_ARGS+= --with-features=huge --enable-pythoninterp
CONFIGURE_ARGS+= --enable-luainterp
CONFIGURE_ARGS+= --enable-fail-if-missing
CONFIGURE_ARGS+= --prefix=$(INSTALL_PREFIX)

build-dep:apt

CONFIG_LOG=$(WORKDIR)/src/auto/config.log
ARCHIVE=v$(TAG).tar.gz
WORKDIR=$(REPO)-$(TAG)

$(ARCHIVE):
	curl -L https://github.com/$(USER)/$(REPO)/archive/$(ARCHIVE) -o $(ARCHIVE)

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

include ../../share/make/apt.rules
