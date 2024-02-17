#!/bin/bash

clear

cmake /home/root/mysql-server \
    -DWITHOUT_SERVER=ON \
    -DWITH_UNIT_TESTS=OFF \
    -DWITH_BOOST=/home/root/boost_1_72_0/ \
    -DCMAKE_CXX_FLAGS="${CMAKE_CXX_FLAGS} -stdlib=libc++"

make -j 8 && \
    make install
