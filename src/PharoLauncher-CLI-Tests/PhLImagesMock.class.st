"
Only usefull for the tests, is usefull to create ""fake"" images. 
"
Class {
	#name : #PhLImagesMock,
	#superclass : #Object,
	#instVars : [
		'images',
		'name',
		'isLaunched',
		'script',
		'isModified'
	],
	#category : #'PharoLauncher-CLI-Tests'
}

{ #category : #accessing }
PhLImagesMock class >> name: aString [
   ^self new name: aString.
]

{ #category : #printing }
PhLImagesMock >> cliPrintString [
	^ self name
]

{ #category : #accessing }
PhLImagesMock >> description [ 
	^ 'this is the description'
]

{ #category : #mock }
PhLImagesMock >> ensureDefaultConfiguration [
	^self
]

{ #category : #testing }
PhLImagesMock >> hasInitializationScript [
	^ script notNil 
]

{ #category : #accessing }
PhLImagesMock >> initializationScript [
	^ script 
]

{ #category : #preparation }
PhLImagesMock >> initializationScript: aFileReference [
	 script := aFileReference
]

{ #category : #mock }
PhLImagesMock >> initialize [ 
	super initialize.
	isLaunched := false.
	isModified := false 
]

{ #category : #mock }
PhLImagesMock >> isLaunched [
	^ isLaunched
]

{ #category : #mock }
PhLImagesMock >> isModified [
	^ isModified
]

{ #category : #accessing }
PhLImagesMock >> lastModification [
	^ 'some random date'
]

{ #category : #mock }
PhLImagesMock >> launch [
	isLaunched := true
]

{ #category : #accessing }
PhLImagesMock >> location [
	^ 'my current location'
]

{ #category : #mock }
PhLImagesMock >> modification: aBoolean [
	isModified := aBoolean
]

{ #category : #accessing }
PhLImagesMock >> name [
   ^name
]

{ #category : #accessing }
PhLImagesMock >> name: aString [
   name := aString
]

{ #category : #accessing }
PhLImagesMock >> originTemplateName [
	^ 'the original template name'
]

{ #category : #accessing }
PhLImagesMock >> originTemplateUrl [
	^ 'https://testurl'
]

{ #category : #accessing }
PhLImagesMock >> pharoVersionFromFile [
	^ 'Pharo 8'
]

{ #category : #mocking }
PhLImagesMock >> shouldRunInitializationScript: aTrue [ 
	^ self 
]
