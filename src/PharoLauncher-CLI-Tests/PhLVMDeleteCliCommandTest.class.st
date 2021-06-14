Class {
	#name : #PhLVMDeleteCliCommandTest,
	#superclass : #PhLVMCliCommandTest,
	#category : #'PharoLauncher-CLI-Tests'
}

{ #category : #tests }
PhLVMDeleteCliCommandTest >> testDeleteVmShouldSucceed [
	self addVmNamed: 'myVm1' at: 'bli'.
	self addVmNamed: 'myVm2' at: 'blo'.
	
	self runCommand: #('launcher' 'vm' 'delete' 'myVm1').
	 
	self assert: (( self vmRepository availableVirtualMachines at:'bli') state ) equals: 'successfully deleted'. 
]