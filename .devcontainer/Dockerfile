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
    git \
    && rm -rf /var/lib/apt/lists/*

RUN update-alternatives --install /usr/bin/clang clang /usr/bin/clang-10 10
RUN update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-10 10
WORKDIR /usr/lib/x86_64-linux-gnu
RUN ln -s libc++abi.so.1 libc++abi.so
ENV CC=clang
ENV CXX=clang++

# ###########################################################################################
# ! mysql-server
RUN apt-get update && apt-get install -y \
    libncurses5-dev \
    wget

WORKDIR /home/root/
RUN wget http://sourceforge.net/projects/boost/files/boost/1.59.0/boost_1_59_0.tar.gz --timeout=30
RUN tar -zxvf boost_1_59_0.tar.gz
RUN chmod 777 boost_1_59_0

RUN git clone https://github.com/mysql/mysql-server.git -b mysql-5.7.20 --depth 1

WORKDIR /home/root/bin/server
RUN cmake /home/root/mysql-server \
    -DWITHOUT_SERVER=ON \
    -DDOWNLOAD_BOOST=1 \
    -DWITH_BOOST=/home/root/boost_1_59_0 \
    -DWITH_UNIT_TESTS=OFF \
    -DCMAKE_CXX_FLAGS="${CMAKE_CXX_FLAGS} -stdlib=libc++"

RUN make -j 8 && \
    make install

# ###########################################################################################
# ! mysql-connector-cpp
RUN apt-get install libssl-dev

WORKDIR /home/root/
RUN git clone https://github.com/mysql/mysql-connector-cpp.git -b 1.1.12 --depth 1

WORKDIR /home/root/bin/connector
RUN cmake /home/root/mysql-connector-cpp \
    -DBOOST_ROOT=/home/root/boost_1_59_0 \
    -DUSE_SERVER_CXXFLAGS=1 \
    -DCMAKE_CXX_FLAGS="-stdlib=libc++ -Wno-deprecated-declarations" \
    -DMYSQL_DIR=/usr/local/mysql \
    -DMYSQL_INCLUDE_DIR=/usr/local/mysql/include \
    -DMYSQL_LIB_DIR=/usr/local/mysql/lib

RUN make -j 8 && \
    make install
# ###########################################################################################

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
