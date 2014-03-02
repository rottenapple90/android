#!/bin/bash
# ---------------------------------------------------------
# cherry-picks
# use pushd to enter directories
#
# add cherry-picks like this:
#
# # mkbootimg: support pagesize 8192
# pushd system/core
# git fetch https://github.com/CyanogenMod/android_system_core ics && git cherry-pick 67ffceadeab46d4a43aadac0f574b14e844e01a5
# check_clean
# ---------------------------------------------------------

function check_clean {
  if [ -d "*.patch*" ]
  then
    rm *.patch*
  fi
  if [ -d ".git/rebase-apply" ]
  then
    git am --abort
    popd
    exit 1
  elif [ -d ".git/CHERRY_PICK_HEAD" ]
  then
    git cherry-pick --abort
    popd
    exit 1
  fi
  popd
}

# kbuild: enable custom gnueabi toolchain e.g. code sourcery
pushd build
wget https://raw.github.com/rottenapple90/android/cm-11.0/patches/13-11-20_kbuild-enable-custom-gnueabi-toolchain.patch
git am 13-11-20_kbuild-enable-custom-gnueabi-toolchain.patch
check_clean

# telephony: Support broken RIL implementations without CALL_RING events
pushd frameworks/opt/telephony
wget https://raw.github.com/rottenapple90/android/cm-11.0/patches/13-11-20_telephony-Support-broken-RIL-implementations.patch
git am 13-11-20_telephony-Support-broken-RIL-implementations.patch
check_clean
