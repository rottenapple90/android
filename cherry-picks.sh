#!/bin/bash
#
# cherry-picks
# remember to cd into and out of the directories
#
# add like this:
#
# mkbootimg: support pagesize 8192
#cd system/core
#git fetch https://github.com/CyanogenMod/android_system_core ics && git cherry-pick 67ffceadeab46d4a43aadac0f574b14e844e01a5
#cd ../..
#
# button-backlight: remove inactivity timeout
cd frameworks/base
wget https://raw.github.com/milaq/android/cm-10.1/patches/12-02-13_button-backlight-remove-inactivity-timeout.patch
git am 12-02-13_button-backlight-remove-inactivity-timeout.patch
rm 12-02-13_button-backlight-remove-inactivity-timeout.patch
cd ../..
