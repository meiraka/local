dotfiles and toy tools.

REQUIREMENTS
============

* rake
* python
* ruby

at ubuntu desktop(python package is already installed:):

  sudo apt-get install rake

SETUP
=====

require github passed ssh key.

Ubuntu::

  wget "https://raw.github.com/meiraka/local/master/dep/ubuntu.sh"
  chmod +x ubuntu.sh
  ./ubuntu.sh
  chsh -s /bin/zsh
