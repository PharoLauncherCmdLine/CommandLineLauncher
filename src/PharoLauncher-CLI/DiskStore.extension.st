Extension { #name : #DiskStore }

{ #category : #'*PharoLauncher-CLI' }
DiskStore class >> currentFileSystem: aFileSystem [
	^	CurrentFS := aFileSystem 
]

{ #category : #'*PharoLauncher-CLI' }
DiskStore class >> currentFileSystem: fileSystem during: aBlock [
	| backupFileSystem |
	backupFileSystem := self currentFileSystem.
	[ CurrentFS := fileSystem.
	aBlock value ]
		ensure: [ self currentFileSystem: backupFileSystem ]
]
