#!/usr/bin/env python
from distutils.core import setup
from os import path

import pyepisoder

CURRENT_DIR = path.abspath(path.dirname(__file__))

def get_reqs(*fns):
    lst = []
    for fn in fns:
        for package in open(path.join(CURRENT_DIR, fn)).readlines():
            package = package.strip()
            if not package:
                continue
            lst.append(package.strip())
    return lst

def get_files():
    # files to install
    files = []
    
    # man page
    manpage = 'episoder.1'
    files.append((path.join('man', 'man1'), ['episoder.1']))
    
    # awk parser
    awkfile = path.join('extras', 'episoder_helper_epguides.awk')
    files.append(('extras', [awkfile]))
    
    # documentation
    for fn in ['AUTHORS', 'CHANGELOG', 'COPYING', 'README.md']:
        files.append((path.join('doc', 'episoder'), [fn]))
    
    files.append((path.join('doc', 'episoder', 'examples'), ['home.episoder']))
    
    return files

setup(
    name='episoder',
    version=pyepisoder.__version__,
    license='GPLv3',
    description='TV episode notifier',
    author='Stefan Ott',
    author_email='stefan@ott.net',
    url='https://github.com/cockroach/episoder',
    packages=['pyepisoder'],
    scripts=['episoder'],
    long_description='episoder is a tool to tell you about new episodes of your favourite TV shows',
    data_files=get_files(),
    install_requires=get_reqs('requirements.txt'),
    tests_require=get_reqs('requirements-test.txt'),
    #https://pypi.python.org/pypi?%3Aaction=list_classifiers
    classifiers=[
        'Development Status :: 5 - Production/Stable',
        'Environment :: Console',
        'Intended Audience :: End Users/Desktop',
        'License :: OSI Approved :: GNU General Public License v3 or later (GPLv3+)',
        'Natural Language :: English',
        'Operating System :: OS Independent',
        'Programming Language :: Python',
        'Programming Language :: Python :: 2.6',
        'Programming Language :: Python :: 2.7',
        'Programming Language :: Python :: 3',
        'Topic :: Multimedia :: Video'
    ]
)
