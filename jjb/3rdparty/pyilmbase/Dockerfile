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

ADD pyilmbase-2.2.0.tar.gz $ASWF_BUILD_DIR

# ilmbase and boost dependencies
ADD ilmbase-2.2.0-vfx-2018.tar.bz2 $ASWF_ROOT_DIR
ADD boost-1.61.0-vfx-2018.tar.bz2 $ASWF_ROOT_DIR
ENV PKG_CONFIG_PATH $ASWF_ROOT_DIR/ilmbase/lib/pkgconfig
ENV LD_LIBRARY_PATH $ASWF_ROOT_DIR/ilmbase/lib:$ASWF_ROOT_DIR/boost/lib

WORKDIR $ASWF_BUILD_DIR/pyilmbase-2.2.0
RUN ./configure \
        --prefix=$ASWF_ROOT_DIR/pyilmbase \
        --with-boost-include-dir=$ASWF_ROOT_DIR/boost/include \
        --with-boost-lib-dir=$ASWF_ROOT_DIR/boost/lib

RUN make
RUN make install

# Generating the tarball as part of running the image.
# Needs "-v `pwd`:/mnt/dist" while running
WORKDIR $ASWF_ROOT_DIR
ENTRYPOINT tar -cvjSf /mnt/dist/pyilmbase-2.2.0-vfx-2018.tar.bz2 pyilmbase
