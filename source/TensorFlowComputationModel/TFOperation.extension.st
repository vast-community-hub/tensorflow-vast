Extension {
	#name : 'TFOperation'
}

{ #category : 'accessing' }
TFOperation >> castedTo: aType [

	^self castTo: aType
]

{ #category : 'accessing' }
TFOperation >> computeEagerly [

	^graph runOutput: self firstOutput
]

{ #category : 'accessing' }
TFOperation >> currentComputation [

	^TensorFlowComputation on: graph
]

{ #category : 'accessing' }
TFOperation >> operationName [

	^ self name
]

{ #category : 'accessing' }
TFOperation >> outputDimensions [

	^graph outputDimensionsCount: self firstOutput
]

{ #category : 'accessing' }
TFOperation >> outputDomain [

	^TensorDomain of: self outputType withShape: self outputShape
]

{ #category : 'accessing' }
TFOperation >> outputOn: aGraph [

	^self firstOutput
]

{ #category : 'accessing' }
TFOperation >> outputShape [

	^self firstOutput shape
]

{ #category : 'accessing' }
TFOperation >> outputType [

	^self firstOutput type
]
