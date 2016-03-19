.PHONY: clean fetch extract build-dep build install
all: build-dep fetch extract build

USER=yascentur
REPO=Ricty
TAG=3.2.4
REQUIRE_APT += fontforge curl

ARCHIVE=$(TAG).tar.gz
WORKDIR=$(REPO)-$(TAG)

INCONSOLATA=Inconsolata.otf
INCONSOLATA_URL=http://levien.com/type/myfonts/$(INCONSOLATA)

MIGU=migu-1m-20130617
MIGU_REGULAR=$(MIGU)/migu-1m-regular.ttf
MIGU_BOLD=$(MIGU)/migu-1m-bold.ttf
MIGU_ARCHIVE=$(MIGU).zip
MIGU_URL=http://sourceforge.jp/frs/redir.php?m=jaist&f=%2Fmix-mplus-ipa%2F59022%2F$(MIGU_ARCHIVE)

$(MIGU_ARCHIVE):
	curl -L "$(MIGU_URL)" -o $(MIGU_ARCHIVE)

$(MIGU_REGULAR) $(MIGU_BOLD):| $(MIGU_ARCHIVE)
	unzip -o $(MIGU_ARCHIVE)

$(INCONSOLATA):
	curl -L $(INCONSOLATA_URL) -o $(INCONSOLATA)

$(ARCHIVE):
	curl -L https://github.com/$(USER)/$(REPO)/archive/$(ARCHIVE) -o $(ARCHIVE)

$(WORKDIR):| $(ARCHIVE)
	tar -xzf $(ARCHIVE)

$(WORKDIR)/Ricty*.ttf:| $(WORKDIR) $(INCONSOLATA) $(MIGU_REGULAR) $(MIGU_BOLD)
	cd $(WORKDIR); ./ricty_generator.sh ../$(INCONSOLATA) ../$(MIGU_REGULAR) ../$(MIGU_BOLD)

clean:
	rm -rf $(WORKDIR)
	rm $(ARCHIVE)
	rm $(INCONSOLATA)
	rm -rf $(MIGU)
	rm $(MIGU_ARCHIVE)

fetch: $(ARCHIVE)
extract: $(WORKDIR)

build-dep: apt

build: $(WORKDIR)/Ricty*.ttf

install:
	cp -f $(WORKDIR)/Ricty*.ttf ~/.fonts/
	fc-cache -vf

include ../make.rules
