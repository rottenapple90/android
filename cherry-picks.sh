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


# add lenovo a107 to targets
cd vendor/cyanogen
wget https://raw.github.com/milaq/android/gingerbread/patches/23-03-13_add-lenovo-a107-IdeaPad-A1.patch
git am 23-03-13_add-lenovo-a107-IdeaPad-A1.patch
rm 23-03-13_add-lenovo-a107-IdeaPad-A1.patch
cd ../..

# Add option to configure ramdisks built with mkimage for U-Boot.
cd build
git fetch http://review.cyanogenmod.org/CyanogenMod/android_build refs/changes/20/11920/1 && git cherry-pick FETCH_HEAD
cd ..

# SensorService: Don't always assume magnetometer is present.
cd frameworks/base
git fetch http://review.cyanogenmod.org/CyanogenMod/android_frameworks_base refs/changes/56/16156/1 && git cherry-pick FETCH_HEAD
cd ../..
