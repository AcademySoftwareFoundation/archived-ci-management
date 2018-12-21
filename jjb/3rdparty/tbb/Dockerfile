FROM centos/devtoolset-6-toolchain-centos7

ENV ASWF_DIR /opt/aswf/vfx2018
ENV TMP_DIR /tmp/vfx-build
ENV DOWNLOADS_DIR /tmp/vfx-downloads

USER root

RUN mkdir -p $TMP_DIR && \
    mkdir -p $ASWF_DIR && \
    mkdir -p $DOWNLOADS_DIR

RUN yum install -y wget make

RUN wget https://github.com/01org/tbb/archive/2017_U6.tar.gz -O $DOWNLOADS_DIR/tbb_2017_U6.tar.gz

RUN cd $TMP_DIR &&\
    tar xf $DOWNLOADS_DIR/tbb_2017_U6.tar.gz &&\
    cd $TMP_DIR/tbb-2017_U6 &&\
    mkdir -p $ASWF_DIR/include && cp -R include/* $ASWF_DIR/include/ &&\
    make && \
    mkdir -p $ASWF_DIR/lib && cp build/*_release/*.so* $ASWF_DIR/lib &&\
    make clean && \
    make tbb_cpf=1 && \
    mkdir -p $ASWF_DIR/lib && cp build/*_release/*.so* $ASWF_DIR/lib

# Generating the tarball as part of running the image.
# Needs "-v `pwd`:/mnt/dist" while running
ENTRYPOINT cd $ASWF_DIR &&\
    tar -cvjSf /mnt/dist/tbb-2017.6-vfx-2018.tar.bz2 *
