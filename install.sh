#!/usr/bin/env bash

swift build -c release -Xswiftc -static-stdlib -Xswiftc "-target" -Xswiftc "x86_64-apple-macosx10.12"
mv .build/release/xctemplates /usr/local/bin
rm -rf .build/

