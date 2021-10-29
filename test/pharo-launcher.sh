#!/usr/bin/env bash
 
# Using default VM path and image path of Pharo Launcher, depending on OS
OSNAME=$(uname -s)
case $OSNAME in
  Linux*)
    LAUNCHERDIR=~/pharolauncher
    VMPATH=$LAUNCHERDIR/pharo-vm/pharo
    IMAGEPATH=$LAUNCHERDIR/shared/PharoLauncher.image
    ;;
  Darwin*)
    LAUNCHERDIR=/Applications/PharoLauncher.app/Contents
    VMPATH=$LAUNCHERDIR/MacOS/Pharo
    IMAGEPATH=$LAUNCHERDIR/Resources/PharoLauncher.image
    ;;
# TODO Windows
#  msys*)
#    ;;
  *)
    echo "Unsupported OS for Pharo Launcher: $OSNAME"
    exit 1
    ;;
esac

if [ ! -f "$VMPATH" ] || [ ! -f "$IMAGEPATH" ]; then
  
  #this dir name needs to be changed, when pushing to official Pharo launcher repo
  LAUNCHERDIR=~/CommandLineLauncher
  
  VMPATH=$LAUNCHERDIR/pharo-vm/pharo
  IMAGEPATH=$LAUNCHERDIR/PharoLauncher.image
fi

if [ ! -f "$VMPATH" ]; then
  echo "Pharo VM: $VMPATH do not exists. Cannot run launcher CLI."
  exit 1
fi

if  [ ! -f "$IMAGEPATH" ]; then
  echo "Pharo image: $IMAGEPATH do not exists. Cannot run launcher CLI."
  exit 1
fi
                                
$"$VMPATH" --headless "$IMAGEPATH" clap launcher "$@"

