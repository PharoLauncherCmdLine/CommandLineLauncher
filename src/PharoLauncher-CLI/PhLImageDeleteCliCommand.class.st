"
I represent Pharo Image delete sub-command invoked from cmd line of Pharo Launcher. My responsibility is to delete local images within Pharo launcher based on specified image name. 

I declare: 
- mandatory positional with existing image name, based on which is image deleted

I execute:
- delete local image based on specified image name
"
Class {
	#name : #PhLImageDeleteCliCommand,
	#superclass : #PhLImageCliCommand,
	#category : #'PharoLauncher-CLI-Commands'
}

{ #category : #'command line' }
PhLImageDeleteCliCommand class >> asCliCommand [
	^ self newLauncherCommand: #delete 
]

{ #category : #'command line' }
PhLImageDeleteCliCommand class >> launcherCmdDescription [

	^ 'Deletes the local image, including image directory content.'
]

{ #category : #'command line' }
PhLImageDeleteCliCommand class >> launcherCmdPositionals [
	^ {((ClapPositional id: #existingImageName)
		description: 'Local image name to be deleted.';
		meaning: [ :pos | pos asString ];
		implicitMeaning: [ :arg :app | NotFound 
        signal: 'An argument is missing, please specify the local image name to be deleted.' .];
		yourself)}
]

{ #category : #accessing }
PhLImageDeleteCliCommand >> execute [
	[ self imageRepository deleteImage: (self findInRepository: self imageName) ]
		on: NotFound
		do: [ ^ self logImageNotFoundMessage ]
]
