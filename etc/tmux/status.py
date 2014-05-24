#!/usr/bin/python

import subprocess
import os
import sys
import settings
import copy

ENCODING = u'utf-8'


def flatten(box):
    """flatten output string by box type."""
    box_type = box[u'type']
    text = box[u'text']
    if box_type == u'shell':
        box['output'] = subprocess.check_output(text.split()).replace(u'\n', u'')
    elif box_type == u'env':
        output = os.environ[text] if text in os.environ else ''
    elif box_type == u'plain':
        box['output'] = text
    elif box_type == u'func':
        box['output'] = text()
    else:
        box['output'] = u''
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

def cu(p):
    if type(p) == dict:
        return dict([(cu(k), cu(v)) for k,v in p.iteritems()])
    if type(p) == list:
        return [cu(i) for i in p]
    if type(p) == str:
        return p.decode(ENCODING)
    else:
        return p

def write(settings, pos):
    default = settings[u'default']
    boxes = [flatten(box) for box in settings[pos]]
    strings = [line(box) for box in boxes if box['output']]
    
    for index, box in enumerate(boxes):
        n = boxes[index+1] if index + 1 < len(boxes) else default
        p = boxes[index-1] if index - 1 >= 0 else default
        if pos == 'right':
            sys.stdout.write(splitter(box, p, u'\u2b82', u'\u2b83').encode(ENCODING))
        sys.stdout.write(line(box).encode(ENCODING))
        if pos == 'left':
            sys.stdout.write(splitter(box, n).encode(ENCODING))


if __name__ == '__main__':
    obj = cu(settings.data["status"])
    key = sys.argv[1]
    write(obj, key)
