#!/bin/bash
# SPDX-License-Identifier: MIT
##############################################################################
# Copyright (c) 2018 The Linux Foundation and others.
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
##############################################################################

PREFIX="$WORKSPACE/_build/ilmbase"

set -eux -o pipefail

cd IlmBase || exit
./bootstrap
./configure --prefix="$PREFIX"
OS=$(uname)
if [[ "$OS" == "Linux" ]]; then
  NPROC=$(cat /proc/cpuinfo|grep processor|wc -l)
else
  NPROC=1
fi
make -j${NPROC} || exit 1
echo "Running tests..."
make -j${NPROC} check || exit 1
echo "Installing..."
make install || exit 1

mkdir -p "$WORKSPACE/dist"
tar -cJvf "$WORKSPACE/dist/ilmbase.tar.xz" -C "$PREFIX" .

sudo tar -xvf "$WORKSPACE/dist/ilmbase.tar.xz" -C "/usr/local"
sudo ldconfig
