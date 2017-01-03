.PHONY: clean fetch extract build-dep build install
all: build

INSTALL_PREFIX?=$(HOME)
REQUIRE_APT=curl

USER=edihbrandon
REPO=RictyDiminished
TAG=3.2.3

ARCHIVE=$(TAG).tar.gz
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

build: build-dep fetch extract

install:
	cp RictyDiminished-$(TAG)/*.ttf ~/.fonts

include ../../share/make/apt.rules
