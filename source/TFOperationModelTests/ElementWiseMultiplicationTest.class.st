Class {
	#name : 'ElementWiseMultiplicationTest',
	#superclass : 'TensorFlowComputationBasedTest',
	#category : 'TFOperationModelTests'
}

{ #category : 'Test' }
ElementWiseMultiplicationTest >> testFactorsMustHaveSameType [

	| x y |

	x := tf constantWith: 3.0.
	y := tf constantWith: 4.

	self
		assert: [x * y]
		raisesExceptionWith:
			'INVALID_ARGUMENT: Inconsistent values for attr ''T'' DT_FLOAT vs. DT_INT32 while building NodeDef ''Mul'' using Op<name=Mul; signature=x:T, y:T -> z:T; attr=T:type,allowed=[DT_BFLOAT16, DT_HALF, DT_FLOAT, DT_DOUBLE, DT_UINT8, DT_INT8, DT_UINT16, DT_INT16, DT_INT32, DT_INT64, DT_COMPLEX64, DT_COMPLEX128]; is_commutative=true>'
]

{ #category : 'Test' }
ElementWiseMultiplicationTest >> testMultiplyFloatScalars [

	| x y |

	x := tf constantWith: 3.0.
	y := tf constantWith: 4.0.
	
	self assertOutputOf: x * y isFloatScalarCloseTo: 12
]

{ #category : 'Test' }
ElementWiseMultiplicationTest >> testMultiplyFloatVectors [

	| x y |

	x := tf floatConstantWith: #(3 -2).
	y := tf floatConstantWith: #(4 5).
	
	self assertOutputOf: x * y isFloatVectorCloseTo: #(12 -10)
]

{ #category : 'Test' }
ElementWiseMultiplicationTest >> testMultiplyIntegerScalars [

	| x y |

	x := tf integerConstantWith: 3.
	y := tf integerConstantWith: 4.
	
	self assertOutputOf: x * y isIntegerScalarEqualTo: 12
]

{ #category : 'Test' }
ElementWiseMultiplicationTest >> testMultiplyIntegerVectors [

	| x y |

	x := tf integerConstantWith: #(3 -2).
	y := tf integerConstantWith: #(4 5).

	self assertOutputOf: x * y isIntegerVectorEqualsTo: #(12 -10)
]

{ #category : 'Test' }
ElementWiseMultiplicationTest >> testMultiplyMatrixByMatrix [

	| x y |

	x := tf floatConstantWith: #((3 -4) (2 5)).
	y := tf floatConstantWith: #((0.3 2) (-10 9)).

	self assertOutputOf: x * y isMatrixCloseTo: #((0.9 -8) (-20 45))
]

{ #category : 'Test' }
ElementWiseMultiplicationTest >> testMultiplyMatrixByVector [

	| x y |

	x := tf floatConstantWith: #((-1 2) (-4 7)).
	y := tf floatConstantWith: #(3 4).

	self assertOutputOf: x * y isMatrixCloseTo: #((-3 8) (-12 28))
]

{ #category : 'Test' }
ElementWiseMultiplicationTest >> testMultiplyScalarByVector [

	| x y |

	x := tf integerConstantWith: 4.
	y := tf integerConstantWith: #(3 4).

	self assertOutputOf: x * y isIntegerVectorEqualsTo: #(12 16)
]

{ #category : 'Test' }
ElementWiseMultiplicationTest >> testMultiplyVectorByMatrix [

	| x y |

	x := tf floatConstantWith: #(3 4).
	y := tf floatConstantWith: #((-1 2) (-4 7)).

	self assertOutputOf: x * y isMatrixCloseTo: #((-3 8) (-12 28))
]

{ #category : 'Test' }
ElementWiseMultiplicationTest >> testMultiplyVectorByScalar [

	| x y |

	x := tf integerConstantWith: #(3 4).
	y := tf integerConstantWith: 4.

	self assertOutputOf: x * y isIntegerVectorEqualsTo: #(12 16)
]

{ #category : 'Test' }
ElementWiseMultiplicationTest >> testOperationName [

	| x |

	x := tf integerConstantWith: #(3 4).

	self assert: (ElementWiseMultiplication of: x and: 2 asTensor) isNamedInGraphAs: 'Mul'.
	self assert: (ElementWiseMultiplication of: x and: 2 asTensor) isNamedInGraphAs: 'Mul_1'.
	self
		assert: (ElementWiseMultiplication named: 'output' of: x and: 2 asTensor)
		isNamedInGraphAs: 'output'.
	self
		assert: (ElementWiseMultiplication named: 'output' of: x and: 2 asTensor)
		isNamedInGraphAs: 'output_1'
]

{ #category : 'Test' }
ElementWiseMultiplicationTest >> testPrintString [

	| x |

	x := tf integerConstantWith: #(3 4).

	self
		assert: (ElementWiseMultiplication of: x and: #(2 1) asInt32Tensor) printString
		equals: '(Const x Int32 vector size 2)'.
	self
		assert: (ElementWiseMultiplication of: x and: #((2)) asInt32Tensor) printString
		equals: '(Const x Int32 1x1 matrix)'
]
