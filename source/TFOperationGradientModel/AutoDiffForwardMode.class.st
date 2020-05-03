Class {
	#name : 'AutoDiffForwardMode',
	#superclass : 'AutoDiffMode',
	#instVars : [
		'operationToDifferentiate',
		'inputDerivedRespectTo',
		'partialDerivatives'
	],
	#category : 'TFOperationGradientModel'
}

{ #category : 'Instance Creation' }
AutoDiffForwardMode class >> startingWith: anOperation withRespectTo: aVariable [

	^self new initializeStartingWith: anOperation withRespectTo: aVariable
]

{ #category : 'Computing',
  #vaVisibility : 'private' }
AutoDiffForwardMode >> computeGradientOf: anOperation [

	anOperation inputsDo: 
			[:input | 
			self computeGradientOf: input.
			self propagateSensitivityOf: anOperation withRespectTo: input]
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
AutoDiffForwardMode >> initializeStartingWith: anOperation withRespectTo: anInput [

	
	partialDerivatives := Dictionary new. 
	operationToDifferentiate := anOperation. 
	inputDerivedRespectTo := anInput.
	
	self computeGradientOf: anOperation.
]

{ #category : 'Computing',
  #vaVisibility : 'private' }
AutoDiffForwardMode >> isDifferentiableWithRespectTo: anInput [

	^inputDerivedRespectTo = anInput or: [partialDerivatives includesKey: anInput]
]

{ #category : 'Computing',
  #vaVisibility : 'private' }
AutoDiffForwardMode >> partialDerivativeOf: anInput [

	^partialDerivatives at: anInput
]

{ #category : 'Accessing' }
AutoDiffForwardMode >> partialDerivativeValue [

	^self partialDerivativeOf: operationToDifferentiate
]

{ #category : 'Computing',
  #vaVisibility : 'private' }
AutoDiffForwardMode >> propagateSensitivityOf: anOperation withRespectTo: anInput [

	| dInput |

	(self isDifferentiableWithRespectTo: anInput) ifFalse: [^self].

	dInput := anOperation derivativeWithRespectTo: anInput.
	inputDerivedRespectTo = anInput
		ifFalse: [
			dInput := TFElementWiseMultiplication of: dInput and: (self partialDerivativeOf: anInput)].

	self sum: dInput toPartialDerivativeOf: anOperation
]

{ #category : 'Computing',
  #vaVisibility : 'private' }
AutoDiffForwardMode >> sum: aValue toPartialDerivativeOf: aVariable [

	| dInput |

	dInput :=
		(partialDerivatives includesKey: aVariable)
			ifTrue: [TFSum of: aValue plus: (self partialDerivativeOf: aVariable)]
			ifFalse: [aValue].

	partialDerivatives at: aVariable put: dInput
]
