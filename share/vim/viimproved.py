"""
pretty vim interface.

Copyright 2014 mei raka
"""

from vim import eval, command, buffers, windows, current # flake8: noqa


def _py2vimliteral(python_value):
    if type(python_value) == unicode:
        return u'"%s"' % python_value.replace(u'"', u'\\"')
    elif type(python_value) == str:
        return u'"%s"' % python_value.replace(u'"', u'\\"')
    elif type(python_value) in [int, float]:
        return unicode(python_value)
    elif type(python_value) == bool:
		return str(int(python_value))
    elif type(python_value) == list:
        return '[%s]' % ','.join([_py2vimliteral(i) for i in python_value])
    else:
        raise ValueError(python_value)


class _Functions(object):
    def __getattr__(self, name):
        def func(*args):
            evaled_args =  u', '.join(_py2vimliteral(i) for i in args)
            cmd = u'let s:funcret = %s(%s)' % (name, evaled_args)
            command(cmd)
            ret = eval('s:funcret')
            command('unlet s:funcret')
            return ret
        return func

functions = _Functions()


class _AutoloadFunctions(object):
    class AutoLoad(object):
        def __init__(self, name):
            self.name = name

        def __getattr__(self, name):
            return _Functions.__getattr__(functions,
                                          '%s#%s' % (self.name, name))
    def __init__(self):
        self.autoloads = {} 
    def __getattr__(self, name):
        return self.autoloads.setdefault(name,
                                         _AutoloadFunctions.AutoLoad(name))

autoloads = _AutoloadFunctions()


class _Commands(object):
    def __getattr__(self, name):
        def func(*args):
            encoded_args = u' '.join([unicode(i).replace(' ', '\\ ')
                                      for i in args])
            command('%s %s' % (name, encoded_args))
        return func

commands = _Commands()


class _Settings(object):
    def __getattr__(self, name):
        return eval('&{0}'.format(name))

    def __setattr__(self, name, value):
        default_cmd ='set {name}={value}'
        special_cmds = {True:  ('{name}'),
 		                False: 'set no{name}'}
        if value == True:
            commands.set(name)
        elif value == False:
            commands.set('no' + name)
        else:
            commands.set(name + '=' + unicode(value))

settings = _Settings()


class _GlobalVariables(object):
    def __getattr__(self, name):
        return eval(u'g:%s' % name)

    def __setattr__(self, name, value):
        return commands.let(u'g:%s=%s' % (name,_py2vimliteral(value)))
 
globals = _GlobalVariables()
