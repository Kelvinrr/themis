import glob
import os
import argparse

import pandas as pd
import numpy as np

from collections import OrderedDict
from autocnet import CandidateGraph
from autocnet.graph.edge import Edge
from osgeo import gdal
from osgeo import osr
from shapely import wkt
from shapely.geometry import Point
from PIL import Image, ImageDraw
from scipy.stats.mstats import zscore
from scipy.stats import gaussian_kde
from plio.io.io_gdal import GeoDataset
from subprocess import Popen, PIPE
from pysis.isis import spiceinit, footprintinit, jigsaw, pointreg, cam2map
from pysis.exceptions import ProcessError
from plio.date import marstime

os.environ['ISISROOT'] = '/nfs/software/isis3/isis'
subprocess.check_call(["/nfs/software/isis3/isis/scripts/isis3Startup.sh"])

record = OrderedDict({
    'file_id1' : '',
    'file_id2' : '',
    'file_path1' : '',
    'file_path2': '',
    'localtime1' : 0,
    'localtime2' : 0,
    'solarlon1' : 0,
    'solarlon2' : 0,
    'mars_year1' : 0,
    'mars_year2' : 0,
    'delta_time' : 0,
    'residual_min' : 0,
    'residual_max' : 0,
    'incident_angle1' : 0,
    'incident_angle2' : 0,
    'stddev1' : 0,
    'stddev2' : 0,
    'avg1' : 0,
    'avg2' : 0,
    'min1' : 0,
    'min2' : 0,
    'max1' : 0,
    'max2' : 0,
    'diff_avg' : 0,
    'diff_stddev' : 0,
})

def kde(data):
    density = gaussian_kde(data)
    xs = np.linspace(np.min(data),np.max(data),200)
    density.covariance_factor = lambda : .1
    density._compute_covariance()
    plot(xs,density(xs))


def run_davinci(script, infile, outfile, dpath='/nfs/software/davinci_install/share/davinci/library/bin/', args=[]):
    command = ['davinci', '-f', '{}{}'.format(dpath, script), 'from={}'.format(infile), 'to={}'.format(outfile)]
    if args:
        command.extend(args)
    print(' '.join(command))
    p = Popen(command, stdin=PIPE, stdout=PIPE, stderr=PIPE)
    output, err = p.communicate(b"input data that is passed to subprocess' stdin")
    rc = p.returncode

    if rc != 0:
        raise Exception('Davinci returned non-zero error code {} : {}'.format(rc, err.decode('utf-8')))
    return output.decode('utf-8'), err.decode('utf-8')

if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('id1', action='store', help='Provide the name of the output file.')
    parser.add_argument('id2', action='store', help='Provide the name of the output file.')
    parser.add_argument('--workdir', action='store', help='The directory to store downloaded cubes.', default='.')
    args = parser.parse_args().__dict__

    # Glob the dir for a file list of the lvl 1
    root_dir = args['workdir']
    files = glob.glob(os.path.join(root_dir, '*lev1.cub'))
