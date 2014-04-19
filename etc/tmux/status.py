#!/usr/bin/python

import subprocess
import os
import sys
import settings
import copy

ENCODING = u'utf-8'


def flatten(box):
    if box['type'] == u'shell':
        output = box[u'text']
        box['output'] = subprocess.check_output(output.split()).replace(u'\n', u'')
    elif box['type'] == u'plain':
        box['output'] = box[u'text']
    elif box['type'] == u'func':
        box['output'] = box[u'text']()
    else:
        box['output'] = ''
    return box
    

def line(box):
    BG = u'bg'
    FG = u'fg'
    out = u''
    if BG in box:
        out = out + color(BG, box[BG])
    if FG in box:
        out = out + color(FG, box[FG])
    out = out + box[u'output']
    return out


def splitter(p, n, bold=u'\u2b80', thin=u'\u2b81'):
    BG = u'bg'
    FG = u'fg'
    out = u''
    if not p[BG] == n[BG]:
        out = out + color(FG, p[BG])
        out = out + color(BG, n[BG])
        out = out + bold
    else:
        out = out + thin
    return out
 

def color(style, color):
    return u'#[%s=colour%s]' % (style, color)


if __name__ == '__main__':
    obj = settings.data
    key = sys.argv[1]

    default = obj[u'default']
    boxes = [flatten(box) for box in obj[key]]
    strings = [line(box) for box in boxes if box['output']]
    
    for index, box in enumerate(boxes):
        n = boxes[index+1] if index + 1 < len(boxes) else default
        p = boxes[index-1] if index - 1 >= 0 else default
        if key == 'right':
            sys.stdout.write(splitter(box, p, u'\u2b82', u'\u2b83').encode(ENCODING))
        sys.stdout.write(line(box).encode(ENCODING))
        if key == 'left':
            sys.stdout.write(splitter(box, n).encode(ENCODING))
