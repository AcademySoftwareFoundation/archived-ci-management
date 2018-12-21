FROM centos/devtoolset-6-toolchain-centos7

ENV ASWF_BUILD_DIR /tmp/vfx-build
ENV ASWF_ROOT_DIR /opt/aswf/vfx2018

USER root

RUN mkdir -p $ASWF_BUILD_DIR && \
    mkdir -p $ASWF_ROOT_DIR

# Common requirements
RUN yum install -y which bzip2

# Boost build requirements
RUN yum install -y python-devel bzip2-devel

ADD boost_1_61_0.tar.bz2 $ASWF_BUILD_DIR

WORKDIR $ASWF_BUILD_DIR/boost_1_61_0

RUN ./bootstrap.sh \
        --prefix=$ASWF_ROOT_DIR/boost

RUN ./bjam \
        variant=release \
        link=shared \
        threading=multi \
        cxxflags="-std=c++14" \
        linkflags="-std=c++14" \
        install


# Generating the tarball as part of running the image.
# Needs "-v `pwd`:/mnt/dist" while running
WORKDIR $ASWF_ROOT_DIR
ENTRYPOINT tar -cvjSf /mnt/dist/boost-1.61.0-vfx-2018.tar.bz2 boost
