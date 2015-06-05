#!/bin/sh

# This script tests the CMake build by:
# - building libuv (without tests)
# - building run-tests in a separate build tree so
#   the config-module will also be tested
# - running run-tests

# Set the environment variable BUILD_SHARED_LIBS=1 to test the shared build

set -ex

cmake -H. -Bout/build/libuv_release -DCMAKE_INSTALL_PREFIX=${PWD}/out -DCMAKE_BUILD_TYPE=Release -DBUILD_SHARED_LIBS=$BUILD_SHARED_LIBS
cmake --build out/build/libuv_release --target install --config Release

cmake -Htest -Bout/build/tests -DCMAKE_INSTALL_PREFIX=${PWD}/out -DCMAKE_PREFIX_PATH=${PWD}/out -DCMAKE_BUILD_TYPE=Release
cmake --build out/build/tests --target install --config Release

export LD_LIBRARY_PATH=./out/lib:$LD_LIBRARY_PATH
./out/bin/run-tests

