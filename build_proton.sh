#!/bin/bash

Start=$(date +"%s")
DEVICE="REDMI NOTE 10 PRO (MIUI)"
KERNEL_NAME="PERFMOD-MIUI"
CODENAME="SWEET"

export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
export PATH="/home/hectorvax/clang/clang/bin/:$PATH"

export CLANG_TRIPLE=aarch64-linux-gnu-

export CROSS_COMPILE=${HOME}/aarch64-linux-android-4.9/bin/aarch64-linux-android- CC=clang CXX=clang++

export KBUILD_COMPILER_STRING="/home/hectorvax/clang/bin/clang --version | head -n 1 | perl -pe 's/\((?:http|git).*?\)//gs' | sed -e 's/  */ /g' -e 's/[[:space:]]*$//' -e 's/^.*clang/clang/')"

export CXXFLAGS="$CXXFLAGS -fPIC"
		
#export DTC_EXT=dtc
export DTC_EXT=${HOME}/kernel/sweet_toolchain/dtc/dtc-1.4.4/prebuilt/dtc
		
export ARCH=arm64 
export SUBARCH=arm64

export KBUILD_BUILD_USER="hectorvax"
export KBUILD_BUILD_HOST="perfmod"

#make CC="ccache clang" CXX="ccache clang++" O=out-clang sweet_mod_defconfig
make CC="ccache clang" CXX="ccache clang++" O=out-clang sweet_user_defconfig

 make CC="ccache clang" CXX="ccache clang++" O=out-clang $THREAD 2>&1 | tee kernel.log

End=$(date +"%s")
Diff=$(($End - $Start))
echo -e "$gre << Build completed in $(($Diff / 60)) minutes and $(($Diff % 60)) seconds >> \n $white"
