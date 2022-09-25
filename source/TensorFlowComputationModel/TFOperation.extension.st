Extension {
	#name : 'TFOperation'
}

{ #category : '*TensorFlowComputationModel',
 #vaCategories : ['accessing'] }
TFOperation >> castedTo: aType [

	^self castTo: aType
]

{ #category : '*TensorFlowComputationModel',
 #vaCategories : ['accessing'] }
TFOperation >> computeEagerly [

	^graph runOutput: self firstOutput
]

{ #category : '*TensorFlowComputationModel',
 #vaCategories : ['accessing'] }
TFOperation >> currentComputation [

	^TensorFlowComputation on: graph
]

{ #category : '*TensorFlowComputationModel',
 #vaCategories : ['accessing'] }
TFOperation >> operationName [

	^ self name
]

{ #category : '*TensorFlowComputationModel',
 #vaCategories : ['accessing'] }
TFOperation >> outputDimensions [

	^graph outputDimensionsCount: self firstOutput
]

{ #category : '*TensorFlowComputationModel',
 #vaCategories : ['accessing'] }
TFOperation >> outputDomain [

	^TensorDomain of: self outputType withShape: self outputShape
]

{ #category : '*TensorFlowComputationModel',
 #vaCategories : ['accessing'] }
TFOperation >> outputOn: aGraph [

	^self firstOutput
]

{ #category : '*TensorFlowComputationModel',
 #vaCategories : ['accessing'] }
TFOperation >> outputShape [

	^self firstOutput shape
]

{ #category : '*TensorFlowComputationModel',
 #vaCategories : ['accessing'] }
TFOperation >> outputType [

	^self firstOutput type
]
