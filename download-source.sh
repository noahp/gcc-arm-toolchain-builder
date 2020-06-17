#!/usr/bin/env bash

set -e

# Fetch source archive. Takes 1 arg, eg ./download-source.sh 9-2020q2

# Versions used in the source download url

# Options as of 2020-06-16:
case $1 in
    9-2020q2)
        GCC_ARM_VERSION_EXPANDED=9-2020-q2-update
        ;;
    9-2019q4)
        GCC_ARM_VERSION_EXPANDED=9-2019-q4-major
        ;;
    8-2019q3)
        GCC_ARM_VERSION_EXPANDED=8-2019-q3-update
        ;;
    8-2018q4)
        GCC_ARM_VERSION_EXPANDED=8-2019-q4-major
        ;;
    7-2018q2)
        GCC_ARM_VERSION_EXPANDED=7-2018-q2-update
        ;;
    7-2017q4)
        GCC_ARM_VERSION_EXPANDED=7-2017-q4-major
        ;;
    6-2017q2)
        GCC_ARM_VERSION_EXPANDED=6-2017-q2-update
        ;;
    6-2017q1)
        GCC_ARM_VERSION_EXPANDED=6-2017-q1-update
        ;;
    6-2016q4)
        GCC_ARM_VERSION_EXPANDED=6-2016-q4-major
        ;;
    5-2016q3)
        GCC_ARM_VERSION_EXPANDED=5-2016-q3-update
        ;;
    5-2016q2)
        GCC_ARM_VERSION_EXPANDED=5-2016-q2-update
        ;;
    5-2016q1)
        GCC_ARM_VERSION_EXPANDED=5-2016-q1-update
        ;;
        *)
        echo "Don't know $1" >&2 && false
        ;;
esac

wget https://developer.arm.com/-/media/Files/downloads/gnu-rm/${1}/gcc-arm-none-eabi-${GCC_ARM_VERSION_EXPANDED}-src.tar.bz2
