Class {
	#name : 'IdentityTransformation',
	#superclass : 'TensorFlowOperationAbstract',
	#category : 'TFOperationModel'
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

{ #category : 'Initialization',
  #vaVisibility : 'private' }
IdentityTransformation >> initializeNamed: anOperationName of: aTensor describedBy: aBlock [

	value :=
		aTensor currentComputation
			newOperationOf: self class operationType
			namePrefixed: anOperationName
			withAll: (Array with: aTensor)
			describedBy: aBlock
]
