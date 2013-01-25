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

# Add option for switching between UMS and MTP/PTP mode. (1/2)
cd frameworks/base
git fetch http://review.cyanogenmod.org/CyanogenMod/android_frameworks_base refs/changes/95/30895/1 && git cherry-pick FETCH_HEAD
cd ../..

# Add option for switching between UMS and MTP/PTP mode. (2/2)
cd packages/apps/Settings
git fetch http://review.cyanogenmod.org/CyanogenMod/android_packages_apps_Settings refs/changes/96/30896/1 && git cherry-pick FETCH_HEAD
cd ../../..
