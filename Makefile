.PHONY: install dotfiles ports themes fonts

REQUIRE_APT =git build-essential curl zsh
REQUIRE_APT+=thunar thunar-archive-plugin thunar-media-tags-plugin
REQUIRE_APT+=xfce4-power-manager xfce4-power-manager-plugins
REQUIRE_APT+=lxappearance nitrogen gmrun pavucontrol
REQUIRE_APT+=xmonad xmobar trayer sakura

REQUIRE_GO = github.com/nsf/gocode github.com/golang/lint/golint
REQUIRE_GO+= github.com/motemen/ghq github.com/peco/peco

PORTS =fzf git go neovim neovim-python-client peco tmux
PORTS+=compton libvte ttf-migu ttf-ricty-diminished

all: dotfiles ports themes fonts
	cd ports; make $(PORTS)

dotfiles:
	cd dotfiles; make

ports:
	cd ports; make $(PORTS)

themes: ~/.themes ~/.themes/gtk-theme-noise

fonts: ~/.fonts

~/.themes/gtk-theme-noise: ~/.themes
	cd ~/.themes; git clone https://github.com/meiraka/gtk-theme-noise.git

~/.themes:
	mkdir -p ~/.themes

~/.fonts:
	mkdir -p ~/.fonts

dep: apt goget

include rules/apt.rules
include rules/goget.rules
