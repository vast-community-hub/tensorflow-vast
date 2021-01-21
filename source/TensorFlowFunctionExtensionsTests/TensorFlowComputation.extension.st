Extension {
	#name : 'TensorFlowComputation'
}

{ #category : '*TensorFlowFunctionExtensionsTests',
 #vaCategories : ['Accessing'] }
TensorFlowComputation >> allTheFunctions [

	graph allTheFunctions
]

{ #category : '*TensorFlowFunctionExtensionsTests',
 #vaCategories : ['Creating - Operations'] }
TensorFlowComputation >> storeComputationAsFunctionNamed: asName outputing: anOutputArray [

	graph storeAsFunctionNamed: asName outputing: anOutputArray
]
