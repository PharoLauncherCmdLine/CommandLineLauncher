#!/usr/bin/env bash

# import functions that are shared across unit tests
source PharoLauncherCommonFunctions.sh

#ensure that Shell unit test library is installed
ensureShunitIsPresent

#setup sample image name and template name
SAMPLEIMAGE="PhLTestImage"
SAMPLETEMPLATE="Pharo 8.0 - 64bit (old stable)"

# setup commands for sample image manipulation
createSampleImageCommand () {
    runLauncherScript image create $SAMPLEIMAGE "`$SAMPLETEMPLATE`"
}

launchSampleImageCommand () {
    runLauncherScript image launch $SAMPLEIMAGE
}

killSampleImageCommand () {
    runLauncherScript image kill $SAMPLEIMAGE
}

deleteSampleImageCommand () { 
    runLauncherScript image delete $SAMPLEIMAGE
}

processListCommand () {
    runLauncherScript image processList
}

killAllCommand () {
    runLauncherScript image kill --all
}



oneTimeSetUp() {
	prepareLauncherScriptAndImage
	createSampleImageCommand
}

testLauncherProcessListCommandWhenNoPharoImageRunningShouldReturnEmptyList(){
	result=$(processListCommand)
	#since VM prints some warnings, we need to check presence of image name from process list
	assertNotContains "$result" "$SAMPLEIMAGE"
}

testLauncherProcessListCommandWhenImageIsLaunchedShouldReturnOneImage(){
    launchSampleImageCommand> /dev/null
    result=$(processListCommand)
    kill $(pgrep -l -f $SAMPLEIMAGE.image |  cut -d ' ' -f1) >/dev/null
    assertContains "$result" "$SAMPLEIMAGE"
	
}

testLauncherKillAllCommandWithOneImageLaunchedShouldKillAll(){
	launchSampleImageCommand> /dev/null
	result=$(processListCommand)
	echo "actual: $result"
    echo "expected (should contain): $SAMPLEIMAGE"
	assertContains "$result" "$SAMPLEIMAGE"
	killAllCommand
	result=$(processListCommand)
	assertNotContains "$result" "$SAMPLEIMAGE"
	echo "Actual: $result"
    echo "Not expected (should not contain): $SAMPLEIMAGE"
	assertNotContains "$result" "$SAMPLEIMAGE"
}

testLauncherKillCommandWithOneImageLaunchedShouldKillIt(){
	launchSampleImageCommand> /dev/null
	result=$(processListCommand)
	assertContains "$result" "$SAMPLEIMAGE"
	killSampleImageCommand
	result=$(processListCommand)
	assertNotContains "$result" "$SAMPLEIMAGE"
}

oneTimeTearDown() {
	echo "Calling teardown..."
	deleteSampleImageCommand
	cleanupLauncherScriptAndImage
}

# Load shUnit2.
. ./shunit2/shunit2