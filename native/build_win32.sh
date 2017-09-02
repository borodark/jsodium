#! /bin/sh
set -x
export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-amd64

cd ../libsodium

make clean

export CFLAGS="-O3 -fomit-frame-pointer -m32 -march=pentium3 -mtune=westmere"
export PREFIX="$(pwd)/libsodium-win32"

if (i686-w64-mingw32-gcc --version > /dev/null 2>&1) then
   echo MinGW found
   else
       echo Please install mingw-w64-i686-gcc >&2
       exit
fi

./configure --prefix="$PREFIX" --exec-prefix="$PREFIX" \
               --host=i686-w64-mingw32 && \
    make -j4 clean && make -j4 # && make -j4 check

# For 32 bit  "make check" fails - TODO? 
# Wine[https://wiki.winehq.org/Ubuntu]
# Mono[http://www.mono-project.com/] installed 

# back to project root

cd ../native

# before patching
# copy $JAVA_HOME/include/win32 directory from Windows JDK installation to ${your Linux JDK home}/include 


patch -o contrib/jni_md.h $JAVA_HOME/include/win32/jni_md.h contrib/jni_md.patch

i686-w64-mingw32-gcc -v -D NODEBUG -shared -I../libsodium/src/libsodium/include -Icontrib -I$JAVA_HOME/include/ -I$JAVA_HOME/include/win32/ \
-o ../src/main/resources/libjsodium32.dll main.c \
../libsodium/src/libsodium/.libs/libsodium.a \
../libsodium/src/libsodium/.libs/libaesni.a \
../libsodium/src/libsodium/.libs/libavx2.a \
../libsodium/src/libsodium/.libs/libsse2.a \
../libsodium/src/libsodium/.libs/libsse41.a \
../libsodium/src/libsodium/.libs/libssse3.a

