Extension {
	#name : 'TensorFlowComputation'
}

{ #category : 'Accessing' }
TensorFlowComputation >> allTheFunctions [

	graph allTheFunctions
]

{ #category : 'Creating - Operations' }
TensorFlowComputation >> storeComputationAsFunctionNamed: asName outputing: anOutputArray [

	graph storeAsFunctionNamed: asName outputing: anOutputArray
]
