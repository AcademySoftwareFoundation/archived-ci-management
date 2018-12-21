#!/bin/bash

set -eux -o pipefail

cd $WORKSPACE/jjb/3rdparty/tbb && wget --no-clobber https://github.com/01org/tbb/archive/2017_U6.tar.gz
