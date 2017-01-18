.PHONY: clean fetch extract build-dep build install
all: build

INSTALL_PREFIX?=$(HOME)
REQUIRE_APT=curl

TAG=v0.4.7
OS=linux_amd64

ARCHIVE=$(TAG)_$(OS).tar.gz
WORKDIR=$(TAG)

$(ARCHIVE):
	curl -L https://github.com/peco/peco/releases/download/$(TAG)/peco_$(OS).tar.gz -o $(ARCHIVE)

$(WORKDIR):| $(ARCHIVE)
	tar -xzf $(ARCHIVE)
	mv peco_$(OS) $(WORKDIR)

clean:
	rm -rf $(WORKDIR)
	rm $(ARCHIVE)
	rm peco_$(OS)

fetch: $(ARCHIVE)
extract: $(WORKDIR)
build-dep: apt

build: build-dep fetch extract

install:
	cp $(WORKDIR)/peco $(INSTALL_PREFIX)/bin/

include ../../share/make/apt.rules
