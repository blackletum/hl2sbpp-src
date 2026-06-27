#!/bin/sh
CXX=clang++ CC=clang ./waf configure -T release --enable-opus --64bits --togles --prefix=../game --disable-warns
CXX=clang++ CC=clang ./waf build install -p -vv -j$(nproc)
