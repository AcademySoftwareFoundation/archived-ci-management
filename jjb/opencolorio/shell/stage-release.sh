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

STAGING_PROFILE_ID="126694cb53ec54"
CLASSIFIER="linux-amd64"

# shellcheck source=/tmp/v/lftools/bin/activate disable=SC1091
source "/tmp/v/lftools/bin/activate"

set -eux -o pipefail

MAJOR_VERSION="$(grep 'set(OCIO_VERSION_MAJOR' CMakeLists.txt | awk '{print $NF}' | awk -F')' '{print $1}')"
MINOR_VERSION="$(grep 'set(OCIO_VERSION_MINOR' CMakeLists.txt | awk '{print $NF}' | awk -F')' '{print $1}')"
PATCH_VERSION="$(grep 'set(OCIO_VERSION_PATCH' CMakeLists.txt | awk '{print $NF}' | awk -F')' '{print $1}')"
opencolorio_version="${MAJOR_VERSION}.${MINOR_VERSION}.${PATCH_VERSION}"

repo_id=$(lftools deploy nexus-stage-repo-create "$NEXUS_URL" "$STAGING_PROFILE_ID")

lftools deploy file -c "$CLASSIFIER" "$NEXUS_URL" "$repo_id" \
    io.aswf.opencolorio \
    opencolorio \
    "$opencolorio_version" \
    tar.xz \
    "$WORKSPACE/dist/opencolorio.tar.xz"

lftools deploy nexus-stage-repo-close "$NEXUS_URL" "$STAGING_PROFILE_ID" "$repo_id"
