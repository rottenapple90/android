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
  if [ -d "*.patch" ]
  then
    rm *.patch
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

# camera: add SXGA resolution
pushd packages/apps/Gallery2
wget https://raw.github.com/milaq/android/cm-10.2/patches/13-09-18_add-SXGA-resolution.patch
git am 13-09-18_add-SXGA-resolution.patch
check_clean

# evervolv mods, add a delay for file open, fix try 5 times
pushd external/wpa_supplicant_8
wget https://raw.github.com/milaq/android/cm-10.2/patches/13-09-14_evervolv-mods-add-a-delay-for-file-open.patch
git am 13-09-14_evervolv-mods-add-a-delay-for-file-open.patch
check_clean

# properly support multivalued controls
pushd external/tinyalsa
wget https://raw.github.com/milaq/android/cm-10.2/patches/13-09-14_properly-support-multivalued-controls.patch
git am 13-09-14_properly-support-multivalued-controls.patch
check_clean

# recovery: we need our own fsck for tenderloin
pushd bootable/recovery
wget https://raw.github.com/milaq/android/cm-10.2/patches/13-09-27_we-need-our-own-fsck-for-tenderloin.patch
git am 13-09-27_we-need-our-own-fsck-for-tenderloin.patch
check_clean
