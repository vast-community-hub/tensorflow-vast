Class {
	#name : 'TFConstant',
	#superclass : 'TFOperationAbstract',
	#category : 'TFOperationModel'
}

{ #category : 'Instance Creation',
  #vaVisibility : 'private' }
TFConstant class >> defaultName [

	^'Const'
]

{ #category : 'Instance Creation' }
TFConstant class >> identityMatrixOn: aComputation named: aName rows: totalOfRows columns: totalOfColumns [

	^self
		on: aComputation
		named: 'Eye'
		with: (Array with: totalOfRows with: totalOfColumns) asInt32Tensor
		wrappedWith: [:shape | | zero |
			zero := TFFiller fillWith: 0 asFloatTensor tensorShaped: shape.
			TFDiagonalSetter
				named: aName
				like: zero
				withElementsInDiagonal:
					(Array new: (totalOfRows min: totalOfColumns) withAll: 1) asFloatTensor]
]

{ #category : 'Instance Creation' }
TFConstant class >> like: anOperation filledWith: aValue [

	^self
		on: anOperation currentComputation
		named: self defaultName
		shaped: anOperation value outputShape
		filledWith: (TFTensor fromNumbers: aValue type: anOperation value outputType)
]

{ #category : 'Instance Creation' }
TFConstant class >> on: aComputation named: aName shaped: aShape filledWith: aTensor [

	^self
		on: aComputation
		named: aName
		with: aShape asInt32Tensor
		wrappedWith: [:shape | shape binaryOp: 'Fill' with: aTensor]
]

{ #category : 'Instance Creation' }
TFConstant class >> on: aComputation named: aName with: aTensor [

	^self on: aComputation named: aName with: aTensor wrappedWith: [:const | const]
]

{ #category : 'Instance Creation',
  #vaVisibility : 'private' }
TFConstant class >> on: aComputation named: aName with: aTensor wrappedWith: aBlock [

	^self new initializeOn: aComputation named: aName with: aTensor wrappedWith: aBlock
]

{ #category : 'Instance Creation' }
TFConstant class >> on: aComputation shaped: aShape filledWith: aTensor [

	^self on: aComputation named: self defaultName shaped: aShape filledWith: aTensor
]

{ #category : 'Instance Creation' }
TFConstant class >> on: aComputation with: aTensor [

	^self on: aComputation named: self defaultName with: aTensor
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
TFConstant >> initializeOn: aComputation named: aName with: aTFTensor wrappedWith: aWrapper [
	
	value :=
		aWrapper value: (
			aComputation
				newOperationOf: 'Const'
				named: aName
				withAll: #()
				describedBy: [:description |
					description at: 'dtype' putType: aTFTensor type.
					description at: 'value' putTensor: aTFTensor])
]

{ #category : 'Not categorized' }
TFConstant >> operationName [

	^value operationName
]

{ #category : 'Printing' }
TFConstant >> printOn: aStream [

	aStream nextPutAll: self operationName
]
