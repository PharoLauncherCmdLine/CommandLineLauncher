Extension { #name : #PhLVirtualMachineManager }

{ #category : #'*PharoLauncher-CLI' }
PhLVirtualMachineManager >> hostOS [
	|platform|
	platform := 	OSPlatform current.
	(platform isMacOS or: [  platform isMacOSX]) ifTrue: [ ^ 'Darwin' ].
	platform isUnix ifTrue: [ ^ 'Linux' ].
	platform isWindows ifTrue: [ ^ 'Windows' ].
]

{ #category : #'*PharoLauncher-CLI' }
PhLVirtualMachineManager >> vmUrl [
	| architecture pharoVersion |
	architecture := (self class is64bits: imageFormatNumber) ifTrue: [ '64' ] ifFalse: [ '' ].
	pharoVersion  := ((self class isPreSpur: imageFormatNumber) and: [ self imageVersion = '50' ])
		ifTrue: [ '50-preSpur' ]
		ifFalse: [ self imageVersion ].
	pharoVersion = '100' ifTrue: [ ^ self vmUrl100Template format: { pharoVersion. self hostOS. 'x86_64'. 'stable'.  } ].
	^ self vmUrlTemplate
		format: { pharoVersion . architecture . self downloadPathOSTypeSegment . '' . 'stable' }
]

{ #category : #'*PharoLauncher-CLI' }
PhLVirtualMachineManager >> vmUrl100Template [
	"$1: IMAGE_VERSION (11 .. 70, 80, 90, 100)
	 $2: HOST_OS (Darwin, Windows, Linux)
	 $3: HOST_ARCH (x86, x86_64, arm64)
	 $4: VM_STATUS (stable, latest)
	"
	^ 'https://files.pharo.org/get-files/{IMAGE_VERSION}/pharo-vm-{HOST_OS}-{HOST_ARCH}-{VM_STATUS}.zip'
]
