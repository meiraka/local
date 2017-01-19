.PHONY: clean fetch extract build-dep install
all: extract

REQUIRE_APT=curl

USER=junegunn
REPO=fzf
TAG=0.16.1
ARCHIVE=$(TAG).tar.gz
WORKDIR=$(REPO)-$(TAG)
INSTALL_OPTIONS = --key-bindings --completion --no-update-rc

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

install:
	cd $(WORKDIR); ./install $(INSTALL_OPTIONS)

include ../../share/make/apt.rules
