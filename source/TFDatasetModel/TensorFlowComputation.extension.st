Extension {
	#name : 'TensorFlowComputation'
}

{ #category : '*TFDatasetModel',
 #vaCategories : ['Computing'] }
TensorFlowComputation >> createSessionAndRun: anOperation [

	session ifNil: [
		session := TFSession on: graph.
		"When initialize graph, we initialize also the variables. So this can't be done before the variables are created, 
		 and can't be done every time we call run, because will be overriding them every time with the initial value. 
		 This is the best place I cound found to do it."
		graph initializeOn: session].

	^session runOperation: anOperation
]
