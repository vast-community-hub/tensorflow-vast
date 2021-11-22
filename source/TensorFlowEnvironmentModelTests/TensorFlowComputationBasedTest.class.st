Class {
	#name : 'TensorFlowComputationBasedTest',
	#superclass : 'TestCase',
	#instVars : [
		'tf',
		'errorTolerance'
	],
	#category : 'TensorFlowEnvironmentModelTests'
}

{ #category : 'Not categorized' }
TensorFlowComputationBasedTest class >> isAbstract [

	^self = TensorFlowComputationBasedTest 
]

{ #category : 'Test Support',
  #vaVisibility : 'private' }
TensorFlowComputationBasedTest >> assert: aNumber closeTo: anExpectedNumber [

	^self
		assert: (aNumber - anExpectedNumber) abs < errorTolerance
		description:
			aNumber printString , ' was expected to be close to ' , anExpectedNumber printString
]

{ #category : 'Asserting',
  #vaVisibility : 'private' }
TensorFlowComputationBasedTest >> assert: anOperationCollection hasTheSameOperationsAs: anotherOperations [

	self assert: anOperationCollection size equals: anotherOperations size.
	anOperationCollection
		with: anotherOperations
		do: [:anOperation :anotherOperation |
			self assert: anOperation value equals: anotherOperation value]
]

{ #category : 'Asserting',
  #vaVisibility : 'private' }
TensorFlowComputationBasedTest >> assert: aNumberArray isArrayCloseTo: anExpectedArray [

	aNumberArray size = anExpectedArray size ifFalse: [self fail: 'Sizes don''t match'].
	aNumberArray
		with: anExpectedArray
		do: [:number :expected | self assert: number closeTo: expected]
]

{ #category : 'Test Support',
  #vaVisibility : 'private' }
TensorFlowComputationBasedTest >> assert: anOutput isFloatScalarCloseTo: aScalar [

	self
		assert: anOutput
		isOf: FloatDataType new
		with: TensorShape scalar
		comparedTo: (Array with: aScalar)
		complying: [:actual :expected | self assert: actual closeTo: expected]
]

{ #category : 'Test Support',
  #vaVisibility : 'private' }
TensorFlowComputationBasedTest >> assert: anOutput isFloatVectorCloseTo: anExpectedArray [

	self assert: anOutput isVectorTyped: FloatDataType new closeTo: anExpectedArray
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
		isOf: Int32DataType new
		with: (TensorShape matrixSized: aFloatMatrix size by: columns)
		comparedTo: rows
		complying: [:actual :expected | self assert: actual closeTo: expected]
]

{ #category : 'Test Support',
  #vaVisibility : 'private' }
TensorFlowComputationBasedTest >> assert: anOutput isIntegerScalarEqualTo: aScalar [

	self
		assert: anOutput
		isOf: Int32DataType new
		with: TensorShape scalar
		comparedTo: (Array with: aScalar)
		complying: [:actual :expected | self assert: actual equals: expected]
]

{ #category : 'Test Support',
  #vaVisibility : 'private' }
TensorFlowComputationBasedTest >> assert: anOutput isIntegerVectorEqualsTo: anExpectedArray [

	self
		assert: anOutput
		isOf: Int32DataType new
		with: (TensorShape vectorSized: anExpectedArray size)
		comparedTo: anExpectedArray
		complying: [:actual :expected | self assert: actual equals: expected]
]

{ #category : 'Test Support',
  #vaVisibility : 'private' }
TensorFlowComputationBasedTest >> assert: anOutput isLargeIntegerScalarEqualsTo: anInteger [

	self
		assert: anOutput
		isOf: Int64DataType new
		with: TensorShape scalar
		comparedTo: (Array with: anInteger)
		complying: [:actual :expected | self assert: actual equals: expected]
]

{ #category : 'Test Support',
  #vaVisibility : 'private' }
TensorFlowComputationBasedTest >> assert: anOutput isLargeIntegerVectorEqualsTo: anExpectedArray [

	self
		assert: anOutput
		isOf: Int64DataType new
		with: (TensorShape vectorSized: anExpectedArray size)
		comparedTo: anExpectedArray
		complying: [:actual :expected | self assert: actual equals: expected]
]

{ #category : 'Test Support',
  #vaVisibility : 'private' }
TensorFlowComputationBasedTest >> assert: anOutput isMatrixCloseTo: anExpectedMatrix [

	self assert: anOutput isMatrixTyped: FloatDataType new closeTo: anExpectedMatrix
]

{ #category : 'Test Support',
  #vaVisibility : 'private' }
TensorFlowComputationBasedTest >> assert: anOutput isMatrixTyped: aType closeTo: anExpectedMatrix [

	| columns rows |

	anExpectedMatrix first isCollection
		ifTrue: [
			columns := anExpectedMatrix first size.
			rows := anExpectedMatrix flatCollect: #yourself as: OrderedCollection]
		ifFalse: [
			columns := 1.
			rows := anExpectedMatrix].

	self
		assert: anOutput
		isOf: aType
		with: (TensorShape matrixSized: anExpectedMatrix size by: columns)
		comparedTo: rows
		complying: [:actual :expected | self assert: actual closeTo: expected]
]

{ #category : 'Test Support',
  #vaVisibility : 'private' }
TensorFlowComputationBasedTest >> assert: anOperation isNamedInGraphAs: aName [

	tf
		withOperationNamed: aName
		do: [:op | self assert: op equals: anOperation value]
		ifNone: [self fail: ('No operation named %1 found in graph' bindWith: aName)].

	self assert: anOperation operationName equals: aName
]

{ #category : 'Test Support',
  #vaVisibility : 'private' }
TensorFlowComputationBasedTest >> assert: anOutput isOf: aType with: aShape comparedTo: anExpectedArray complying: aBlock [

	self assert: anOutput type equals: aType.
	self assert: anOutput shape equals: aShape.
	anOutput allElements with: anExpectedArray do: aBlock
]

{ #category : 'Asserting',
  #vaVisibility : 'private' }
TensorFlowComputationBasedTest >> assert: anOutput isVectorTyped: aType closeTo: anExpectedArray [

	self
		assert: anOutput
		isOf: aType
		with: (TensorShape vectorSized: anExpectedArray size)
		comparedTo: anExpectedArray
		complying: [:actual :expected | self assert: actual closeTo: expected]
]

{ #category : 'Test Support',
  #vaVisibility : 'private' }
TensorFlowComputationBasedTest >> assert: aBlock raisesExceptionWith: aDescription [

	self should: aBlock raise: Error withDescription: (aDescription copyWithout: Character cr)
]

{ #category : 'Test Support',
  #vaVisibility : 'private' }
TensorFlowComputationBasedTest >> assertOutputOf: anOperation isAStringEqualTo: aString [

	| output |

	output := tf compute: anOperation.
	self assert: output type equals: StringDataType new.
	self assert: output shape equals: TensorShape scalar.
	self assert: output allStrings any equals: aString
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

	self assert: anOperation compute isIntegerMatrixCloseTo: aFloatMatrix
]

{ #category : 'Test Support',
  #vaVisibility : 'private' }
TensorFlowComputationBasedTest >> assertOutputOf: anOperation isIntegerScalarEqualTo: aScalar [

	self assert: anOperation compute isIntegerScalarEqualTo: aScalar
]

{ #category : 'Test Support',
  #vaVisibility : 'private' }
TensorFlowComputationBasedTest >> assertOutputOf: anOperation isIntegerVectorEqualsTo: anExpectedArray [

	self assert: anOperation compute isIntegerVectorEqualsTo: anExpectedArray
]

{ #category : 'Test Support',
  #vaVisibility : 'private' }
TensorFlowComputationBasedTest >> assertOutputOf: anOperation isLargeIntegerVectorEqualsTo: anExpectedArray [

	self assert: anOperation compute isLargeIntegerVectorEqualsTo: anExpectedArray
]

{ #category : 'Test Support',
  #vaVisibility : 'private' }
TensorFlowComputationBasedTest >> assertOutputOf: anOperation isMatrixCloseTo: aFloatMatrix [

	self assert: (tf compute: anOperation) isMatrixCloseTo: aFloatMatrix
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
TensorFlowComputationBasedTest >> setUp [

	tf := TensorFlowComputation new. 
	
	self tolerateErrorsLowerThan: 0.00001
]

{ #category : 'Test Support',
  #vaVisibility : 'private' }
TensorFlowComputationBasedTest >> tolerateErrorsLowerThan: aMaximumAbsoluteError [

	errorTolerance := aMaximumAbsoluteError
]
