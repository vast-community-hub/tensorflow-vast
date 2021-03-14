Extension {
	#name : 'TFOperation'
}

{ #category : '*TFOperationModel',
 #vaCategories : ['accessing'] }
TFOperation >> castedTo: aType [

	^self castTo: aType
]

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

	^graph outputDimensionsCount: self firstOutput
]

{ #category : '*TFOperationModel',
 #vaCategories : ['accessing'] }
TFOperation >> outputDomain [

	^TensorDomain of: self outputType withShape: self outputShape
]

{ #category : '*TFOperationModel',
 #vaCategories : ['accessing'] }
TFOperation >> outputOn: aGraph [

	^self firstOutput
]

{ #category : '*TFOperationModel',
 #vaCategories : ['accessing'] }
TFOperation >> outputShape [

	^self firstOutput shape
]

{ #category : '*TFOperationModel',
 #vaCategories : ['accessing'] }
TFOperation >> outputType [

	^self firstOutput type
]
