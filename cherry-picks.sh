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
  elif [ -d ".git/CHERRY_PICK_HEAD" ]
  then
    git cherry-pick --abort
    popd
    exit 1
  fi
  popd
}

#
# insert cherry-picks below
#

# remove cmupdater (not needed for unofficial builds)
pushd vendor/cm
wget https://raw.github.com/milaq/android/cm-10.1/patches/23-05-13_remove-cmupdater-not-needed-for-unofficial-builds.patch
git am 23-05-13_remove-cmupdater-not-needed-for-unofficial-builds.patch
check_clean

# camera: add SXGA resolution
pushd packages/apps/Camera
wget https://raw.github.com/milaq/android/cm-10.1/patches/20-06-13_add-SXGA-resolution.patch
git am 20-06-13_add-SXGA-resolution.patch
check_clean
