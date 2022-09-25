Class {
	#name : 'IdentityTransformation',
	#superclass : 'TensorFlowOperationAbstract',
	#instVars : [
		'currentComputation'
	],
	#category : 'TensorFlowOperationMathModel'
}

{ #category : 'Instance Creation' }
IdentityTransformation class >> named: anOperationName of: aTensor evaluatedOnlyAfter: anOperationCollection [

	^self new
		initializeNamed: anOperationName
		of: aTensor
		describedBy: [:d |
			anOperationCollection do: [:operation | d addControlInput: operation value]]
]

{ #category : 'Instance Creation' }
IdentityTransformation class >> of: aTensor evaluatedOnlyAfter: anOperationCollection [

	^self named: self operationType of: aTensor evaluatedOnlyAfter: anOperationCollection
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
IdentityTransformation class >> operationType [

	^'Identity'
]

{ #category : 'Accessing' }
IdentityTransformation >> currentComputation [

	^currentComputation
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
IdentityTransformation >> initializeNamed: anOperationName of: aTensor describedBy: aBlock [

	currentComputation := aTensor currentComputation.
	value :=
		currentComputation
			newOperationOf: self class operationType
			namePrefixed: anOperationName
			withAll: (Array with: aTensor)
			describedBy: aBlock
]
