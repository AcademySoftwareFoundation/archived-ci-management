FROM centos/devtoolset-6-toolchain-centos7

ENV ASWF_BUILD_DIR /tmp/vfx-build
ENV ASWF_ROOT_DIR /opt/aswf/vfx2018

USER root

RUN mkdir -p $ASWF_BUILD_DIR && \
    mkdir -p $ASWF_ROOT_DIR

# Common requirements
RUN yum install -y which make bzip2

# pyilmbase build requirements
RUN yum install -y file python-devel zlib-devel

RUN curl "https://bootstrap.pypa.io/get-pip.py" -o "get-pip.py" &&\
    python get-pip.py &&\
    pip install numpy==1.12.1

# ilmbase and boost dependencies
ADD ilmbase-2.2.0-vfx-2018.tar.bz2 $ASWF_ROOT_DIR
ADD boost-1.61.0-vfx-2018.tar.bz2 $ASWF_ROOT_DIR
ADD pyilmbase-2.2.0-vfx-2018.tar.bz2 $ASWF_ROOT_DIR
ADD openexr-2.2.0-vfx-2018.tar.bz2 $ASWF_ROOT_DIR
ADD tbb-2017.6-vfx-2018.tar.bz2 $ASWF_ROOT_DIR

ENV PKG_CONFIG_PATH $ASWF_ROOT_DIR/ilmbase/lib/pkgconfig:$ASWF_ROOT_DIR/pyilmbase/lib/pkgconfig:$ASWF_ROOT_DIR/openexr/lib/pkgconfig
ENV LD_LIBRARY_PATH $ASWF_ROOT_DIR/ilmbase/lib:$ASWF_ROOT_DIR/boost/lib:$ASWF_ROOT_DIR/pyilmbase/lib:$ASWF_ROOT_DIR/openexr/lib::$ASWF_ROOT_DIR/tbb/lib
ENV PYTHONPATH $ASWF_ROOT_DIR/pyilmbase/lib

# Generating the tarball as part of running the image.
# Needs "-v `pwd`:/mnt/dist" while running
WORKDIR $ASWF_ROOT_DIR
ENTRYPOINT tar -cvjSf /mnt/dist/all-vfx-2018.tar.bz2 *
