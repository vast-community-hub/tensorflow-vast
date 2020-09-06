Class {
	#name : 'ExponentiationTest',
	#superclass : 'TensorFlowComputationBasedTest',
	#category : 'TFOperationModelTests'
}

{ #category : 'Tests' }
ExponentiationTest >> testMatrixRaisedToScalar [

	| base |

	base := tf floatConstantWith: #((3 5) (2 4)).

	self assertOutputOf: (base raisedTo: 2.0) isMatrixCloseTo: #((9 25) (4 16))
]

{ #category : 'Tests' }
ExponentiationTest >> testMatrixRaisedToVector [

	| base |

	base := tf floatConstantWith: #((3 5) (2 4)).

	self
		assertOutputOf: (base raisedTo: #(2 -1) asFloatTensor)
		isMatrixCloseTo: #((9 0.2) (4 0.25))
]

{ #category : 'Tests' }
ExponentiationTest >> testOperationName [

	| base |

	base := tf floatConstantWith: #(3 5).

	self assert: (base raisedTo: 2.0) isNamedInGraphAs: 'Pow'.
	self assert: (base raisedTo: 2.0) isNamedInGraphAs: 'Pow_1'.
	self assert: (Exponentiation named: 'value' of: base raisedTo: 2.0) isNamedInGraphAs: 'value'.
	self assert: (Exponentiation named: 'value' of: base raisedTo: 2.0) isNamedInGraphAs: 'value_1'
]

{ #category : 'Tests' }
ExponentiationTest >> testPrintString [

	| base |

	base := tf floatConstantWith: #(3 5).

	self assert: (base raisedTo: 2.0) printString equals: 'Const^2.0'.
	self assert: (base raisedTo: 2.0 asTensor) printString equals: 'Const^Float scalar'
]

{ #category : 'Tests' }
ExponentiationTest >> testScalarRaisedToMatrix [

	| base |

	base := tf floatConstantWith: 4.

	self
		assertOutputOf: (base raisedTo: #((2 3) (-1 -2)) asFloatTensor)
		isMatrixCloseTo: #((16 64) (0.25 0.0625))
]

{ #category : 'Tests' }
ExponentiationTest >> testScalarRaisedToScalar [

	| base |

	base := tf floatConstantWith: 3.

	self assertOutputOf: (base raisedTo: 2.0) isFloatScalarCloseTo: 9
]

{ #category : 'Tests' }
ExponentiationTest >> testScalarRaisedToVector [

	| base |

	base := tf floatConstantWith: 3.

	self assertOutputOf: (base raisedTo: #(2 3) asFloatTensor) isFloatVectorCloseTo: #(9 27)
]

{ #category : 'Tests' }
ExponentiationTest >> testVectorRaisedToScalar [

	| base |

	base := tf floatConstantWith: #(3 5).

	self assertOutputOf: (base raisedTo: 2.0) isFloatVectorCloseTo: #(9 25)
]

{ #category : 'Tests' }
ExponentiationTest >> testVectorRaisedToVector [

	| base |

	base := tf floatConstantWith: #(3 5).

	self assertOutputOf: (base raisedTo: #(2 -1) asFloatTensor) isFloatVectorCloseTo: #(9 0.2)
]
