Extension { #name : #PhLProcessWrapperTest }

{ #category : #'*PharoLauncher-CLI-Tests' }
PhLProcessWrapperTest >> setupProcessCmdWith: aCmdString [
	^ PhLProcessWrapper new
		shellCommand;
		addArguments: aCmdString;
		yourself
]

{ #category : #'*PharoLauncher-CLI-Tests' }
PhLProcessWrapperTest >> testRunAndWaitWithStdOutput [

	"test if command normally returns content of stdout"
	self deny: (self setupProcessCmdWith: 'ls') runAndWaitWithStdOutput isEmptyOrNil.

	"wrong command raises exception with proper description"
	[ (self setupProcessCmdWith: 'something') runAndWaitWithStdOutput ]
		on: PhLProcessCommandError
		do: [ :ex | 
			self assert: (ex description includesSubstring: 'OS process command exit with:').
			self assert: (ex description includesSubstring: 'Stderr contents:').
			self assert: (ex description includesSubstring: 'something') ]
]
