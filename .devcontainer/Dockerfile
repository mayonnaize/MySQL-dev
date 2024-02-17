# ベースイメージの選択
FROM ubuntu:20.04

# 必要なライブラリのインストール
RUN apt-get update

RUN ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

RUN apt-get install -y \
    python3 \
    python3-pip \
    build-essential \
    clang-11 \
    libc++-11-dev \
    cmake \
    gdb \
    git \
    && rm -rf /var/lib/apt/lists/*

RUN update-alternatives --install /usr/bin/clang clang /usr/bin/clang-11 11
RUN update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-11 11
WORKDIR /usr/lib/x86_64-linux-gnu
RUN ln -s libc++abi.so.1 libc++abi.so
ENV CC=clang
ENV CXX=clang++

# ###########################################################################################
# ! mysql-server
RUN apt-get update && apt-get install -y \
    libncurses5-dev \
    wget
# boostは必要みたい
# boost_1_72_0で実際ビルドできるがCMakeを少し加工する必要がある
WORKDIR /home/root/
RUN wget https://boostorg.jfrog.io/artifactory/main/release/1.72.0/source/boost_1_72_0.tar.gz --timeout=30
RUN tar -zxvf boost_1_72_0.tar.gz
RUN chmod 777 boost_1_72_0

RUN git clone https://github.com/mysql/mysql-server.git -b mysql-8.0.36 --depth 1

WORKDIR /home/root/bin/server
RUN cmake /home/root/mysql-server \
    -DWITHOUT_SERVER=ON \
    -DWITH_BOOST=/home/root/boost_1_72_0/ \
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

RUN cmake /home/root/bin/mysql-connector-cpp \
    -DUSE_SERVER_CXXFLAGS=1 \
    -DCMAKE_CXX_FLAGS="-stdlib=libc++ -Wno-deprecated-declarations" \
    -DBOOST_ROOT=/home/root/boost_1_72_0 \
    -DMYSQL_INCLUDE_DIR=/usr/include/mysql \
    -DMYSQL_LIB_DIR=/usr/lib/x86_64-linux-gnu

RUN make -j 8 && \
    make install

RUN apt-get install -y nautilus
RUN mkdir -p /home/root/bin/server && \
    mkdir -p /home/root/bin/connector

# ADD clean.sh /home/root/bin/server
# ADD server-build.sh /home/root/bin/server
# ADD clean.sh /home/root/bin/connector
# ADD conn-build.sh /home/root/bin/connector
