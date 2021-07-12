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
	| imagePath script |
	imagePath := anImage location asPath.
	script := (imagePath parent / (anImage name , '.sh')) asFileReference.
	script
		writeStreamDo: [ :stream | 
			stream
				nextPutAll: './pharo-launcher image launch ';
				nextPutAll: anImage location;
				lf ].
	LibC runCommand: 'chmod +x ',script fullName
]

{ #category : #accessing }
PhLImageCreateLaunchScriptCliCommand >> executeWithImage: anImage [
	self createLaunchScript: anImage 
]
