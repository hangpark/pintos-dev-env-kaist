From ds82/ubuntu-i386:8.04

MAINTAINER Hang Park <hangpark@kaist.ac.kr>

WORKDIR /
RUN apt-get install -y \
        wget gcc-3.4-base gcc-3.4 g++-3.4 gdb \
        libncursesw5 libncurses5-dev libexpat1-dev \
        make xorg-dev \
    && apt-get clean \
    && update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-3.4 10 \
    && update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-3.4 10 \
    && wget --no-check-certificate https://sourceforge.net/projects/bochs/files/bochs/2.2.6/bochs-2.2.6.tar.gz \
    && wget http://cps.kaist.ac.kr/courses/2017_spring_cs330/sources/pintos.tar.gz \
    && tar xzf pintos.tar.gz \
    && rm pintos.tar.gz \
    && env SRCDIR=/ PINTOSDIR=/pintos/ DSTDIR=/usr/local/ \
        sh /pintos/src/misc/bochs-2.2.6-build.sh \
    && rm bochs-2.2.6.tar.gz

WORKDIR /pintos

VOLUME [/pintos]
