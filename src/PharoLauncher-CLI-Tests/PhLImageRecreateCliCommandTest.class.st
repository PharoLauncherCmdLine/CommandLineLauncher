Class {
	#name : #PhLImageRecreateCliCommandTest,
	#superclass : #PhLImageCliCommandTest,
	#category : #'PharoLauncher-CLI-Tests'
}

{ #category : #tests }
PhLImageRecreateCliCommandTest >> templateZipFile [
	| archive zipFile |
	archive := ZipArchive new.
	archive addDeflateString: 'foo' as: 'bar.image'.
	archive addDeflateString: 'foo' as: 'bar.changes'.
	
	zipFile := FileSystem memory root / 'template.zip'.
	zipFile binaryWriteStreamDo: [ :stream | archive writeTo: stream ].
	^ zipFile
]

{ #category : #tests }
PhLImageRecreateCliCommandTest >> testCanRecreateAnImage2 [
	| image imageTestRepository imageFile command memoryFileSystem |
	command := PhLImageRecreateCliCommand with: context.
	memoryFileSystem := FileSystem memory.
	imageTestRepository := PhLTestImageRepository new.

	imageFile := imageTestRepository createImageNamed: 'myImage' in: memoryFileSystem root / 'myImage'.
	image := PhLImage location: imageFile.
	image originTemplate:(PhLLocalTemplate name: 'Foo test template' zipFile: self templateZipFile).
	
	self launcherModel imageRepository: (PhLDirectoryBasedImageRepository forDirectory: memoryFileSystem root).
	
	DiskStore
		currentFileSystem: memoryFileSystem 
		during: [ 
			command executeWithImage: image.
			self assert: imageFile exists.
			self assert: imageFile contents equals: 'foo'].

]

{ #category : #tests }
PhLImageRecreateCliCommandTest >> testRecreateAnImage [
	| image |
	self addImageNamed: 'myNewImage'.
	image := self imageRepository images detect: [ :each | each name = 'myNewImage' ].
	image isModified: true. 
	
	self runCommand: {'launcher'. 'image'.'recreate'. 'myNewImage'}.
	
	self assertSuccess. 
	self deny: (image isModified ).

]
