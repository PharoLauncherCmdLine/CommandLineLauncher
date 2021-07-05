Class {
	#name : #PhLImageRecreateCliCommandTest,
	#superclass : #PhLImageCliCommandTest,
	#category : #'PharoLauncher-CLI-Tests'
}

{ #category : #tests }
PhLImageRecreateCliCommandTest >> testCanRecreateAnImageInCommandLine [
	| image |
	image := self addImageNamed: 'myImage1'.
	image modification: true. 
	
	self runCommand: #('launcher' 'image' 'recreate' 'myImage1').
	 
	self assertSuccess.  
	self deny: image isModified 
]
