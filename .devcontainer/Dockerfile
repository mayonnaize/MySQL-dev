# ベースイメージの選択
FROM ubuntu:18.04

# 必要なライブラリのインストール
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    build-essential \
    clang-10 \
    libc++-10-dev \
    cmake \
    gdb \
    sudo \
    && rm -rf /var/lib/apt/lists/*

RUN update-alternatives --install /usr/bin/clang clang /usr/bin/clang-10 10
RUN update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-10 10
WORKDIR /usr/lib/x86_64-linux-gnu
RUN ln -s libc++abi.so.1 libc++abi.so
ENV CC=clang
ENV CXX=clang++

# ユーザ追加
ARG USERNAME=user
ARG GROUPNAME=user
ARG UID=1000
ARG GID=1000
ARG PASSWORD=user
RUN groupadd -g $GID $GROUPNAME && \
    useradd -m -s /bin/bash -u $UID -g $GID -G sudo $USERNAME && \
    echo $USERNAME:$PASSWORD | chpasswd && \
    echo "$USERNAME   ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
USER $USERNAME
WORKDIR /home/$USERNAME/
