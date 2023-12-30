#!/bin/bash

ls --ignore=*.sh | xargs rm -r
clean

cmake -DWITHOUT_SERVER=ON \
    -DDOWNLOAD_BOOST=1 \
    -DWITH_BOOST=~/ \
    -DWITH_UNIT_TESTS=OFF ../mysql-server \
    -DCMAKE_CXX_FLAGS="${CMAKE_CXX_FLAGS} -stdlib=libc++"

make -j 8
