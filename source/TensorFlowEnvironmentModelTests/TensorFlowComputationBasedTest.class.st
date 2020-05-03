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
TensorFlowComputationBasedTest >> assert: anOutput isFloatScalarCloseTo: aScalar [

	self
		assert: anOutput
		isOf: TFTensor typeFloat
		with: #()
		comparedTo: (Array with: aScalar)
		complying: [:actual :expected | self assert: actual closeTo: expected]
]

{ #category : 'Test Support',
  #vaVisibility : 'private' }
TensorFlowComputationBasedTest >> assert: anOutput isFloatVectorCloseTo: anExpectedArray [

	self
		assert: anOutput
		isOf: TFTensor typeFloat
		with: (Array with: anExpectedArray size)
		comparedTo: anExpectedArray
		complying: [:actual :expected | self assert: actual closeTo: expected]
]

{ #category : 'Test Support',
  #vaVisibility : 'private' }
TensorFlowComputationBasedTest >> assert: anOutput isIntegerMatrixCloseTo: aFloatMatrix [

	| columns rows |

	aFloatMatrix first isCollection
		ifTrue: [
			columns := aFloatMatrix first size.
			rows := aFloatMatrix flatCollect: #yourself as: OrderedCollection]
		ifFalse: [
			columns := 1.
			rows := aFloatMatrix].

	self
		assert: anOutput
		isOf: TFTensor typeInt32
		with: (Array with: aFloatMatrix size with: columns)
		comparedTo: rows
		complying: [:actual :expected | self assert: actual closeTo: expected]
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

	self
		assert: anOutput
		isOf: TFTensor typeFloat
		with: (Array with: aFloatMatrix size with: columns)
		comparedTo: rows
		complying: [:actual :expected | self assert: actual closeTo: expected]
]

{ #category : 'Test Support',
  #vaVisibility : 'private' }
TensorFlowComputationBasedTest >> assert: anOutput isOf: aType with: aShape comparedTo: anExpectedArray complying: aBlock [

	self assert: anOutput type equals: aType.
	self assert: anOutput shape equals: aShape.
	anOutput allElements with: anExpectedArray do: aBlock
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

	self assert: (tf compute: anOperation) isFloatVectorCloseTo: anExpectedArray
]

{ #category : 'Test Support',
  #vaVisibility : 'private' }
TensorFlowComputationBasedTest >> assertOutputOf: anOperation isIntegerMatrixCloseTo: aFloatMatrix [

	self assert: (tf compute: anOperation) isIntegerMatrixCloseTo: aFloatMatrix
]

{ #category : 'Test Support',
  #vaVisibility : 'private' }
TensorFlowComputationBasedTest >> assertOutputOf: aTFOperation isIntegerScalarEqualTo: aScalar [

	self
		assert: (tf compute: aTFOperation)
		isOf: TFTensor typeInt32
		with: #()
		comparedTo: (Array with: aScalar)
		complying: [:actual :expected | self assert: actual equals: expected]
]

{ #category : 'Test Support',
  #vaVisibility : 'private' }
TensorFlowComputationBasedTest >> assertOutputOf: anOperation isIntegerVectorEqualsTo: anExpectedArray [

	self
		assert: (tf compute: anOperation)
		isOf: TFTensor typeInt32
		with: (Array with: anExpectedArray size)
		comparedTo: anExpectedArray
		complying: [:actual :expected | self assert: actual equals: expected]
]

{ #category : 'Test Support',
  #vaVisibility : 'private' }
TensorFlowComputationBasedTest >> assertOutputOf: anOperation isLargeIntegerVectorEqualsTo: anExpectedArray [

	self
		assert: (tf compute: anOperation)
		isOf: TFTensor typeInt64
		with: (Array with: anExpectedArray size)
		comparedTo: anExpectedArray
		complying: [:actual :expected | self assert: actual equals: expected]
]

{ #category : 'Test Support',
  #vaVisibility : 'private' }
TensorFlowComputationBasedTest >> assertOutputOf: anOperation isMatrixCloseTo: aFloatMatrix [

	self assert: (tf compute: anOperation) isMatrixCloseTo: aFloatMatrix
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
