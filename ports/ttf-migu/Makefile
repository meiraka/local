.PHONY: clean fetch extract build-dep build install
all: build-dep fetch extract

MIGU_URL_BASE=http://sourceforge.jp/frs/redir.php?m=jaist&f=%2Fmix-mplus-ipa%2F59022%2F

MIGU1M=migu-1m-20130617
MIGU1M_REGULAR=$(MIGU1M)/migu-1m-regular.ttf
MIGU1M_BOLD=$(MIGU1M)/migu-1m-bold.ttf
MIGU1M_ARCHIVE=$(MIGU1M).zip
MIGU1M_URL=http://sourceforge.jp/frs/redir.php?m=jaist&f=%2Fmix-mplus-ipa%2F59022%2F$(MIGU1M_ARCHIVE)

MIGU1C=migu-1c-20130617
MIGU1C_REGULAR=$(MIGU1C)/migu-1c-regular.ttf
MIGU1C_BOLD=$(MIGU1C)/migu-1c-bold.ttf
MIGU1C_ARCHIVE=$(MIGU1C).zip
MIGU1C_URL=http://sourceforge.jp/frs/redir.php?m=jaist&f=%2Fmix-mplus-ipa%2F59022%2F$(MIGU1C_ARCHIVE)

MIGU1P=migu-1p-20130617
MIGU1P_REGULAR=$(MIGU1P)/migu-1p-regular.ttf
MIGU1P_BOLD=$(MIGU1P)/migu-1p-bold.ttf
MIGU1P_ARCHIVE=$(MIGU1P).zip
MIGU1P_URL=http://sourceforge.jp/frs/redir.php?m=jaist&f=%2Fmix-mplus-ipa%2F59022%2F$(MIGU1P_ARCHIVE)

$(MIGU1M_ARCHIVE):
	curl -L "$(MIGU1M_URL)" -o $(MIGU1M_ARCHIVE)

$(MIGU1M_REGULAR) $(MIGU1M_BOLD):| $(MIGU1M_ARCHIVE)
	unzip -o $(MIGU1M_ARCHIVE)

$(MIGU1C_ARCHIVE):
	curl -L "$(MIGU1C_URL)" -o $(MIGU1C_ARCHIVE)

$(MIGU1C_REGULAR) $(MIGU1C_BOLD):| $(MIGU1C_ARCHIVE)
	unzip -o $(MIGU1C_ARCHIVE)

$(MIGU1P_ARCHIVE):
	curl -L "$(MIGU1P_URL)" -o $(MIGU1P_ARCHIVE)

$(MIGU1P_REGULAR) $(MIGU1P_BOLD):| $(MIGU1P_ARCHIVE)
	unzip -o $(MIGU1P_ARCHIVE)

clean:
	rm -rf $(MIGU1M)
	rm $(MIGU1M_ARCHIVE)
	rm -rf $(MIGU!C)
	rm $(MIGU!C_ARCHIVE)
	rm -rf $(MIGU!P)
	rm $(MIGU!P_ARCHIVE)

build-dep:
	-which apt-get > /dev/null && sudo apt-get install -y curl

fetch: $(MIGU1M_ARCHIVE) $(MIGU1C_ARCHIVE) $(MIGU1P_ARCHIVE)
extract: $(MIGU1M_REGULAR) $(MIGU1M_BOLD) $(MIGU1C_REGULAR) $(MIGU1C_BOLD) $(MIGU1P_REGULAR) $(MIGU1P_BOLD)

install:
	cp -f ./*/*.ttf ~/.fonts/
	fc-cache -vf
