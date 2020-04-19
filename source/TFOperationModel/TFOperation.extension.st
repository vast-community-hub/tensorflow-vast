Extension {
	#name : 'TFOperation'
}

{ #category : '*TFOperationModel',
 #vaCategories : ['accessing'] }
TFOperation >> computeEagerly [

	^graph runOutput: self firstOutput
]

{ #category : '*TFOperationModel',
 #vaCategories : ['accessing'] }
TFOperation >> currentComputation [

	^TensorFlowComputation on: graph
]

{ #category : '*TFOperationModel',
 #vaCategories : ['accessing'] }
TFOperation >> operationName [

	^ self name
]

{ #category : '*TFOperationModel',
 #vaCategories : ['accessing'] }
TFOperation >> outputDimensions [

	^graph outputDimenssionsCount: self firstOutput
]

{ #category : '*TFOperationModel',
 #vaCategories : ['accessing'] }
TFOperation >> outputOn: aGraph [

	^self firstOutput
]

{ #category : '*TFOperationModel',
 #vaCategories : ['accessing'] }
TFOperation >> outputShape [

	^(graph rankOf: self firstOutput) negative
		ifTrue: [#()]
		ifFalse: [graph shapeOf: self firstOutput]
]

{ #category : '*TFOperationModel',
 #vaCategories : ['accessing'] }
TFOperation >> outputType [

	^self firstOutput type
]
