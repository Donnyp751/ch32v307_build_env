FROM ubuntu:20.04 as base



RUN apt-get update \
    && apt-get upgrade -y


RUN export DEBIAN_FRONTEND=noninteractive \
&& apt-get update \
&& apt-get -y install \ 
    autoconf \
    automake autotools-dev curl python3 \
    libmpc-dev libmpfr-dev libgmp-dev git gawk \
    build-essential bison flex texinfo gperf \
    libtool patchutils bc zlib1g-dev libexpat-dev




ENV PREFIX /dmpi
ENV SRCDIR $PREFIX/src
ENV CROSSDIR $PREFIX/cross
ENV HOST arm-linux
ENV SOURCE srctmp

RUN mkdir $PREFIX
RUN mkdir ${SRCDIR}
RUN mkdir ${CROSSDIR}

WORKDIR $SRCDIR

RUN  git clone https://github.com/riscv/riscv-gnu-toolchain.git \
    && cd  riscv-gnu-toolchain \
    && ./configure --prefix=/opt/riscv --enable-multilib \
    && make -j 4
