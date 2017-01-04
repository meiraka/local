#!/usr/bin/make
.PHONY: desktop

REQUIRE_APT=thunar thunar-archive-plugin thunar-media-tags-plugin xfce4-power-manager xfce4-power-manager-plugins vlc lxappearance nitrogen gmrun pavucontrol xmonad xmobar trayer rxvt-unicode-256color sakura

desktop: build-dep
	mkdir -p ~/.themes
	mkdir -p ~/.fonts
	cd ports; make 

build-dep: apt

include share/make/apt.rules
