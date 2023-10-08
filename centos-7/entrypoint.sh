#!/bin/bash

export OPENSSL_LIB_DIR=/usr/local/lib64 OPENSSL_INCLUDE_DIR=/usr/local/include

scl enable devtoolset-8 llvm-toolset-7 "$*"
