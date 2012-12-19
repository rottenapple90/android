#!/bin/bash
#
# cherry-picks specifically for the htc leo
#
# Revert "SurfaceFlinger: Dont skip composition if it is incomplete." (http://review.cyanogenmod.org/#/c/23624/)
cd frameworks/base
git fetch http://review.cyanogenmod.org/CyanogenMod/android_frameworks_base refs/changes/24/23624/1 && git revert --no-edit FETCH_HEAD
cd ../..
