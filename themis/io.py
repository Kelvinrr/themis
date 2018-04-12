from . import utils

def init(id, outfile):
    '''
    Downloads Themis file by ID and runs it through spice init and
    footprint init.
    '''

    # Download themis file
    out, err = utils.run_davinci('thm_pre_process.dv', infile=id, outfile=outfile)

    # Run spiceinit and footprintint
    try:
        spiceinit(from_=outfile)
    except Exception as e:
        print('Spice Init Error')
        print('file: {}'.format(outfile))
        print("STDOUT:", e.stdout.decode('utf-8'))
        print("STDERR:", e.stderr.decode('utf-8'))
    try:
        footprintinit(from_=outfile)
    except Exception as e:
        print('Footprint Init Error')
        print('file: {}'.format(outfile))
        print("STDOUT:", e.stdout.decode('utf-8'))
        print("STDERR:", e.stderr.decode('utf-8'))


def match(filelist, extraction_kwargs={}, fmatrix_params={}, suppr_params={}, pointreg_params={}, bundle_params={}):
    '''
    Matches a list of files.

    Parameters
    ----------
    filelist : list
               list of files to match, they must of had spiceinit and footprint init run on them

    fmatrix_params : dict
                     Dictionary of params for computing the fundamental matrix

    suppr_params : dict
                   Dictionary of params for spatially suppressing control points

    pointreg_params : dict
                      parameters for the isis3 application point for subpixel registration

    bundle_params : dict
                    parameters for the isis3 application jigsaw for bundle adjustment

    See Also
    --------
    extractor params: https://github.com/USGS-Astrogeology/autocnet/blob/dev/autocnet/matcher/cpu_extractor.py
    ration check params: https://github.com/USGS-Astrogeology/autocnet/blob/dev/autocnet/matcher/cpu_outlier_detector.py
    spatial suppression params: https://github.com/USGS-Astrogeology/autocnet/blob/dev/autocnet/matcher/cpu_outlier_detector.py
    jigsaw: https://isis.astrogeology.usgs.gov/Application/presentation/Tabbed/jigsaw/jigsaw.html
    pointreg: https://isis.astrogeology.usgs.gov/Application/presentation/Tabbed/pointreg/pointreg.html
    '''
    cg = CandidateGraph.from_filelist(filelist)
    # The range of DN values over the data is small, so the threshold for differentiating interesting features must be small.
    cg.extract_features(extractor_parameters={'contrastThreshold':0.0000000001})
    cg.match()

    e = cg.edge[0][1]
    e.symmetry_check()
    e.ratio_check(clean_keys=['symmetry'])

    cg.compute_fundamental_matrices(clean_keys=['symmetry', 'ratio'], reproj_threshold=1, mle_reproj_threshold=0.2)
    cg.suppress(clean_keys=['fundamental'], suppression_func=suppression_funcs.distance, k=20, min_radius=10)

    cnet = '{}_{}'.format(filid1, filid2)
    cnet_file = '{}.net'.format(cnet)
    cg.create_control_network(clean_keys=['fundamental', 'suppression'])
    cg.to_isis(cnet)
