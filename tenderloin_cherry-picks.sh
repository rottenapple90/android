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

#
# insert cherry-picks below
#

# libhardware_legacy/wifi: add workaround for ath6kl driver
PATCH=14-01-06-libhardware_legacy-wifi-add-workaround-for-ath6kl
FOLDER=hardware/libhardware_legacy
###
pushd ${FOLDER}
wget https://raw.github.com/milaq/android/cm-11.0/patches/${PATCH}.patch
git am ${PATCH}.patch
check_clean

# tinyalsa: properly support multivalued controls
PATCH=13-11-19_tinyalsa-properly-support-multivalued-controls
FOLDER=external/tinyalsa
###
pushd ${FOLDER}
wget https://raw.github.com/milaq/android/cm-11.0/patches/${PATCH}.patch
git am ${PATCH}.patch
check_clean

# btservice/AdaperState: handle ENABLED_READY in OffState
PATCH=13-11-25_btservice-AdaperState-handle-ENABLED_READY
FOLDER=packages/apps/Bluetooth
###
pushd ${FOLDER}
wget https://raw.github.com/milaq/android/cm-11.0/patches/${PATCH}.patch
git am ${PATCH}.patch
check_clean
