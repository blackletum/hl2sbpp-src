#!/bin/sh
CXX=clang++ CC=clang ./waf configure -T debug --enable-opus --64bits --togles --prefix=../game --disable-warns --sanitize=address,undefined
CXX=clang++ CC=clang ./waf build install -p -vv -j$(nproc)
