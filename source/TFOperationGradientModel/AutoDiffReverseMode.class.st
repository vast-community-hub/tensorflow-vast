Class {
	#name : 'AutoDiffReverseMode',
	#superclass : 'AutoDiffMode',
	#instVars : [
		'operationToDifferentiate',
		'partialDerivatives'
	],
	#category : 'TFOperationGradientModel'
}

{ #category : 'Not categorized' }
AutoDiffReverseMode class >> startingWith: anOperation [

	
	^self new initializeStartingWith: anOperation
]

{ #category : 'Computing',
  #vaVisibility : 'private' }
AutoDiffReverseMode >> computeGradientOf: anOperation [

	anOperation inputsDo: [:input |
		self propagateAdjointOf: anOperation withRespectTo: input.
		self computeGradientOf: input]
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
AutoDiffReverseMode >> initializeStartingWith: anOperation [

	operationToDifferentiate := anOperation.
	partialDerivatives :=
		Dictionary new
			at: anOperation put: (TFConstant like: operationToDifferentiate filledWith: 1);
			yourself.

	self computeGradientOf: anOperation
]

{ #category : 'Accessing' }
AutoDiffReverseMode >> partialDerivativeOf: aVariable [

	^partialDerivatives
		at: aVariable
		ifAbsent: [operationToDifferentiate raiseIsNotDifferentiableRespectTo: aVariable]
]

{ #category : 'Computing',
  #vaVisibility : 'private' }
AutoDiffReverseMode >> propagateAdjointOf: anOperation withRespectTo: anInput [

	| dInput |

	dInput :=
		TFElementWiseMultiplication
			of: (anOperation derivativeWithRespectTo: anInput)
			and: (self partialDerivativeOf: anOperation).

	self sum: dInput toPartialDerivativeOf: anInput
]

{ #category : 'Computing',
  #vaVisibility : 'private' }
AutoDiffReverseMode >> sum: aValue toPartialDerivativeOf: aVariable [

	| dInput |

	dInput :=
		(partialDerivatives includesKey: aVariable)
			ifTrue: [TFSum of: aValue plus: (self partialDerivativeOf: aVariable)]
			ifFalse: [aValue].

	partialDerivatives at: aVariable put: dInput
]
