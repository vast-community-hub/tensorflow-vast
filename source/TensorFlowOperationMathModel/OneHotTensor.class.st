Class {
	#name : 'OneHotTensor',
	#superclass : 'TensorFlowOperationAbstract',
	#instVars : [
		'input'
	],
	#category : 'TensorFlowOperationMathModel'
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

{ #category : 'Accessing' }
OneHotTensor >> currentComputation [

	^input currentComputation
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
OneHotTensor >> initializeTransforming: anInput toDepth: aDepth usingAsOn: anOnValue andAsOff: anOffValue [

	input := anInput.
	value :=
		self currentComputation
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
