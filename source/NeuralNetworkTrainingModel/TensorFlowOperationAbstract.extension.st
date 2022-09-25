Extension {
	#name : 'TensorFlowOperationAbstract'
}

{ #category : '*NeuralNetworkTrainingModel',
 #vaCategories : ['Accessing'] }
TensorFlowOperationAbstract >> += anOperation [

	^self currentComputation
		newOperationOf: 'AssignAdd'
		namePrefixed: 'AssignAdd'
		with: self
		with: anOperation
]
