.PHONY: devel desktop

REQUIRE_APT=git build-essential curl zsh
REQUIRE_GO = github.com/nsf/gocode github.com/golang/lint/golint
REQUIRE_GO+= github.com/motemen/ghq github.com/peco/peco
DEVEL_PORTS= fzf git go neovim neovim-python-client peco tmux

devel: build-dep
	cd ports; make $(DEVEL_PORTS)
	cd dotfiles; make


desktop: devel
	make -f desktop.make

build-dep: apt goget

include share/make/apt.rules
include share/make/goget.rules
