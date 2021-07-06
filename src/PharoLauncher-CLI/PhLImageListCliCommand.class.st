"
I represent Pharo Image list sub-command invoked from cmd line of Pharo Launcher. My responsibility is to list local images within Pharo launcher that were previously created or imported. 

I declare: 
- optional flag for stonOutput

I execute:
- list local images with detailed information about image name, used VM, architecture, local dir, etc.
"
Class {
	#name : #PhLImageListCliCommand,
	#superclass : #PhLImageCliCommand,
	#category : #'PharoLauncher-CLI'
}

{ #category : #'command line' }
PhLImageListCliCommand class >> asCliCommand [
	^ self newLauncherCommand: #list 
]

{ #category : #'command line' }
PhLImageListCliCommand class >> launcherCmdDescription [

	^ 'Lists all downloaded images on local computer.'
]

{ #category : #'command line - arguments' }
PhLImageListCliCommand class >> launcherCmdFlags [
	^ {(ClapFlag id: #name)
			description: 'Allows to list images including a substring ';
			meaning: [ :arg :app | "this argument is optional "
				(arg at: #nameAsString) word ];
			implicitMeaning: [ :arg :app |  ];
			add: ((ClapPositional id: #nameAsString)
					description: 'the substring to search through the images';
					meaning: [ :pos | pos word asSymbol ];
					implicitMeaning: [ :arg :app | ])}
]

{ #category : #'instance creation' }
PhLImageListCliCommand >> execute [
   self listImages.
]

{ #category : #listing }
PhLImageListCliCommand >> imagesFromName: aSubtring [
	| counter |
	counter := 1.
	self imageRepository images
		do: [ :anItem | 
			(anItem name includesSubstring: aSubtring)
				ifTrue: [ self outStream
						nextPutAll: counter asString;
						nextPutAll: ': ';
						nextPutAll: anItem cliPrintString;
						newLine.
					counter := counter + 1 ] ]
]

{ #category : #'instance creation' }
PhLImageListCliCommand >> listImages [
	self name ifNotNil:[ ^ self imagesFromName: self name].
	self list: self imageRepository images
]

{ #category : #'instance creation' }
PhLImageListCliCommand >> listImagesAsSton [
	| stonOutput |
	stonOutput := ''.
	stonOutput := STON toString: (self listImages).
	self outStream nextPutAll: stonOutput
]

{ #category : #'accessing arguments' }
PhLImageListCliCommand >> name [
	^ (arguments at: #name) value: self
]
