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
  if [ -e *.patch ]
  then
    rm *.patch
  fi
  if [ -e ".git/rebase-apply" ]
  then
    git am --abort
    popd
    exit 1
  elif [ -e ".git/CHERRY_PICK_HEAD" ]
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

# flo: fix up usb otg for kk
PATCH=14-01-06_flo-fix-up-usb-otg-for-kk
FOLDER=device/asus/flo
###
pushd ${FOLDER}
wget https://raw.github.com/milaq/android/cm-11.0/patches/${PATCH}.patch
git am ${PATCH}.patch
check_clean

# Revert "disable led while charging"
PATCH=14-01-09_Revert-disable-led-while-charging
FOLDER=hardware/qcom/display-caf
###
pushd ${FOLDER}
wget https://raw.github.com/milaq/android/cm-11.0/patches/${PATCH}.patch
git am ${PATCH}.patch
check_clean