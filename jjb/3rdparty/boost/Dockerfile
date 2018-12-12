FROM centos/devtoolset-6-toolchain-centos7

ENV ASWF_DIR /opt/aswf/vfx2018
ENV TMP_DIR /tmp/vfx-build
ENV DOWNLOADS_DIR /tmp/vfx-downloads

USER root

RUN mkdir -p $TMP_DIR && \
    mkdir -p $ASWF_DIR && \
    mkdir -p $DOWNLOADS_DIR

RUN yum install -y wget bzip2 which python-devel bzip2-devel

RUN wget https://sourceforge.net/projects/boost/files/boost/1.61.0/boost_1_61_0.tar.bz2/download -O $DOWNLOADS_DIR/boost_1_61_0.tar.bz2

RUN cd $TMP_DIR &&\
    tar -jxf $DOWNLOADS_DIR/boost_1_61_0.tar.bz2 &&\
    cd $TMP_DIR/boost_1_61_0 &&\
    ./bootstrap.sh \
        --prefix=$ASWF_DIR &&\
    ./bjam \
        variant=release \
        link=shared \
        threading=multi \
        cxxflags="-std=c++14" \
        linkflags="-std=c++14" \
        install

# Generating the tarball as part of running the image.
# Needs "-v `pwd`:/mnt/dist" while running
ENTRYPOINT cd $ASWF_DIR &&\
    tar -cvjSf /mnt/dist/boost-1.61.0-vfx-2018.tar.bz2 *
