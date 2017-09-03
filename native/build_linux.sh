#!/bin/sh
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
#export JAVA_HOME=/etc/alternatives/java_sdk

export CFLAGS="-fPIC"

cd ../libsodium
./configure
make -j4 clean && make -j4 && make -j4 check

cd ../native

gcc -v -fPIC -shared -I../libsodium/src/libsodium/include -I$JAVA_HOME/include/ -I$JAVA_HOME/include/linux/ -o ../src/main/resources/libjsodium.so main.c \
    ../libsodium/src/libsodium/.libs/libsodium.a \
    ../libsodium/src/libsodium/.libs/libaesni.a \
    ../libsodium/src/libsodium/.libs/libavx2.a \
    ../libsodium/src/libsodium/.libs/libsse2.a \
    ../libsodium/src/libsodium/.libs/libsse41.a \
    ../libsodium/src/libsodium/.libs/libssse3.a

 #   linux/libsodium.a \
 #   linux/libaesni.a \
 #   linux/libavx2.a \
 #   linux/libsse2.a \
 #   linux/libsse41.a \
 #  linux/libssse3.a

