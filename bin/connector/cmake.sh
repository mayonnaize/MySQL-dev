#!/bin/bash

ls --ignore=*.sh | xargs rm -r
clear

cmake ../../mysql-connector-cpp \
    -DBOOST_ROOT=~/boost_1_59_0 \
    -DUSE_SERVER_CXXFLAGS=1 \
    -DMYSQL_CFLAGS="" \
    -DMYSQL_CXXFLAGS="-stdlib=libc++ -Wno-deprecated-declarations -v" \
    -DCMAKE_CXX_FLAGS="-stdlib=libc++ -Wno-deprecated-declarations -v" \
    -DMYSQL_DIR=/usr/local/mysql \
    -DMYSQL_INCLUDE_DIR=/usr/local/mysql/include \
    -DMYSQL_LIB_DIR=/usr/local/mysql/lib

make VERBOSE=1

# make -j 8
    # -DMYSQL_CXXFLAGS="-stdlib=libc++ -std=gnu++1y -Wno-deprecated-declarations -v" \
