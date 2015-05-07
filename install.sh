#! /bin/bash
#
# This script instlls George Jones's elisp files
#
# See https://github.com/eludom/elisp
#
# <2015-05-07 Thu>

set -e -u -w

THING="elisp"

INSTALLTO="${HOME}/git/github.com/eludom"
mkdir -p ${INSTALLTO}
cd ${INSTALLTO}

if [ -d ${THING} ]; then
  cd ${THING}
  git pull
else
  git clone https://github.com/eludom/${THING}.git
fi

cd ~
rm -f ${THING}
ln -s ${INSTALLTO}/${THING} .





