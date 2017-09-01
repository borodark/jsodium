#!/bin/sh
#export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
# export JAVA_HOME=/etc/alternatives/java_sdk
#gcc
export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-amd64
x86_64-w64-mingw32-gcc -v -D NODEBUG -shared -I../libsodium/src/libsodium/include -I$JAVA_HOME/include/ -I$JAVA_HOME/include/win32/ \
-o ../src/main/resources/libjsodium.dll main.c \
../libsodium/src/libsodium/.libs/libsodium.a \
../libsodium/src/libsodium/.libs/libaesni.a \
../libsodium/src/libsodium/.libs/libavx2.a \
../libsodium/src/libsodium/.libs/libsse2.a \
../libsodium/src/libsodium/.libs/libsse41.a \
../libsodium/src/libsodium/.libs/libssse3.a

