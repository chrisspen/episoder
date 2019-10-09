#!/bin/bash
set -e
cd "$(dirname "$0")"
[ -d .env ] && rm -Rf .env
virtualenv -p python2.7 .env
. .env/bin/activate
pip install -U pip setuptools wheel
pip install -r requirements.txt -r requirements-test.txt
