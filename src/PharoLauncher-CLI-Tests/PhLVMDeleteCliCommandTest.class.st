Class {
	#name : #PhLVMDeleteCliCommandTest,
	#superclass : #PhLVmCliCommandTest,
	#category : #'PharoLauncher-CLI-Tests'
}

{ #category : #tests }
PhLVMDeleteCliCommandTest >> testDeleteVmShouldSucceed [
	self addVmNamed: 'myVm1'.
	self addVmNamed: 'myVm2'.
	
	self runCommand: #('launcher' 'vm' 'delete' 'myVm1').
	 
	self assert: (( self vmRepository availableVirtualMachines at:'myVm1') isDeleted). 
]

{ #category : #tests }
PhLVMDeleteCliCommandTest >> testDeleteVmWithWrongVmNameShouldGiveBackNotFoundMessage [
	self addVmNamed: 'myVm1'.
	self addVmNamed: 'myVm2'.
	
	self runCommand: #('launcher' 'vm' 'delete' 'wrongVmName').
	 
	self assert: ( self errorString includesSubstring: 'please enter a correct local virtual machine' ). 
]
