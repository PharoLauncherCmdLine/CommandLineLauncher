"
Command to list all the running images. 
"
Class {
	#name : #PhLImageProcessListCliCommand,
	#superclass : #PhLImageCliCommand,
	#category : #'PharoLauncher-CLI-Commands'
}

{ #category : #'command line' }
PhLImageProcessListCliCommand class >> asCliCommand [
	^ self newLauncherCommand: #processList
]

{ #category : #'command line' }
PhLImageProcessListCliCommand class >> launcherCmdDescription [
	^ 'Lists all running images on local computer.'
]

{ #category : #'command execution' }
PhLImageProcessListCliCommand >> execute [
	
	"TODO rewrite this to more meaningful output with columns like PID, datetime started, vm name, image name"
	
	self outStream 
		nextPutAll: (self executeOSShellCommand: self processListCmdString).
	^ self context exitSuccess 
]

{ #category : #'command execution' }
PhLImageProcessListCliCommand >> processListCmdString [

	^ String streamContents: [ :aStream |		
		aStream 
			nextPutAll: 'echo -n $(pgrep -a -f Pharo | grep ''.image'' | grep -v ''.bash''| grep -v ';
			nextPutAll: self currentVMPid asString;
			nextPutAll: ')'.
	]
]
