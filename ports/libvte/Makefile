.PHONY: clean fetch extract build-dep build install
all: build

INSTALL_PREFIX?=$(HOME)
REQUIRE_APT=gperf gtk-doc-tools libglib2.0-dev libgtk-3-dev gobject-introspection

USER=GNOME
REPO=vte
TAG=0.36.4

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
build-dep: apt

build: $(WORKDIR) build-dep
	cd $(WORKDIR); ./autogen.sh $(CONFIGURE_ARGS)
	cd $(WORKDIR); make CMAKE_EXTRA_FLAGS="$(CMAKE_ARGS)"

install:
	cd $(WORKDIR); make install

include ../../share/make/apt.rules
