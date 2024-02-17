#!/bin/bash

cmake /home/root/mysql-server \
    -DWITHOUT_SERVER=ON \
    -DDOWNLOAD_BOOST=1 \
    -DWITH_BOOST=/home/root/boost_1_72_0 \
    -DWITH_UNIT_TESTS=OFF \
    -DCMAKE_CXX_FLAGS="${CMAKE_CXX_FLAGS} -stdlib=libc++"

make -j 8 && \
    make install
