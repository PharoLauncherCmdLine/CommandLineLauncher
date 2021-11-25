Extension { #name : #PhLProcessWrapper }

{ #category : #'*PharoLauncher-CLI' }
PhLProcessWrapper >> runAndWaitWithStdOutput [
	"this is helper method to catch std. output and return to sender of this method, 
	 exit codes are handled and proper exception is raised, when not successful
	"
	self prepareProcess.
	process 
		redirectStdout;
		redirectStderr;
	runAndWaitOnExitDo: [:termProcess :outString :errString |
		termProcess isSuccess
			ifTrue: [^ outString ]
			ifFalse: [
				|exceptionMessage|
				exceptionMessage := String streamContents: [:aStream | 
				aStream nextPutAll: 'OS process command exit with: ';
				 nextPutAll: termProcess exitStatusInterpreter printString;
				 nextPutAll: OSPlatform current lineEnding;
				 nextPutAll: '. Stderr contents: ';
				 nextPutAll: errString.
				].
			PhLProcessCommandError signal: exceptionMessage.
	]]
]
