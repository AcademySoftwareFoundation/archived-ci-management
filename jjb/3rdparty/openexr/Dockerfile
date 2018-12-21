FROM centos/devtoolset-6-toolchain-centos7

ENV ASWF_BUILD_DIR /tmp/vfx-build
ENV ASWF_ROOT_DIR /opt/aswf/vfx2018

USER root

RUN mkdir -p $ASWF_BUILD_DIR && \
    mkdir -p $ASWF_ROOT_DIR

# Common requirements
RUN yum install -y make bzip2 file

ADD openexr-2.2.0.tar.gz $ASWF_BUILD_DIR

ADD ilmbase-2.2.0-vfx-2018.tar.bz2 $ASWF_ROOT_DIR
ENV PKG_CONFIG_PATH $ASWF_ROOT_DIR/ilmbase/lib/pkgconfig
ENV LD_LIBRARY_PATH $ASWF_ROOT_DIR/ilmbase/lib

# OpenEXR requirements
RUN yum install -y which zlib-devel

WORKDIR $ASWF_BUILD_DIR/openexr-2.2.0

RUN ./configure --prefix=$ASWF_ROOT_DIR/openexr

RUN make

RUN make install

# Generating the tarball as part of running the image.
# Needs "-v `pwd`:/mnt/dist" while running
WORKDIR $ASWF_ROOT_DIR
ENTRYPOINT tar -cvjSf /mnt/dist/openexr-2.2.0-vfx-2018.tar.bz2 openexr
