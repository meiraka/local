import subprocess
import os

def mpd():
    out = subprocess.check_output(['mpc']).decode('utf-8').splitlines()
    if len(out) == 3 and out[1].find('playing') != -1:
        host = u'at %s' % os.environ[u'MPD_HOST'] if u'MPD_HOST' in os.environ else ''
        song = out[0]
        return u'now plaing %s %s' % (host, song)
    else:
        return u''
