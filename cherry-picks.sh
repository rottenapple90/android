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
  rm *.patch
  if [ -d ".git/rebase-apply" ]
  then
    git am --abort
    popd
    exit 1
  fi
  popd
}

#
# insert cherry-picks below
#

# button-backlight: remove inactivity timeout
pushd frameworks/base
wget https://raw.github.com/milaq/android/cm-10.1/patches/08-05-13_button-backlight-remove-inactivity-timeout.patch
git am 08-05-13_button-backlight-remove-inactivity-timeout.patch
check_clean

# telephony: Support broken RIL implementations without CALL_RING events
pushd frameworks/opt/telephony
wget https://raw.github.com/milaq/android/cm-10.1/patches/14-05-13_telephony-Support-broken-RIL-implementations-without.patch
git am 14-05-13_telephony-Support-broken-RIL-implementations-without.patch
check_clean

# remove cmupdater (not needed for unofficial builds)
pushd vendor/cm
wget https://raw.github.com/milaq/android/cm-10.1/patches/23-05-13_remove-cmupdater-not-needed-for-unofficial-builds.patch
git am 23-05-13_remove-cmupdater-not-needed-for-unofficial-builds.patch
check_clean

# WIP: properly support multivalued controls (needed by tenderloin)
pushd external/tinyalsa
git fetch http://review.cyanogenmod.org/CyanogenMod/android_external_tinyalsa refs/changes/46/33646/1 && git cherry-pick FETCH_HEAD
check_clean

# kbuild: enable custom gnueabi toolchain
pushd build
wget https://raw.github.com/milaq/android/cm-10.1/patches/16-06-13_kbuild-enable-custom-gnueabi-toolchain.patch
git am 16-06-13_kbuild-enable-custom-gnueabi-toolchain.patch
check_clean
