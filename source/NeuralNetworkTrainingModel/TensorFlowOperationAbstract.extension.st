Extension {
	#name : 'TensorFlowOperationAbstract'
}

{ #category : 'Accessing' }
TensorFlowOperationAbstract >> += anOperation [

	^self currentComputation
		newOperationOf: 'AssignAdd'
		namePrefixed: 'AssignAdd'
		with: self
		with: anOperation
]
