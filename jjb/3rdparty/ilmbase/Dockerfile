FROM centos/devtoolset-6-toolchain-centos7

ENV ASWF_BUILD_DIR /tmp/vfx-build
ENV ASWF_ROOT_DIR /opt/aswf/vfx2018

USER root

RUN mkdir -p $ASWF_BUILD_DIR && \
    mkdir -p $ASWF_ROOT_DIR

# Common requirements
RUN yum install -y make bzip2

ADD ilmbase-2.2.0.tar.gz $ASWF_BUILD_DIR

WORKDIR $ASWF_BUILD_DIR/ilmbase-2.2.0
RUN ./configure --prefix=$ASWF_ROOT_DIR/ilmbase
RUN make
RUN make install

# Generating the tarball as part of running the image.
# Needs "-v `pwd`:/mnt/dist" while running
WORKDIR $ASWF_ROOT_DIR
ENTRYPOINT tar -cvjSf /mnt/dist/ilmbase-2.2.0-vfx-2018.tar.bz2 ilmbase
