Class {
	#name : #PhLImageCreateLaunchScriptCliCommand,
	#superclass : #PhLImageCliCommand,
	#category : #'PharoLauncher-CLI'
}

{ #category : #'command line' }
PhLImageCreateLaunchScriptCliCommand class >> asCliCommand [
	^ self newLauncherCommand: #launchScript
]

{ #category : #'command line' }
PhLImageCreateLaunchScriptCliCommand class >> launcherCmdDescription [
	^ 'Creates a script to launch an image.'
]

{ #category : #'command line - arguments' }
PhLImageCreateLaunchScriptCliCommand class >> launcherCmdPositionals [

	^ {((ClapPositional id: #existingImageName)
				description: 'Local image name to create the launch script.';
					meaning: [ :pos | pos  asString ];
					implicitMeaning: [ :arg :app |NotFound 
        signal: 'need an image to create the script' . ];
					yourself).
	}
]

{ #category : #creating }
PhLImageCreateLaunchScriptCliCommand >> createLaunchScript: anImage [
	| imagePath |
	imagePath := anImage location asPath.
	(imagePath parent / (anImage name , '.sh')) asFileReference
		writeStreamDo: [ :stream | 
			stream
				nextPutAll: './pharo-launcher image launch ';
				nextPutAll: anImage location ]
]

{ #category : #accessing }
PhLImageCreateLaunchScriptCliCommand >> executeWithImage: anImage [
	self createLaunchScript: anImage 
]
