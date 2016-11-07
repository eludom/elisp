#! /bin/bash
#
# Link files from this directory into $HOME
#

set -e -u

linkTo=$HOME
linkThese=( `pwd` )
link2=~/bin/link2

rm -f ~/elisp-public || true
ln -s `pwd` ~/elisp-public




