# syntax=docker/dockerfile:1
FROM debian:stable AS builder

ARG NASM_VERSION=3.01

RUN echo "deb [trusted=yes] http://archive.debian.org/debian buster main\n\
deb [trusted=yes] http://archive.debian.org/debian-security buster/updates main" > /etc/apt/sources.list

WORKDIR /usr/src

RUN set -eux; \
    apt-get update && \
    apt-get install -y --no-install-recommends \
        curl wget git ssh ca-certificates gcc make libc6-dev build-essential xz-utils && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# nasm - build from source
RUN set -eux; \
    wget -q -O nasm.tar.gz https://nasm.us/pub/nasm/releasebuilds/${NASM_VERSION}/nasm-${NASM_VERSION}.tar.gz && \
    tar xzf nasm.tar.gz && \
    cd nasm-${NASM_VERSION} && \
    ./configure --prefix=/usr/local && \
    make -j"$(nproc)" && \ 
    make install && \
    rm -rf /usr/src/nasm-${NASM_VERSION}/ /usr/src/nasm.tar.gz

#

FROM debian:stable-slim

ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=1000

# bsdmainutils - includes hexdump
RUN set -eux; \
    apt-get update && \
    apt-get install -y --no-install-recommends \
        make wget git ssh sudo \
        bsdmainutils && \
    rm -rf /var/lib/apt/lists/*

RUN set -eux; \
    groupadd --gid $USER_GID $USERNAME && \
    useradd --uid $USER_UID --gid $USER_GID -c "VsCode user" -s /bin/bash  -m $USERNAME && \
    mkdir -p /etc/sudoers.d && \
    echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME && \
    chmod 0440 /etc/sudoers.d/$USERNAME

WORKDIR /usr/local/bin
COPY --from=builder /usr/local/bin/nasm .
COPY --from=builder /usr/local/bin/ndisasm .

RUN mkdir -p /usr/src/app && \
    chown -R 1000:1000 /usr/src/app

USER ${USERNAME}
RUN git config --global --add safe.directory /usr/src/app
WORKDIR /usr/src/app

ENTRYPOINT [ "/bin/bash" ]
