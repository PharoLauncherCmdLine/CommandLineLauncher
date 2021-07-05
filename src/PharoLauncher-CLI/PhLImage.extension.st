Extension { #name : #PhLImage }

{ #category : #'*PharoLauncher-CLI' }
PhLImage >> cliPrintString [
	^ self name,'    architecture: ', self architecture.
]
