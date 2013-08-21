# color settings for zshrc

COLOR_RED=161
COLOR_PINK=163
COLOR_PURPLE=092
COLOR_MAGENTA=199
COLOR_SCARLET=160
COLOR_STRAWBERRY=167
COLOR_RASPBERRY=126
COLOR_GREEN=047
COLOR_EMERALD=036
COLOR_PEPPERMINT=037
COLOR_TURQUOISE=038
COLOR_SAPPHIRE=031
COLOR_APLICOT=180
COLOR_MARIGOLD=208
COLOR_CANARY=003
COLOR_SNOW=254
COLOR_IVORY=188
COLOR_MILKEY=230
COLOR_FOG=145
COLOR_LAMP=232

 
COLOR_MAIN=$COLOR_IVORY
COLOR_BG_TMUX=$COLOR_LAMP
COLOR_FG_TMUX=$COLOR_EMERALD
COLOR_BG_TMUX_ACTIVE=$COLOR_FOG
COLOR_FG_TMUX_ACTIVE=$COLOR_LAMP
COLOR_BG_LPROMPT=$COLOR_IVORY
COLOR_FG_LPROMPT=$COLOR_LAMP
COLOR_BG_RPROMPT=$COLOR_FOG
COLOR_FG_RPROMPT=$COLOR_LAMP
COLOR_BG_VCS=$COLOR_TURQUOISE
COLOR_FG_VCS=$COLOR_LAMP

# load from dircolors
# echo > $LS_COLORS >> ~/local/etc/zsh/colorrc
# replace ":" to "' '" and delete last "'"

zstyle ':completion:*' list-colors 'rs=0' 'di=00;04;38;05;048' 'ln=01;36' 'mh=00' 'pi=40;33' 'so=01;35' 'do=01;35' 'bd=40;33;01' 'cd=40;33;01' 'or=40;31;01' 'su=37;41' 'sg=30;43' 'ca=30;41' 'tw=30;42' 'ow=34;42' 'st=37;44' 'ex=01;38;05;170' '*.sh=00;38;05;183' '*.csh=01;32' '*.tar=00;38;05;081' '*.tgz=00;38;05;081' '*.arj=00;38;05;081' '*.taz=00;38;05;081' '*.lzh=00;38;05;081' '*.lzma=00;38;05;081' '*.tlz=00;38;05;081' '*.txz=00;38;05;081' '*.zip=00;38;05;081' '*.z=00;38;05;081' '*.Z=00;38;05;081' '*.dz=00;38;05;081' '*.gz=00;38;05;081' '*.lz=00;38;05;081' '*.xz=00;38;05;081' '*.bz2=00;38;05;081' '*.bz=00;38;05;081' '*.tbz=00;38;05;081' '*.tbz2=00;38;05;081' '*.tz=00;38;05;081' '*.deb=00;38;05;081' '*.rpm=00;38;05;081' '*.jar=00;38;05;081' '*.war=00;38;05;081' '*.ear=00;38;05;081' '*.sar=00;38;05;081' '*.rar=00;38;05;081' '*.ace=00;38;05;081' '*.zoo=00;38;05;081' '*.cpio=00;38;05;081' '*.7z=00;38;05;081' '*.rz=00;38;05;081' '*.jpg=00;38;05;228' '*.jpeg=00;38;05;228' '*.gif=00;38;05;228' '*.bmp=00;38;05;228' '*.pbm=00;38;05;228' '*.pgm=00;38;05;228' '*.ppm=00;38;05;228' '*.tga=00;38;05;228' '*.xbm=00;38;05;228' '*.xpm=00;38;05;228' '*.tif=00;38;05;228' '*.tiff=00;38;05;228' '*.png=00;38;05;228' '*.svg=00;38;05;228' '*.svgz=00;38;05;228' '*.mng=00;38;05;228' '*.pcx=00;38;05;228' '*.mov=00;38;05;208' '*.mpg=00;38;05;208' '*.mpeg=00;38;05;208' '*.m2v=00;38;05;208' '*.mkv=00;38;05;208' '*.webm=00;38;05;208' '*.ogm=00;38;05;208' '*.mp4=00;38;05;208' '*.m4v=00;38;05;208' '*.mp4v=00;38;05;208' '*.vob=00;38;05;208' '*.qt=00;38;05;208' '*.nuv=00;38;05;208' '*.wmv=00;38;05;208' '*.asf=00;38;05;208' '*.rm=00;38;05;208' '*.rmvb=00;38;05;208' '*.flc=00;38;05;208' '*.avi=00;38;05;208' '*.fli=00;38;05;208' '*.flv=00;38;05;208' '*.gl=00;38;05;208' '*.dl=00;38;05;208' '*.xcf=00;38;05;208' '*.xwd=00;38;05;208' '*.yuv=00;38;05;208' '*.cgm=00;38;05;208' '*.emf=00;38;05;208' '*.axv=01;35' '*.anx=01;35' '*.ogv=01;35' '*.ogx=01;35' '*.aac=00;38;05;202' '*.au=00;38;05;202' '*.flac=00;38;05;202' '*.mid=00;38;05;202' '*.midi=00;38;05;202' '*.mka=00;38;05;202' '*.mp3=00;38;05;202' '*.mpc=00;38;05;202' '*.ogg=00;38;05;202' '*.ra=00;38;05;202' '*.wav=00;38;05;202' '*.axa=00;36' '*.oga=00;36' '*.spx=00;36' '*.xspf=00;36'
