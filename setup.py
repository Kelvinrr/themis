import themis
import os

from setuptools import setup, find_packages

setup(
    name='themis',
    version=themis.__version__,
    description="Library for processing themis images",
    url="https://github.com/kelvinrr/themis",
    author="Kelvin Rodriguez",
    author_email='krodriguez@usgs.gov',
    license="Public Domain",
    keywords='themis mars odyssey',
    package_dir={'themis': 'themis'},
    packages=find_packages(),
    install_requires =[
                'pandas',
                'pysis',
                'pyyaml',
                'scipy'
            ],
    classifiers=[
        'License :: OSI Approved :: GNU General Public License v2 or later (GPLv2+)',
        'Programming Language :: Python :: 3.5',
        'Programming Language :: Python :: 3.6',
        'Operating System :: Microsoft :: Windows',
        'Operating System :: MacOS',
        'Operating System :: POSIX :: Linux',
        'Topic :: Scientific/Engineering',
    ]
)
