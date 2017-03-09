FROM debian:jessie
LABEL maintainer "Ilya Yurtaev <ilya.yurtaev@gmail.com>"

ENV PATH /usr/local/bin:$PATH
ENV PYPY pypy-5.6-linux_x86_64-portable

RUN apt-get update && apt-get install -yq \
    wget \
    ca-certificates \
    bzip2

WORKDIR /tmp

RUN wget https://bitbucket.org/squeaky/portable-pypy/downloads/${PYPY}.tar.bz2; \
    wget https://bootstrap.pypa.io/get-pip.py

RUN tar -xjf ${PYPY}.tar.bz2; \
    cp -rp ${PYPY} /usr/lib/pypy

RUN /usr/lib/pypy/bin/pypy get-pip.py; \
    ln -s /usr/lib/pypy/lib/* /usr/lib/; \
    ln -s /usr/lib/pypy/bin/* /usr/local/bin/; \
    ln -s /usr/lib/pypy/bin/libpypy-c.so /usr/lib/libpypy-c.so  # wtf

RUN apt-get purge wget \
    bzip2 \
    ca-certificates; \
    apt-get autoremove -yq; \
    apt-get autoclean; \
    rm -rf /tmp/*
