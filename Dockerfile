FROM debian:jessie

ENV PATH /usr/local/bin:$PATH
ENV PYPY pypy-5.6-linux_x86_64-portable

RUN apt-get update && apt-get install -y \
    wget \
    ca-certificates \
    bzip2

RUN cd /tmp && \
    wget https://bitbucket.org/squeaky/portable-pypy/downloads/${PYPY}.tar.bz2 && \
    wget https://bootstrap.pypa.io/get-pip.py


RUN cd /tmp && \
    tar -xjf ${PYPY}.tar.bz2 && \
    cp -rp ${PYPY} /usr/lib/pypy && \
    ln -s /usr/lib/pypy/bin/pypy /usr/local/bin/pypy

RUN cd /tmp && \
    pypy get-pip.py && \
    ln -s /usr/lib/pypy/bin/pip /usr/local/bin/pip-pypy

RUN apt-get autoclean && \
    rm -rf /tmp/*
