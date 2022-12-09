#!/bin/bash

Start=$(date +"%s")
DEVICE="REDMI NOTE 10 PRO (MIUI)"
KERNEL_NAME="PERFMOD-MIUI"
CODENAME="SWEET"
export ARCH=arm64
export SUBARCH=arm64
export DTC_EXT=${HOME}/kernel/sweet_toolchain/dtc/dtc-1.4.4/prebuilt/dtc
export KBUILD_BUILD_USER="hectorvax"
export KBUILD_BUILD_HOST="perfmod"
make O=${HOME}/sweet-r-kernel/out ARCH=arm64 sweet_user_defconfig

make -j$(nproc --all)  O=${HOME}/sweet-r-kernel/out \
PATH="${HOME}/kernel/sweet_toolchain/clang/LLVM-10.0.9/bin:${HOME}/kernel/sweet_toolchain/gcc/aarch64-linux-android-4.9//bin:${PATH}" \
                                ARCH=arm64 \
                                REAL_CC=clang \
                                CROSS_COMPILE=aarch64-linux-android- \
                                CLANG_TRIPLE=aarch64-linux-gnu- | tee ${HOME}/sweet-r-kernel/out/kernel.log
End=$(date +"%s")
Diff=$(($End - $Start))
echo -e "$gre << Build completed in $(($Diff / 60)) minutes and $(($Diff % 60)) seconds >> \n $white"
