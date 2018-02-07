from functools import partial

import subprocess
from subprocess import Popen, PIPE


def compose(*functions):
    return reduce(lambda g, f: lambda x: f(g(x)), functions, lambda x: x)


def run_davinci(script, infile=None, outfile=None, root_dir='', args=[]):
    command = ['davinci', '-f', '{}{}'.format(root_dir, script), 'from={}'.format(infile), 'to={}'.format(outfile)]
    if args:
        command.extend(args)
    print(' '.join(command))
    p = Popen(command, stdin=PIPE, stdout=PIPE, stderr=PIPE)
    output, err = p.communicate(b"input data that is passed to subprocess' stdin")
    rc = p.returncode

    if rc != 0:
        raise Exception('Davinci returned non-zero error code {} : {}'.format(rc, err.decode('utf-8')))
    return output.decode('utf-8'), err.decode('utf-8')
