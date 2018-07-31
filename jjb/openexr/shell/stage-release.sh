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

STAGING_PROFILE_ID="108c57f6f68863"
CLASSIFIER="linux-amd64"

# shellcheck source=/tmp/v/lftools/bin/activate disable=SC1091
source "/tmp/v/lftools/bin/activate"

set -eux -o pipefail

ilmbase_version="$(grep AC_INIT ./IlmBase/configure.ac | awk -F', ' '{print $NF}' | awk -F')' '{print $1}')"
pyilmbase_version="$(grep AC_INIT ./PyIlmBase/configure.ac | awk -F', ' '{print $NF}' | awk -F')' '{print $1}')"
openexr_version="$(grep AC_INIT ./OpenEXR/configure.ac | awk -F', ' '{print $NF}' | awk -F')' '{print $1}')"
openexr_viewers_version="$(grep AC_INIT ./OpenEXR_Viewers/configure.ac | awk -F', ' '{print $NF}' | awk -F')' '{print $1}')"

repo_id=$(lftools deploy nexus-stage-repo-create "$NEXUS_URL" "$STAGING_PROFILE_ID")

lftools deploy file -c "$CLASSIFIER" "$NEXUS_URL" "$repo_id" \
    io.aswf.openexr \
    ilmbase \
    "$ilmbase_version" \
    tar.xz \
    "$WORKSPACE/dist/ilmbase.tar.xz"

lftools deploy file -c "$CLASSIFIER" "$NEXUS_URL" "$repo_id" \
    io.aswf.openexr \
    pyilmbase \
    "$pyilmbase_version" \
    tar.xz \
    "$WORKSPACE/dist/pyilmbase.tar.xz"

lftools deploy file -c "$CLASSIFIER" "$NEXUS_URL" "$repo_id" \
    io.aswf.openexr \
    openexr \
    "$openexr_version" \
    tar.xz \
    "$WORKSPACE/dist/openexr.tar.xz"

lftools deploy file -c "$CLASSIFIER" "$NEXUS_URL" "$repo_id" \
    io.aswf.openexr \
    openexr_viewers \
    "$openexr_viewers_version" \
    tar.xz \
    "$WORKSPACE/dist/openexr_viewers.tar.xz"

lftools deploy nexus-stage-repo-close "$NEXUS_URL" "$STAGING_PROFILE_ID" "$repo_id"

PATCH_DIR="$WORKSPACE/archives/patches"
mkdir -p "$PATCH_DIR"
echo "openexr" "$(git rev-parse --verify HEAD)" | tee -a "$PATCH_DIR/taglist.log"
