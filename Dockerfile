FROM ubuntu:xenial

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update
RUN apt-get install -y software-properties-common
RUN add-apt-repository universe
RUN apt-get update
RUN apt-get install -y qemu libelf-dev build-essential python pkg-config libglib2.0 zlib1g-dev libaio-dev autoconf libtool libssl-dev
RUN ln -fs /usr/share/zoneinfo/America/New_York /etc/localtime



COPY ./opensgx /opensgx

RUN which gcc
RUN cd /opensgx/qemu && ./configure-arch --python=$(which python)
RUN cd /opensgx/qemu && make -j $(nproc)

RUN cd /opensgx && make -C libsgx && make -C user
