Class {
	#name : 'OneHotTensor',
	#superclass : 'TensorFlowOperationAbstract',
	#category : 'TFOperationModel'
}

{ #category : 'Instance Creation' }
OneHotTensor class >> transforming: anInput toDepth: aDepth [

	^self transforming: anInput toDepth: aDepth usingAsOn: 1 asInt32Tensor andAsOff: 0 asInt32Tensor
]

{ #category : 'Instance Creation' }
OneHotTensor class >> transforming: anInput toDepth: aDepth usingAsOn: anOnValue andAsOff: anOffValue [

	^self new
		initializeTransforming: anInput
		toDepth: aDepth
		usingAsOn: anOnValue
		andAsOff: anOffValue
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
OneHotTensor >> initializeTransforming: anInput toDepth: aDepth usingAsOn: anOnValue andAsOff: anOffValue [

	value :=
		anInput currentComputation
			newOperationOf: self operationType
			namePrefixed: self operationType
			withAll: (Array with: anInput with: aDepth with: anOnValue with: anOffValue)
			describedBy: [:description | ]
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
OneHotTensor >> operationType [

	^'OneHot'
]
