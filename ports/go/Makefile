.PHONY: clean fetch extract build-dep build install
all: extract

INSTALL_PREFIX?=$(HOME)
REQUIRE_APT=curl

OS=linux-amd64
VERSION=1.7.1

ARCHIVE=go$(VERSION).$(OS).tar.gz
WORKDIR=go$(VERSION)
INSTALL_PATH=$(INSTALL_PREFIX)/local/go

$(ARCHIVE):
	curl -L https://storage.googleapis.com/golang/$(ARCHIVE) -o $(ARCHIVE)

$(WORKDIR):| $(ARCHIVE)
	tar -xzf $(ARCHIVE)
	mv go $(WORKDIR)

clean:
	rm -rf $(WORKDIR)
	rm $(ARCHIVE)

fetch: $(ARCHIVE)
extract: $(WORKDIR)
build-dep: apt

install: $(WORKDIR)
	@touch $(INSTALL_PATH)
	@rm $(INSTALL_PATH)
	ln -si $(CURDIR)/$(WORKDIR) $(INSTALL_PATH)

include ../../share/make/apt.rules
