.PHONY: develop desktop
all: develop desktop

develop: build-dep
	-which apt-get > /dev/null && sudo apt-get install -y git zsh tmux vim
	cd ports; make develop
	cd dotfiles; ./bootstrap

desktop: build-dep
	mkdir -p ~/.themes
	mkdir -p ~/.fonts
	-which apt-get > /dev/null && sudo apt-get install -y thunar thunar-archive-plugin thunar-media-tags-plugin xfce4-power-manager xfce4-power-manager-plugins vlc lxappearance nitrogen gmrun pavucontrol xmonad xmobar trayer rxvt-unicode-256color
	cd ports; make desktop

build-dep:
	-which apt-get > /dev/null && sudo apt-get install -y git build-essential
