Class {
	#name : #PhLDownloadManagerBothUiAndNonUI,
	#superclass : #PhLDownloadManager,
	#category : #'PharoLauncher-Core-Download'
}

{ #category : #private }
PhLDownloadManagerBothUiAndNonUI >> displayProgressDuring: workBlock [
	| progressionFrom0To10 |
	progressionFrom0To10 := 0.
	workBlock
		on: HTTPProgress
		do: [ :progress | 
			progress percentage
				ifNotNil: [ ( progress percentage // 10 > progressionFrom0To10 )
						ifTrue: [ progressionFrom0To10 := progressionFrom0To10 + 1.
							self nonUIProgressBar: progressionFrom0To10 ] ].
			progress resume ]
]

{ #category : #'as yet unclassified' }
PhLDownloadManagerBothUiAndNonUI >> nonUIProgressBar: aNumber [
	PhLNotificationCenter default outStream nextPutAll: '['.
	aNumber timesRepeat: [ PhLNotificationCenter default outStream nextPutAll: '#'. ].
	(10 - aNumber) timesRepeat: [ PhLNotificationCenter default outStream nextPutAll: ' '. ].
	PhLNotificationCenter default outStream nextPutAll: ']'.
	PhLNotificationCenter default outStream nextPutAll: OSPlatform current lineEnding 
	
	

]
