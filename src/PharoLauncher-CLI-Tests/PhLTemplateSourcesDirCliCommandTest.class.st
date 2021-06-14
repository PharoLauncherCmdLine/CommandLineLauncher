Class {
	#name : #PhLTemplateSourcesDirCliCommandTest,
	#superclass : #PhLTemplatesCliCommandTest,
	#category : #'PharoLauncher-CLI-Tests'
}

{ #category : #tests }
PhLTemplateSourcesDirCliCommandTest >> testTemplateSourcesDir [
	
	self runCommand: #('launcher' 'template' 'sourcesDir').
	
	self assertSuccess.
	self assert: (self outputString includesSubstring: 'memory:///') 
]