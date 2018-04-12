from functools import partial

import subprocess
from subprocess import Popen, PIPE

from . import config

def compose(*functions):
    return reduce(lambda g, f: lambda x: f(g(x)), functions, lambda x: x)


def run_davinci(script, infile=None, outfile=None, bin_dir='', args=[]):
    command = ['davinci', '-f', '{}{}'.format(bin_dir, script), 'from={}'.format(infile), 'to={}'.format(outfile)]

    # add additional positional args
    if args:
        command.extend(args)

    print(' '.join(command))
    p = Popen(command, stdin=PIPE, stdout=PIPE, stderr=PIPE)
    output, err = p.communicate(b"input data that is passed to subprocess' stdin")
    rc = p.returncode

    if rc != 0:
        raise Exception('Davinci returned non-zero error code {} : {}'.format(rc, err.decode('utf-8')))
    return output.decode('utf-8'), err.decode('utf-8')

# patch in davinci_bin onto run_davinci to prevent contstantly having to pass it in
run_davinci = partial(run_davinci, bin_dir=config.davinci_bin)
