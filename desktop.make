#!/usr/bin/make
.PHONY: desktop themes fonts

REQUIRE_APT =thunar thunar-archive-plugin thunar-media-tags-plugin
REQUIRE_APT+=xfce4-power-manager xfce4-power-manager-plugins
REQUIRE_APT+=lxappearance nitrogen gmrun pavucontrol
REQUIRE_APT+=xmonad xmobar trayer sakura

desktop: themes fonts build-dep
	cd ports; make desktop

themes: ~/.themes ~/.themes/gtk-theme-noise

fonts: ~/.fonts

~/.themes/gtk-theme-noise: ~/.themes
	cd ~/.themes; git clone https://github.com/meiraka/gtk-theme-noise.git

~/.themes:
	mkdir -p ~/.themes

~/.fonts:
	mkdir -p ~/.fonts

build-dep: apt

include share/make/apt.rules
