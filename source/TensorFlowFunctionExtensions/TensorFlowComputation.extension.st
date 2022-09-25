Extension {
	#name : 'TensorFlowComputation'
}

{ #category : '*TensorFlowFunctionExtensions',
 #vaCategories : ['Accessing'] }
TensorFlowComputation >> allTheFunctions [

	graph allTheFunctions
]

{ #category : '*TensorFlowFunctionExtensions',
 #vaCategories : ['Creating - Operations'] }
TensorFlowComputation >> storeComputationAsFunctionNamed: asName outputing: anOutputArray [

	graph storeAsFunctionNamed: asName outputing: anOutputArray
]
