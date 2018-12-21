#!/bin/bash

set -eux -o pipefail

cd $WORKSPACE/jjb/3rdparty/boost && wget --no-clobber https://sourceforge.net/projects/boost/files/boost/1.61.0/boost_1_61_0.tar.bz2
