Class {
	#name : #PhLImageCreateLaunchScriptCliCommandTest,
	#superclass : #PhLImageCliCommandTest,
	#category : #'PharoLauncher-CLI-Tests'
}

{ #category : #tests }
PhLImageCreateLaunchScriptCliCommandTest >> testCreateLaunchScriptShouldSucceed [
   | image imageTestRepository imageFile command memoryFileSystem content|
	command := PhLImageCreateLaunchScriptCliCommand with: context.
	memoryFileSystem := FileSystem memory.
	imageTestRepository := PhLTestImageRepository new.
	imageFile := imageTestRepository createImageNamed: 'myImage' in: memoryFileSystem root / 'myImage'.
	image := PhLImage location: imageFile.
	self launcherModel imageRepository: (PhLDirectoryBasedImageRepository forDirectory: memoryFileSystem root).
	
	DiskStore
		currentFileSystem: memoryFileSystem 
		during: [ 
			command executeWithImage: image.
			content := ((DiskStore currentFileSystem root/'myImage'/ 'myImage.sh') readStream) contents. 
			self assert: (DiskStore currentFileSystem root/'myImage'/ 'myImage.sh') isFile.
			self assert: (content includesSubstring:'./pharo-launcher image launch /myImage/myImage.image')].
		
	
	
	
	
	
	
]
