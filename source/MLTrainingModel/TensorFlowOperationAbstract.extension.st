Extension {
	#name : 'TensorFlowOperationAbstract'
}

{ #category : '*MLTrainingModel',
 #vaCategories : ['Accessing'] }
TensorFlowOperationAbstract >> += anOperation [

	^self currentComputation
		newOperationOf: 'AssignAdd'
		namePrefixed: 'AssignAdd'
		with: self
		with: anOperation
]
