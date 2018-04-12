from . import utils

def init(id, outname):
    '''
    Downloads Themis file with id and runs it through spice init and
    footprint init.
    '''
    # Glob the dir for a file list of the lvl 1
    out, err = utils.run_davinci('thm_pre_process.dv', id, '{}.lev1.cub'.format(id1))

    # Run spiceinit and footprintint
    try:
        spiceinit(from_=img1)
    except Exception as e:
        print('Spice Error')
        print("STDOUT:", e.stdout.decode('utf-8'))
        print("STDERR:", e.stderr.decode('utf-8'))
    try:
        footprintinit(from_=img1)
    except Exception as e:
        print('FP Error')
        print("STDOUT:", e.stdout.decode('utf-8'))
        print("STDERR:", e.stderr.decode('utf-8'))
