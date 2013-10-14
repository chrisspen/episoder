#!/usr/bin/env python
from distutils.core import setup
from os import path

# files to install
files = []

# man page
manpage = 'episoder.1'
files.append(('man/man1', ['episoder.1']))

# awk parser
awkfile = path.join('extras', 'episoder_helper_epguides.awk')
files.append(('extras', [awkfile]))

# documentation
for file in [ 'AUTHORS', 'CHANGELOG', 'COPYING', 'README', 'home.episoder' ]:
	files.append(('doc/episoder', [file]))

setup(	name			= 'episoder',
	version			= '0.7.0',
	license			= 'GPLv3',
	description		= 'TV episode notifier',
	author			= 'Stefan Ott',
	author_email		= 'stefan@ott.net',
	url			= 'http://code.ott.net/projects/episoder',
	packages		= [ 'pyepisoder' ],
	scripts			= [ 'episoder' ],
	long_description	= 'episoder is a tool to tell you about new episodes of your favourite TV shows',
	data_files		= files,
	install_requires	= [	'beautifulsoup', 'pyyaml', 'argparse',
					'sqlalchemy>=0.7', 'tvdb_api' ],
	classifiers		= [
		'Development Status :: 5 - Production/Stable',
		'Environment :: Console',
		'Intended Audience :: End Users/Desktop',
		'License :: OSI Approved :: GNU General Public License v3 or later (GPLv3+)',
		'Natural Language :: English',
		'Operating System :: OS Independent',
		'Programming Language :: Python',
		'Topic :: Multimedia :: Video'
	]
)
