.PHONY: devel desktop

REQUIRE_APT=git build-essential curl zsh
REQUIRE_GO=github.com/motemen/ghq

devel: build-dep
	cd ports; make devel
	cd dotfiles; make
	zsh bin/localupdate-go

desktop: devel
	make -f Make.desktop

build-dep: apt goget

include share/make/apt.rules
include share/make/goget.rules
