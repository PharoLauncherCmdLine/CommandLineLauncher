Extension { #name : #PhLProcessWrapper }

{ #category : #'*PharoLauncher-CLI' }
PhLProcessWrapper >> getExceptionMessageFor: cmdString status: statusMsg stdError: errorString [

	^ String streamContents: [:aStream | 
		aStream 
			nextPutAll: ('OS process command: ''{1}''  exited with: {2}.' format: {cmdString. statusMsg.});
			nextPutAll: OSPlatform current lineEnding;
			nextPutAll: ('Stderr contents: "{1}".' format: {errorString}).
	]
]

{ #category : #'*PharoLauncher-CLI' }
PhLProcessWrapper >> runAndWaitWithStdOutput [
	"this is helper method to catch std. output and return to sender of this method, 
	 exit codes are handled and proper exception is raised, when not successful
	"

	self prepareProcess.
	process
		redirectStdout;
		redirectStderr;
		runAndWaitOnExitDo: [ :termProcess :outString :errString | 
			termProcess isSuccess
				ifTrue: [ ^ outString ]
				ifFalse: [ | exceptionMessage |
					exceptionMessage := self
						getExceptionMessageFor: self commandLineString
						status: termProcess exitStatusInterpreter printString
						stdError: errString.
					PhLProcessCommandError signal: exceptionMessage ] ]
]
