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

#
# insert cherry-picks below
#

# minimize softbutton spacing
pushd frameworks/base
wget https://raw.github.com/milaq/android/cm-10.2/patches/13-09-01_minimize-softbutton-spacing.patch
git am 13-09-01_minimize-softbutton-spacing.patch
check_clean

# mako hdpi build
pushd device/lge/mako
wget https://raw.github.com/milaq/android/cm-10.2/patches/13-09-03_mako-hdpi-build.patch
git am 13-09-03_mako-hdpi-build.patch
check_clean

# Revert "camera: Fix the flash sync issue in CAF mode" (messed up flash in GalleryGoogle)
pushd device/lge/mako
wget https://raw.github.com/milaq/android/cm-10.2/patches/13-10-10_Revert-camera-Fix-the-flash-sync-issue-in-CAF-mode.patch
git am 13-10-10_Revert-camera-Fix-the-flash-sync-issue-in-CAF-mode.patch
check_clean
