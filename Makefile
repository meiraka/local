.PHONY: devel desktop

REQUIRE_APT=git build-essential curl zsh

devel: build-dep
	cd ports; make devel
	cd dotfiles; make

desktop: devel
	make -f Make.desktop

build-dep: apt

include share/make/apt.rules
