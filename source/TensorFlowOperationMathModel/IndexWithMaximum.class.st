Class {
	#name : 'IndexWithMaximum',
	#superclass : 'TensorFlowOperationAbstract',
	#instVars : [
		'tensor',
		'axis',
		'currentComputation'
	],
	#category : 'TensorFlowOperationMathModel'
}

{ #category : 'Instance Creation' }
IndexWithMaximum class >> in: aTensor across: anAxis [

	^self named: self operationType in: aTensor across: anAxis
]

{ #category : 'Instance Creation' }
IndexWithMaximum class >> named: anOperationName in: aTensor across: anAxis [

	^self new initializeNamed: anOperationName in: aTensor across: anAxis
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
IndexWithMaximum class >> operationType [

	^'ArgMax'
]

{ #category : 'Initialization' }
IndexWithMaximum >> currentComputation [

	^currentComputation
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
IndexWithMaximum >> initializeNamed: anOperationName in: aTensor across: anAxis [

	currentComputation := aTensor currentComputation.
	tensor := aTensor.
	axis := anAxis.
	value :=
		currentComputation
			newOperationOf: self class operationType
			namePrefixed: anOperationName
			with: tensor
			with: axis asInt32Tensor
]
