Class {
	#name : 'ConstantNode',
	#superclass : 'TensorFlowOperationAbstract',
	#instVars : [
		'currentComputation'
	],
	#category : 'TFOperationModel'
}

{ #category : 'Instance Creation' }
ConstantNode class >> identityMatrixOn: aComputation named: aName rows: totalOfRows columns: totalOfColumns [

	^self
		on: aComputation
		named: 'Eye'
		with: (Array with: totalOfRows with: totalOfColumns) asInt32Tensor
		wrappedWith: [:shape | | zero |
			zero := TensorFiller fillWith: 0 asFloatTensor tensorShaped: shape.
			DiagonalSetter
				named: aName
				like: zero
				withElementsInDiagonal:
					(Array new: (totalOfRows min: totalOfColumns) withAll: 1) asFloatTensor]
]

{ #category : 'Instance Creation' }
ConstantNode class >> like: anOperation filledWith: aValue [

	^self
		on: anOperation currentComputation
		named: self operationType
		shaped: anOperation value outputShape
		filledWith: (TFTensor fromNumbers: aValue type: anOperation value outputType)
]

{ #category : 'Instance Creation' }
ConstantNode class >> on: aComputation named: aName shaped: aShape filledWith: aTensor [

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
ConstantNode class >> on: aComputation named: aName with: aTensor [

	^self on: aComputation named: aName with: aTensor wrappedWith: [:const | const]
]

{ #category : 'Instance Creation',
  #vaVisibility : 'private' }
ConstantNode class >> on: aComputation named: aName with: aTensor wrappedWith: aBlock [

	^self new initializeOn: aComputation named: aName with: aTensor wrappedWith: aBlock
]

{ #category : 'Instance Creation' }
ConstantNode class >> on: aComputation shaped: aShape filledWith: aTensor [

	^self on: aComputation named: self operationType shaped: aShape filledWith: aTensor
]

{ #category : 'Instance Creation' }
ConstantNode class >> on: aComputation with: aTensor [

	^self on: aComputation named: self operationType with: aTensor
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
ConstantNode class >> operationType [

	^'Const'
]

{ #category : 'Initialization' }
ConstantNode >> currentComputation [

	^currentComputation
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
ConstantNode >> initializeOn: aComputation named: aName with: aTFTensor wrappedWith: aWrapper [

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
