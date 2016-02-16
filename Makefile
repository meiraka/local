.PHONY: devel desktop

REQUIRE_APT=git build-essential curl git zsh vim

all: devel

devel: build-dep
	cd ports; make devel
	cd dotfiles; make

desktop: build-dep
	mkdir -p ~/.themes
	mkdir -p ~/.fonts
	-which apt-get > /dev/null && sudo apt-get install -y thunar thunar-archive-plugin thunar-media-tags-plugin xfce4-power-manager xfce4-power-manager-plugins vlc lxappearance nitrogen gmrun pavucontrol xmonad xmobar trayer rxvt-unicode-256color
	cd ports; make desktop

build-dep: apt

include make.rules
