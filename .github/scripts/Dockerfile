# ベースイメージの選択
FROM ubuntu:22.04

# 必要なライブラリのインストール
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    clang \
    build-essential \
    cmake \
    gdb \
    sudo \
    && rm -rf /var/lib/apt/lists/*

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
