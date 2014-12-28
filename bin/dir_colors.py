#!/usr/bin/python

# Configuration file for dircolors, a utility to help you set the
# LS_COLORS environment variable used by GNU ls with the --color option.
# Copyright (C) 1996, 1999-2011 Free Software Foundation, Inc.
# Modified 2014 meiraka.
# Copying and distribution of this file, with or without modification,
# are permitted provided the copyright notice and this notice are preserved.
# The keywords COLOR, OPTIONS, and EIGHTBIT (honored by the
# slackware version of dircolors) are recognized but ignored.
# Below, there should be one TERM entry for each termtype that is colorizable

# Pallet
positive = "#425290"
positive_dark = "#12124a"
positive_light = "#bfbff0"
negative = "#b20200"
negative_dark = "#7a1010"
negative_light = "#cf8080"
neutral = "#909090"
neutral_dark = "#202020"
neutral_light = "#f0f0f0"

def truecolor2termcolor(hexnum):
    r = int(hexnum[1:3], 16)
    g = int(hexnum[3:5], 16)
    b = int(hexnum[5:7], 16)
    r6, g6, b6 = [(i * 6 / 256) for i in (r, g, b)]
    if r6 == g6 == b6:
        return 231 + (r + g + b) * 25 / (3 * 256)
    else:
        return 16 + r6 * 6*6 + g6 * 6 + b6

'''
DIR 01;34 # directory
LINK 01;36 # symbolic link. (If you set this to 'target' instead of a
 # numerical value, the color is as for the file pointed to.)
MULTIHARDLINK 00 # regular file with more than one link
FIFO 40;33 # pipe
SOCK 01;35 # socket
DOOR 01;35 # door
BLK 40;33;01 # block device driver
CHR 40;33;01 # character device driver
ORPHAN 40;31;01 # symlink to nonexistent file, or non-stat'able file
SETUID 37;41 # file that is setuid (u+s)
SETGID 30;43 # file that is setgid (g+s)
CAPABILITY 30;41 # file with capability
STICKY_OTHER_WRITABLE 30;42 # dir that is sticky and other-writable (+t,o+w)
OTHER_WRITABLE 34;42 # dir that is other-writable (o+w) and not sticky
STICKY 37;44 # dir with the sticky bit set (+t) and not other-writable
# This is for files with execute permission:
EXEC 01;32
'''

archive = ['.tar', '.tgz', '.arj', '.taz', '.lzh', '.lzma', '.tlz', '.txz',
           '.zip', '.z', '.Z', '.dz', '.gz', '.lz', '.xz',
           '.bz2', '.bz', '.tbz', '.tbz2', '.tz', '.deb', '.rpm',
           '.jar', '.war', '.ear', '.sar', '.rar', '.ace',
           '.zoo', '.cpio', '.7z', '.rz']

image = ['.jpg', '.jpeg', '.gif', '.bmp', '.pbm', '.pgm', '.ppm', '.tga',
         '.xbm', '.xpm', '.tif', '.tiff',
         '.png', '.svg', '.svgz', '.mng', '.pcx',
         '.mov', '.mpg', '.mpeg', '.m2v', '.mkv', '.webm', '.ogm', '.mp4',
         '.m4v', '.mp4v', '.vob', '.qt', '.nuv', '.wmv',
         '.asf', '.rm', '.rmvb', '.flc', '.avi', '.fli', '.flv', '.gl',
         '.dl', '.xcf', '.xwd', '.yuv', '.cgm', '.emf',
         '.axv', '.anx', '.ogv', '.ogx']


audio = ['.aac', '.au', '.flac', '.mid', '.midi', '.mka', '.mp3', '.mpc',
         '.ogg', '.ra', '.wav', '.axa', '.oga', '.spx', '.xspf']

source = ['.c', '.cc', '.cpp', '.c', '.py', '.java', '.hs', '.scala']
binary = ['.pyc', '.pyo', '.o', '.hi']
header = ['.h', '.hpp']

group = {('00', positive_light): source,
         ('00', negative_light): header,
         ('00', negative_dark): binary,
         ('07', neutral_light): ['DIR'],
         ('04', neutral_light): ['LINK'],
         ('00', neutral): image + audio,
         ('00', positive): archive,
         ('00', negative): ['EXEC']}


print '''
TERM Eterm
TERM ansi
TERM color-xterm
TERM con132x25
TERM con132x30
TERM con132x43
TERM con132x60
TERM con80x25
TERM con80x28
TERM con80x30
TERM con80x43
TERM con80x50
TERM con80x60
TERM cons25
TERM console
TERM cygwin
TERM dtterm
TERM eterm-color
TERM gnome
TERM gnome-256color
TERM jfbterm
TERM konsole
TERM kterm
TERM linux
TERM linux-c
TERM mach-color
TERM mlterm
TERM putty
TERM rxvt
TERM rxvt-256color
TERM rxvt-cygwin
TERM rxvt-cygwin-native
TERM rxvt-unicode
TERM rxvt-unicode-256color
TERM rxvt-unicode256
TERM screen
TERM screen-256color
TERM screen-256color-bce
TERM screen-bce
TERM screen-w
TERM screen.Eterm
TERM screen.rxvt
TERM screen.linux
TERM terminator
TERM vt100
TERM xterm
TERM xterm-16color
TERM xterm-256color
TERM xterm-88color
TERM xterm-color
TERM xterm-debian
RESET 0 # reset to "normal" color
'''

for (style, color), items in group.iteritems():
    termcolor = truecolor2termcolor(color)
    for item in items:
        print '%s %s;38;05;%i' % (item, style, termcolor)
