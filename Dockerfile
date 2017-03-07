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
    cp -rp ${PYPY} /usr/lib/pypy; \
    ln -s /usr/lib/pypy/bin/pypy /usr/local/bin/pypy

RUN pypy get-pip.py; \
    ln -s /usr/lib/pypy/bin/pip /usr/local/bin/pip-pypy

RUN apt-get purge wget \
    bzip2 \
    ca-certificates; \
    apt-get autoremove -yq; \
    apt-get autoclean; \
    rm -rf /tmp/*
