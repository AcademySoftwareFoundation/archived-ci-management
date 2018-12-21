#!/bin/bash

set -eux -o pipefail

cd $WORKSPACE/jjb/3rdparty/pyilmbase && wget --no-clobber http://download.savannah.nongnu.org/releases/openexr/pyilmbase-2.2.0.tar.gz
