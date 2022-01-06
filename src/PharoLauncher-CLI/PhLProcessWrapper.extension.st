Extension { #name : #PhLProcessWrapper }

{ #category : #'*PharoLauncher-CLI' }
PhLProcessWrapper >> addAllArguments: argsArray [
	
	"supplemental method for adding args from array and not just a string"
	argsArray do: [:arg | self addArgument: arg ]
]

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
	"return content of stdout, may throw exception that can be handled by sender of this method"
	^ process runAndWaitWithStdOutput 
]
