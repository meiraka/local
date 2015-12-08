.PHONY: clean fetch extract build-dep build install
all: build

INSTALL_PREFIX?=$(HOME)/local


USER=GNOME
REPO=vte
TAG=0.36.4

ARCHIVE=$(TAG).tar.gz
WORKDIR=$(REPO)-$(TAG)
CONFIGURE_ARGS+= --prefix=$(INSTALL_PREFIX)

test:
	echo $(CMAKE_ARGS)

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
	-which apt-get > /dev/null && sudo apt-get build-dep -y vte3 && sudo apt-get install gperf

build: $(WORKDIR) build-dep
	cd $(WORKDIR); ./autogen.sh $(CONFIGURE_ARGS)
	cd $(WORKDIR); make CMAKE_EXTRA_FLAGS="$(CMAKE_ARGS)"


install:
	cd $(WORKDIR); make install
