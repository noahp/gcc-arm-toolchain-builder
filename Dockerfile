FROM ubuntu:focal

ARG DEBIAN_FRONTEND=noninteractive

# Set of build dependencies for Linux + Windows cross-build
RUN \
    dpkg --add-architecture i386 && \
    apt-get update && apt-get install -y \
        autoconf \
        autogen \
        binutils-mingw-w64-i686 \
        bison \
        build-essential \
        dejagnu \
        flex \
        flip \
        g++-mingw-w64-i686 \
        gawk \
        gcc-mingw-w64-i686 \
        git \
        gperf \
        gzip \
        libisl-dev \
        libncurses5-dev \
        nsis \
        openssh-client \
        p7zip-full \
        perl \
        python-dev \
        scons \
        tcl \
        texinfo \
        texlive \
        texlive-extra-utils \
        tofrodos \
        wget \
        zip

# Add some python versions to pick from
RUN \
    apt-get install -y software-properties-common && \
    add-apt-repository ppa:deadsnakes/ppa && apt-get update && \
    bash -c "\
        apt-get install -y \
            python2.7{,-dev} \
            python3.6{,-dev} \
            python3.7{,-dev,-distutils} \
            python3.8{,-dev} \
            python3.9{,-dev,-distutils}\
            python3-distutils"
