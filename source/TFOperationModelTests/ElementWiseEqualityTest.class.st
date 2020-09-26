Class {
	#name : 'ElementWiseEqualityTest',
	#superclass : 'TensorFlowComputationBasedTest',
	#category : 'TFOperationModelTests'
}

{ #category : 'Asserting',
  #vaVisibility : 'private' }
ElementWiseEqualityTest >> assertOutputOf: anOperation isBooleanMatrixEqualTo: anExpectedMatrix [

	| columns rows |

	anExpectedMatrix first isCollection
		ifTrue: [
			columns := anExpectedMatrix first size.
			rows := anExpectedMatrix flatCollect: #yourself as: OrderedCollection]
		ifFalse: [
			columns := 1.
			rows := anExpectedMatrix].

	self
		assert: (tf compute: anOperation)
		isOf: TFTensor typeBoolean
		with: (Array with: anExpectedMatrix size with: columns)
		comparedTo: rows
		complying: [:actual :expected | self assert: actual equals: expected]
]

{ #category : 'Asserting',
  #vaVisibility : 'private' }
ElementWiseEqualityTest >> assertOutputOf: anOperation isBooleanVectorEqualTo: aVectorOfBooleans [

	self
		assert: (tf compute: anOperation)
		isOf: TFTensor typeBoolean
		with: (Array with: aVectorOfBooleans size)
		comparedTo: aVectorOfBooleans
		complying: [:actual :expected | self assert: actual equals: expected]
]

{ #category : 'Test' }
ElementWiseEqualityTest >> testInputAgainstMatrixVariable [

	| x y equality |

	x := tf floatInputNamed: 'x'.
	y := tf variableNamed: 'y' with: #((2 1.1) (3 3)) asFloatTensor.
	equality := x comparedWith: y.

	self
		assertOutputOf: (
			equality computeWith: (
				Dictionary new
					at: 'x' put: #((2 1.1) (3 3)) asFloatTensor;
					yourself))
		isBooleanMatrixEqualTo: (
			OrderedCollection new
				add: (Array with: true with: true);
				add: (Array with: true with: true);
				yourself)
]

{ #category : 'Test' }
ElementWiseEqualityTest >> testMatrixAgainstMatrix [

	| x y equality |

	x := tf constantWith: #((2 1) (3 3)) asFloatTensor.
	y := tf constantWith: #((2 1.1) (3 3)) asFloatTensor.
	equality := x comparedWith: y.

	self
		assertOutputOf: equality
		isBooleanMatrixEqualTo: (
			OrderedCollection new
				add: (Array with: true with: false);
				add: (Array with: true with: true);
				yourself)
]

{ #category : 'Test' }
ElementWiseEqualityTest >> testMatrixConstantAgainstMatrixVariable [

	| x y equality |

	x := tf constantWith: #((2 1) (3 3)) asFloatTensor.
	y := tf variableNamed: 'y' with: #((2 1.1) (3 3)) asFloatTensor.
	equality := x comparedWith: y.

	self
		assertOutputOf: equality
		isBooleanMatrixEqualTo: (
			OrderedCollection new
				add: (Array with: true with: false);
				add: (Array with: true with: true);
				yourself)
]

{ #category : 'Test' }
ElementWiseEqualityTest >> testVectorAgainstScalar [

	| x y equality |

	x := tf constantWith: #(2 3) asFloatTensor.
	y := tf constantWith: 2 asFloatTensor.
	equality := x comparedWith: y.

	self assertOutputOf: equality isBooleanVectorEqualTo: (Array with: true with: false)
]
