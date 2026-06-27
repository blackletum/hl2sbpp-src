#!/bin/sh
./waf configure -T release --enable-opus --64bits --togles --prefix=../game --disable-warns
./waf build install -p -vv -j$(nproc)
