Class {
	#name : 'TensorFlowComputationBasedTest',
	#superclass : 'TestCase',
	#instVars : [
		'tf'
	],
	#category : 'TensorFlowEnvironmentModelTests'
}

{ #category : 'Not categorized' }
TensorFlowComputationBasedTest class >> isAbstract [

	^self = TensorFlowComputationBasedTest 
]

{ #category : 'Test Support',
  #vaVisibility : 'private' }
TensorFlowComputationBasedTest >> assert: aNumber closeTo: anotherNumber [

	^self
		assert: (aNumber - anotherNumber) abs < self tolerance
		description:
			anotherNumber printString , ' was expected to be close to ' , aNumber printString
]

{ #category : 'Test Support',
  #vaVisibility : 'private' }
TensorFlowComputationBasedTest >> assert: aTFTensor hasFloatsCloseTo: anExpectedArray [

	aTFTensor allFloats with: anExpectedArray do: [:r :t | self assert: r closeTo: t]
]

{ #category : 'Test Support',
  #vaVisibility : 'private' }
TensorFlowComputationBasedTest >> assert: anOutput isFloatScalarCloseTo: aScalar [

	self assert: anOutput shape equals: #().
	self assert: anOutput type equals: TFTensor typeFloat.
	self assert: (anOutput allElements first closeTo: aScalar)
]

{ #category : 'Test Support',
  #vaVisibility : 'private' }
TensorFlowComputationBasedTest >> assert: anOutput isFloatVectorCloseTo: anExpectedArray [

	self assert: anOutput type equals: TFTensor typeFloat.
	self assert: anOutput shape equals: (Array with: anExpectedArray size).
	self assert: anOutput hasFloatsCloseTo: anExpectedArray
]

{ #category : 'Test Support',
  #vaVisibility : 'private' }
TensorFlowComputationBasedTest >> assert: anOutput isMatrixCloseTo: aFloatMatrix [

	| columns rows |

	aFloatMatrix first isCollection
		ifTrue: [
			columns := aFloatMatrix first size.
			rows := aFloatMatrix flatCollect: #yourself as: OrderedCollection]
		ifFalse: [
			columns := 1.
			rows := aFloatMatrix].
	self assert: anOutput shape equals: (Array with: aFloatMatrix size with: columns).
	self assert: anOutput hasFloatsCloseTo: rows
]

{ #category : 'Test Support',
  #vaVisibility : 'private' }
TensorFlowComputationBasedTest >> assert: aBlock raisesExceptionWith: aDescription [

	self should: aBlock raise: Error withDescription: (aDescription copyWithout: Character cr)
]

{ #category : 'Test Support',
  #vaVisibility : 'private' }
TensorFlowComputationBasedTest >> assertOutputOf: aTFOperation isFloatScalarCloseTo: aScalar [

	self assert: (tf compute: aTFOperation) isFloatScalarCloseTo: aScalar
]

{ #category : 'Test Support',
  #vaVisibility : 'private' }
TensorFlowComputationBasedTest >> assertOutputOf: anOperation isFloatVectorCloseTo: anExpectedArray [

	| output |

	output := tf compute: anOperation.
	
	self assert: output isFloatVectorCloseTo: anExpectedArray
]

{ #category : 'Test Support',
  #vaVisibility : 'private' }
TensorFlowComputationBasedTest >> assertOutputOf: aTFOperation isIntegerScalarEqualTo: aScalar [

	| output |

	output := tf compute: aTFOperation.
	self assert: output shape equals: #().
	self assert: output type equals: TFTensor typeInt32.
	self assert: output allElements first equals: aScalar
]

{ #category : 'Test Support',
  #vaVisibility : 'private' }
TensorFlowComputationBasedTest >> assertOutputOf: anOperation isIntegerVectorEqualsTo: anExpectedArray [

	| output |

	output := tf compute: anOperation.
	self assert: output type equals: TFTensor typeInt32.
	self assert: output shape equals: (Array with: anExpectedArray size).
	output allInt64s with: anExpectedArray do: [:r :t | self assert: r equals: t]
]

{ #category : 'Test Support',
  #vaVisibility : 'private' }
TensorFlowComputationBasedTest >> assertOutputOf: anOperation isLargeIntegerVectorEqualsTo: anExpectedArray [

	| output |

	output := tf compute: anOperation.
	self assert: output type equals: TFTensor typeInt64.
	self assert: output shape equals: (Array with: anExpectedArray size).
	output allInt64s with: anExpectedArray do: [:r :t | self assert: r equals: t]
]

{ #category : 'Test Support',
  #vaVisibility : 'private' }
TensorFlowComputationBasedTest >> assertOutputOf: anOperation isMatrixCloseTo: aFloatMatrix [

	| output |

	output := tf compute: anOperation.
	
	self assert: output isMatrixCloseTo: aFloatMatrix
]

{ #category : 'Test Support',
  #vaVisibility : 'private' }
TensorFlowComputationBasedTest >> executeShould: aBlock inScopeOf: anException withSignalDo: anotherBlock [

	^[
		aBlock value.
		false]
			sunitOn: anException
			do: [:aSignal |
				anotherBlock value: aSignal.
				aSignal sunitExitWith: true]
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
TensorFlowComputationBasedTest >> setUp [

	tf := TensorFlowComputation new
]

{ #category : 'Test Support',
  #vaVisibility : 'private' }
TensorFlowComputationBasedTest >> should: aBlock raise: anException withDescription: aString [

	self
		should: aBlock
		raise: anException
		withSignalDo: [:exception | self assert: exception messageText equals: aString]
]

{ #category : 'Test Support',
  #vaVisibility : 'private' }
TensorFlowComputationBasedTest >> should: aBlock raise: anException withSignalDo: anotherBlock [

	^self
		assert: (self executeShould: aBlock inScopeOf: anException withSignalDo: anotherBlock)
		description: ('Expected exception (%1) wasn''t raised' bindWith: anException)
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TensorFlowComputationBasedTest >> tolerance [

	^0.00001
]
