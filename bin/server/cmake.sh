#!/bin/bash

ls --ignore=*.sh | xargs rm -r
clear

cmake /home/root/mysql-server \
    -DWITHOUT_SERVER=ON \
    -DDOWNLOAD_BOOST=0 \
    -DWITH_BOOST=/home/root/boost_1_59_0 \
    -DWITH_UNIT_TESTS=OFF \
    -DCMAKE_CXX_FLAGS="${CMAKE_CXX_FLAGS} -stdlib=libc++"

make -j 8
