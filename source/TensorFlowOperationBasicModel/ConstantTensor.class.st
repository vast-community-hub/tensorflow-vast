Class {
	#name : 'ConstantTensor',
	#superclass : 'TensorFlowOperationAbstract',
	#instVars : [
		'currentComputation'
	],
	#category : 'TensorFlowOperationBasicModel'
}

{ #category : 'Instance Creation' }
ConstantTensor class >> like: anOperation filledWith: aValue [

	^self
		on: anOperation currentComputation
		named: self operationType
		shaped: anOperation value outputShape
		filledWith: (TFTensor newTyped: anOperation value outputType containing: aValue)
]

{ #category : 'Instance Creation' }
ConstantTensor class >> on: aComputation named: aName shaped: aShape filledWith: aTensor [

	^ self
		on: aComputation
		named: aName
		with: aShape asInt32Tensor
		wrappedWith: [ :shape | 
			aComputation
				newOperationOf: 'Fill'
				namePrefixed: aName, '-fill'
				with: shape
				with: aTensor
			]
]

{ #category : 'Instance Creation' }
ConstantTensor class >> on: aComputation named: aName with: aTensor [

	^self on: aComputation named: aName with: aTensor wrappedWith: [:const | const]
]

{ #category : 'Instance Creation',
  #vaVisibility : 'private' }
ConstantTensor class >> on: aComputation named: aName with: aTensor wrappedWith: aBlock [

	^self new initializeOn: aComputation named: aName with: aTensor wrappedWith: aBlock
]

{ #category : 'Instance Creation' }
ConstantTensor class >> on: aComputation shaped: aShape filledWith: aTensor [

	^self on: aComputation named: self operationType shaped: aShape filledWith: aTensor
]

{ #category : 'Instance Creation' }
ConstantTensor class >> on: aComputation with: aTensor [

	^self on: aComputation named: self operationType with: aTensor
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
ConstantTensor class >> operationType [

	^'Const'
]

{ #category : 'Initialization' }
ConstantTensor >> currentComputation [

	^currentComputation
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
ConstantTensor >> initializeOn: aComputation named: aName with: aTFTensor wrappedWith: aWrapper [

	currentComputation := aComputation.
	value :=
		aWrapper value: (
			aComputation
				newOperationOf: self class operationType
				namePrefixed: aName
				withAll: #()
				describedBy: [:description |
					description atDataTypePut: aTFTensor type.
					description atValuePut: aTFTensor])
]
