from utils import run_davinci


def preprocess(id1, id2, config=dict()):
    # Glob the dir for a file list of the lvl 1
    out, err = run_davinci('thm_pre_process.dv', id1, '{}.lev1.cub'.format(id1))
    out, err = run_davinci('thm_pre_process.dv', id2, '{}.lev1.cub'.format(id2]))

    # write out cubelist
    with open(cubelis, 'w') as f:
        f.write(files[0]+'\n')
        f.write(files[1]+'\n')


def init(id1, id2, config=dict()): 
    # Run spiceinit and footprintint - latter helps constrain the search
    try:
        spiceinit(from_=img1)
        spiceinit(from_=img2)
    except Exception as e:
        print('Spice Error')
        print("STDOUT:", e.stdout.decode('utf-8'))
        print("STDERR:", e.stderr.decode('utf-8'))
    try:
        footprintinit(from_=img1)
        footprintinit(from_=img2)
    except Exception as e:
        print('FP Error')
        print("STDOUT:", e.stdout.decode('utf-8'))
        print("STDERR:", e.stderr.decode('utf-8'))
