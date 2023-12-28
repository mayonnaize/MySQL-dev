cmake_minimum_required(VERSION 3.10)
project(main)
# ==========================

# TODO: Debug設定はコマンドラインから引き継げるようにする
# デバッグモードを指定し、最適化を無効にする
set(CMAKE_BUILD_TYPE Debug)
# コンパイラフラグを設定（任意）
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall -Wextra")

# in-source ビルドガード
if(${CMAKE_SOURCE_DIR} STREQUAL ${CMAKE_BINARY_DIR})
    message(FATAL_ERROR "In-source builds not allowed. Please make a new directory (called a build directory) and run CMake from there. You may need to remove CMakeCache.txt. ")
endif()


# ==========================
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# ==========================
add_executable(main main.cpp)
