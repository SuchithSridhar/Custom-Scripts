#!/bin/bash
# Author: Suchith Sridhar
# Website: https://suchicodes.com/
#
# Isolate an image in a temp director
# and open it in nomacs

if [ "$1" == "" ]; then
    echo "Invalid call."
    echo "  $(basename $0) <filename>"
    exit 1
fi

TMP=$HOME/tmp
IMG_VIEWER=nomacs

DIR="$TMP/tmp-$RANDOM"
IMG="$DIR/$(basename $1)"

mkdir -p $DIR

cp $1 $IMG

$IMG_VIEWER $IMG

rm -rf $DIR
