#!/bin/bash

set -eux -o pipefail

cd $WORKSPACE/jjb/3rdparty/openexr && wget --no-clobber http://download.savannah.nongnu.org/releases/openexr/openexr-2.2.0.tar.gz
