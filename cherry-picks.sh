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