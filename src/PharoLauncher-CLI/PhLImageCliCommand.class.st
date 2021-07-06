"
I represent Pharo Image sub-command of Pharo Launcher. My responsibility is to take care of Pharo image sub-commands. 

I use: 
 - Pharo launcher root command to declare my other sub-commands.

I declare: 
- copy, create, delete, info initScriptsDir, launch, list, update sub-commands

I execute:
- just printing help about my sub-commands relevant for Pharo images
"
Class {
	#name : #PhLImageCliCommand,
	#superclass : #PhLCliCommand,
	#category : #'PharoLauncher-CLI'
}

{ #category : #'command line' }
PhLImageCliCommand class >> asCliCommand [
	^ self newLauncherCommand: #image
]

{ #category : #'command line' }
PhLImageCliCommand class >> launcherCmdDescription [

	^ 'All sub-commands related to management of local Pharo images.'
]

{ #category : #'command execution' }
PhLImageCliCommand >> execute [
	[ self executeWithImage: self findImage ]
		on: NotFound
		do: [ ^ self logImageNotFoundMessage ]
]

{ #category : #accessing }
PhLImageCliCommand >> findImage [
	^ self findImage: self imageName  
]

{ #category : #accessing }
PhLImageCliCommand >> findImage: anImageName [
	^ [ self findInDirectory: anImageName ]
		on: NotFound
		do: [ self findOnFileSystem: anImageName ]
]

{ #category : #'finding/searching' }
PhLImageCliCommand >> findInDirectory: anImageName [
	^ self imageRepository imageNamed: anImageName asLowercase
]

{ #category : #'find-select' }
PhLImageCliCommand >> findOnFileSystem: anImageName [
	(anImageName asFileReference exists
		and: [ anImageName asFileReference isFile ])
		ifFalse: [ NotFound signal: self logImageNotFoundMessage  ].
	^ PhLImage location: anImageName asFileReference
]

{ #category : #accessing }
PhLImageCliCommand >> imageName [
	^ (arguments at: #existingImageName)
		value: self;
		word
]

{ #category : #printing }
PhLImageCliCommand >> logImageNotFoundMessage [
	self errorStream nextPutAll: 'please enter a correct local image'.
	self errorStream newLine.
	^ self
]
