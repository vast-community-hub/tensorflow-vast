Extension {
	#name : 'TensorFlowComputation'
}

{ #category : 'Not categorized' }
TensorFlowComputation >> importGraphFrom: aFileName [

	graph importFileNamed:  aFileName
]

{ #category : 'Not categorized' }
TensorFlowComputation >> storeGraphInto: aFileName [

	graph writeDefToFileNamed: aFileName
]
