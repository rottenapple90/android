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

# RIL: fix signal for legacy gsm devices
pushd frameworks/opt/telephony
wget https://raw.github.com/milaq/android/cm-10.2/patches/13-12-19_RIL-fix-signal-for-legacy-gsm-devices.patch
git am 13-12-19_RIL-fix-signal-for-legacy-gsm-devices.patch
check_clean

# work around for invalid AppType on legacy gsm devices
pushd frameworks/opt/telephony
wget https://raw.github.com/milaq/android/cm-10.2/patches/13-12-19_Work-around-for-invalid-AppType-on-legacy-gsm-device.patch
git am 13-12-19_Work-around-for-invalid-AppType-on-legacy-gsm-device.patch
check_clean

# wpa_supplicant: Don't enable NL80211 unconditionally
pushd external/wpa_supplicant_8
wget https://raw.github.com/milaq/android/cm-10.2/patches/13-12-21_wpa_supplicant-Don-t-enable-NL80211-unconditionally.patch
git am 13-12-21_wpa_supplicant-Don-t-enable-NL80211-unconditionally.patch
check_clean

# wext: use combo scan to avoid SIOCSIWSCAN error
pushd external/wpa_supplicant_8
wget https://raw.github.com/milaq/android/cm-10.2/patches/13-12-21_wext-use-combo-scan-to-avoid-SIOCSIWSCAN-error.patch
git am 13-12-21_wext-use-combo-scan-to-avoid-SIOCSIWSCAN-error.patch
check_clean
