#!/bin/bash

clear

cmake /home/root/mysql-connector-cpp \
    -DBOOST_ROOT=/home/root/boost_1_59_0 \
    -DUSE_SERVER_CXXFLAGS=1 \
    -DCMAKE_CXX_FLAGS="-stdlib=libc++ -Wno-deprecated-declarations" \
    -DBOOST_ROOT=/home/root/boost_1_72_0 \
    -DMYSQL_INCLUDE_DIR=/usr/local/mysql/include/ \
    -DMYSQL_LIB_DIR=/usr/local/mysql/lib/

make -j 8 && \
    make install
