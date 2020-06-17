#!/usr/bin/env bash

set -ex

# Helper script to build gdb in the container

# Copy source archive (from working dir mount) to /tmp in the container
mkdir -p /tmp/src
cd /tmp/src
cp /data/"$1" ./

# Unpack
tar -xvjf "$1"
rm "$1"

# Should be only 1 folder here 🤞
cd *

# Select python to use
PYTHON_VERSION=${PYTHON_VERSION:-python3.7}
ln -s -f ${PYTHON_VERSION} /usr/bin/python

# Build just gdb
tar -xvjf src/gdb.tar.bz2
cd gdb

# Installation directory
mkdir -p $(pwd)/tmp

# set rpath so gdb will try to load .so's from the directory it's in
./configure --host=x86_64-linux-gnu \
    --target=arm-none-eabi \
    --with-auto-load-dir=$debugdir:$datadir/auto-load \
    --with-auto-load-safe-path=$debugdir:$datadir/auto-load \
    --with-expat \
    --with-gdb-datadir=$(pwd)/tmp/arm-none-eabi/share/gdb \
    --with-jit-reader-dir=$(pwd)/tmp/lib/gdb \
    --without-libunwind-ia64 \
    --without-lzma \
    --with-python=/usr \
    --without-guile \
    --with-separate-debug-dir=$(pwd)/tmp/lib/debug \
    --with-system-gdbinit=$(pwd)/tmp/lib/gdbinit \
    --without-babeltrace \
    --prefix $(pwd)/tmp \
    --with-python

make -j8
make install

# Archive from the installation prefix location
cd /tmp/src/*/gdb
OUTPUT_ARCHIVE_NAME=arm-none-eabi-gdb-$PYTHON_VERSION.tar.bz2

# jam in the libpython we used
LIBPYTHON_PATH=$(ldconfig -p | grep -E 'python3.7.*\.so\.1\.0' | awk '{print $NF}')
cp $LIBPYTHON_PATH tmp/bin/

tar -cvjf $OUTPUT_ARCHIVE_NAME -C tmp .

# Copy out the generated archive
cp $OUTPUT_ARCHIVE_NAME /data/
chown -R $2 /data/$OUTPUT_ARCHIVE_NAME
