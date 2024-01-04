#!/bin/bash

ls --ignore=*.sh | xargs rm -r
clear

cmake /home/root/mysql-connector-cpp \
    -DCMAKE_BUILD_TYPE=Debug \
    -DBOOST_ROOT=/home/root/boost_1_59_0 \
    -DUSE_SERVER_CXXFLAGS=1 \
    -DMYSQL_CFLAGS="" \
    -DCMAKE_CXX_FLAGS="-stdlib=libc++ -Wno-deprecated-declarations" \
    -DMYSQL_DIR=/usr/local/mysql \
    -DMYSQL_INCLUDE_DIR=/usr/local/mysql/include \
    -DMYSQL_LIB_DIR=/usr/local/mysql/lib

make -j 8
