# gcc-arm-toolchain-builder

**_NOTE_**: WIP! most functionality is not there

Collection of Dockerfile's and scripts to build all or parts of the
arm-none-eabi toolchain.

Purpose was to build the bundled gdb against alternate libpython versions.

## Usage

### gdb

At the moment only 1 operation is supported: building gdb.

Supported python versions are:

- 2.7
- 3.7
- 3.8
- 3.9

```bash
# you'll need to download a toolchain first
./download-source.sh 9-2020q2

# build gdb for python3.7
PYTHON_VERSION=python3.7 ./build-gdb.sh gcc-arm-none-eabi-9-2020-q2-update-src.tar.bz2

# this will output an archive in the cwd 'arm-none-eabi-gdb-python2.7.tar.bz2'
```

To use the gdb binary, your system will need a matching libpython. Optionally
you can `patchelf --set-rpath '$ORIGIN' arm-none-eabi-gdb` and copy a libpython
out of the docker container into the folder with the executable. You'll need to
supply a suitable `PYTHONHOME` when running gdb though.

You might have an easier time setting up a conda env with a matching python
version. In that case, you could do something like this to call the executable:

```bash
LD_PRELOAD=$CONDA_PREFIX/lib/libpython3.7m.so.1.0 PYTHONHOME=$CONDA_PREFIX arm-none-eabi-gdb
```
