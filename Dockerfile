FROM ubuntu:16.04

ARG QT_PREFIX
ADD ./${QT_PREFIX}.tar.gz /

RUN apt-get update && \
    apt-get install -y --no-install-recommends "^mingw.*" bc && \
    rm -rf /var/cache/apt/* && \
    mkdir /src

ENV PATH /usr/local/${QT_PREFIX}/bin:$PATH
WORKDIR /src
