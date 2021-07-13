Class {
	#name : #PhLImageRecreateCliCommandTest,
	#superclass : #PhLImageCliCommandTest,
	#category : #'PharoLauncher-CLI-Tests'
}

{ #category : #running }
PhLImageRecreateCliCommandTest >> setUp [
	super setUp.
	self launcherModel templateRepository: PhLTemplateTestRepository new.
	self launcherModel imageRepository: PhLTestImageRepository new.

]

{ #category : #tests }
PhLImageRecreateCliCommandTest >> testCanRecreateAnImageShouldSucceed [
	| image imageFile command |
	command := PhLImageRecreateCliCommand with: context.
	imageFile := self imageRepository createImageNamed: 'myImage'.
	image := PhLImage location: imageFile.
	image originTemplate: (self templateRepository createLocalTemplateNamed: 'Foo test template').
		
	DiskStore
		currentFileSystem: self imageRepository baseDirectory  
		during: [
			self deny: imageFile contents equals: 'foo'.
			command executeWithImage: image.
			
			self assert: imageFile exists.
			self assert: imageFile contents equals: 'foo'].

]
