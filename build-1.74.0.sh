#!/bin/bash
set -e
export RUSTC_VERSION=1.74.0 MRUSTC_TARGET_VER=1.74 OUTDIR_SUF=-1.74.0
# Enables use of ccache in mrustc if it's available (i.e. ccache is on PATH)
command -v ccache >/dev/null && export MRUSTC_CCACHE=1
make
make RUSTCSRC
make -f minicargo.mk LIBS $@
make test $@
make local_tests $@

RUSTC_INSTALL_BINDIR=bin make -f minicargo.mk output-1.74.0/rustc $@
./output-1.74.0/rustc --version

LIBGIT2_SYS_USE_PKG_CONFIG=1 make -f minicargo.mk -j ${PARLEVEL:-1} output-1.74.0/cargo $@
./output-1.74.0/cargo --version

./output-1.74.0/rustc samples/no_core.rs
#./output-1.74.0/rustc samples/1.rs
