#!/bin/bash

set -eux -o pipefail

cd $WORKSPACE/jjb/3rdparty/ilmbase && wget --no-clobber http://download.savannah.nongnu.org/releases/openexr/ilmbase-2.2.0.tar.gz
