#! /bin/bash
#
# Create a symlink in ~ to the current directory
#

set -e -u

REALDIR=`pwd`
mkdir -p ${REALDIR}
cd ${REALDIR}

base=`basename ${REALDIR}`
now=`date "+%Y%m%d:%H%M"`

cd ~
if [ -e ${base} ]; then
  mv ${base} ${base}.${now}
fi

ln -s ${REALDIR} .





