.PHONY: develop desktop
all: develop desktop

develop:
	-which apt-get > /dev/null && sudo apt-get install git zsh tmux vim
	cd ports; make develop
	cd dotfiles; ./bootstrap

desktop:
	-which apt-get > /dev/null && sudo apt-get install thunar thunar-archive-plugin thunar-media-tags-plugin xfce4-power-manager xfce4-power-manager-plugins vlc lxappearance nitrogen gmrun pavucontrol xmonad xmobar trayer rxvt-unicode-256color
	cd ports; make desktop

