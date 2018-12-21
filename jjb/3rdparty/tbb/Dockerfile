FROM centos/devtoolset-6-toolchain-centos7

ENV ASWF_BUILD_DIR /tmp/vfx-build
ENV ASWF_ROOT_DIR /opt/aswf/vfx2018

USER root

RUN mkdir -p $ASWF_BUILD_DIR && \
    mkdir -p $ASWF_ROOT_DIR

# Common requirements
RUN yum install -y make bzip2

ADD 2017_U6.tar.gz $ASWF_BUILD_DIR

WORKDIR $ASWF_BUILD_DIR/tbb-2017_U6

# Prepare install
RUN mkdir -p $ASWF_ROOT_DIR/tbb/include &&\
    mkdir -p $ASWF_ROOT_DIR/tbb/lib &&\
    cp -R include/* $ASWF_ROOT_DIR/tbb/include/

# Normal build
RUN make && \
    cp build/*_release/*.so* $ASWF_ROOT_DIR/tbb/lib

# Community Preview Library with a clean first
RUN make clean && \
    make tbb_cpf=1 && \
    cp build/*_release/*.so* $ASWF_ROOT_DIR/tbb/lib

# Generating the tarball as part of running the image.
# Needs "-v `pwd`:/mnt/dist" while running
WORKDIR $ASWF_ROOT_DIR
ENTRYPOINT tar -cvjSf /mnt/dist/tbb-2017.6-vfx-2018.tar.bz2 tbb
