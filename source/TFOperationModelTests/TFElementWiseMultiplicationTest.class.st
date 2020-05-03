Class {
	#name : 'TFElementWiseMultiplicationTest',
	#superclass : 'TensorFlowComputationBasedTest',
	#category : 'TFOperationModelTests'
}

{ #category : 'Test' }
TFElementWiseMultiplicationTest >> testFactorsMustHaveSameType [

	| x y |

	x := tf constantWith: 3.0.
	y := tf constantWith: 4.

	self
		assert: [TFElementWiseMultiplication of: x and: y]
		raisesExceptionWith:
			'INVALID_ARGUMENT: Inconsistent values for attr ''T'' DT_FLOAT vs. DT_INT32 while building NodeDef ''Mul'' using Op<name=Mul; signature=x:T, y:T -> z:T; attr=T:type,allowed=[DT_BFLOAT16, DT_HALF, DT_FLOAT, DT_DOUBLE, DT_UINT8, DT_INT8, DT_UINT16, DT_INT16, DT_INT32, DT_INT64, DT_COMPLEX64, DT_COMPLEX128]; is_commutative=true>'
]

{ #category : 'Test' }
TFElementWiseMultiplicationTest >> testMultiplyFloatScalars [

	| x y z |

	x := tf constantWith: 3.0.
	y := tf constantWith: 4.0.

	z := TFElementWiseMultiplication of: x and: y.

	self assertOutputOf: z isFloatScalarCloseTo: 12
]

{ #category : 'Test' }
TFElementWiseMultiplicationTest >> testMultiplyFloatVectors [

	| x y z |

	x := tf floatConstantWith: #(3 -2).
	y := tf floatConstantWith: #(4 5).

	z := TFElementWiseMultiplication of: x and: y.

	self assertOutputOf: z isFloatVectorCloseTo: #(12 -10)
]

{ #category : 'Test' }
TFElementWiseMultiplicationTest >> testMultiplyIntegerScalars [
	
	| x y z |
	
	x := tf integerConstantWith: 3. 
	y := tf integerConstantWith: 4. 
	
	z := TFElementWiseMultiplication of: x and: y. 
	
	self assertOutputOf: z isIntegerScalarEqualTo: 12
]

{ #category : 'Test' }
TFElementWiseMultiplicationTest >> testMultiplyIntegerVectors [

	| x y z |

	x := tf integerConstantWith: #(3 -2).
	y := tf integerConstantWith: #(4 5).

	z := TFElementWiseMultiplication of: x and: y.

	self assertOutputOf: z isIntegerVectorEqualsTo: #(12 -10)
]

{ #category : 'Test' }
TFElementWiseMultiplicationTest >> testMultiplyMatrixByMatrix [

	| x y |

	x := tf floatConstantWith: #((3 -4) (2 5)).
	y := tf floatConstantWith: #((0.3 2) (-10 9)).

	self
		assertOutputOf: (TFElementWiseMultiplication of: x and: y)
		isMatrixCloseTo: #((0.9 -8) (-20 45))
]

{ #category : 'Test' }
TFElementWiseMultiplicationTest >> testMultiplyMatrixByVector [

	| x y |

	x := tf floatConstantWith: #((-1 2) (-4 7)).
	y := tf floatConstantWith: #(3 4).

	self
		assertOutputOf: (TFElementWiseMultiplication of: x and: y)
		isMatrixCloseTo: #((-3 8) (-12 28))
]

{ #category : 'Test' }
TFElementWiseMultiplicationTest >> testMultiplyScalarByVector [

	| x y |

	x := tf integerConstantWith: 4.
	y := tf integerConstantWith: #(3 4).

	self
		assertOutputOf: (TFElementWiseMultiplication of: x and: y)
		isIntegerVectorEqualsTo: #(12 16)
]

{ #category : 'Test' }
TFElementWiseMultiplicationTest >> testMultiplyVectorByMatrix [

	| x y |

	x := tf floatConstantWith: #(3 4).
	y := tf floatConstantWith: #((-1 2) (-4 7)).

	self
		assertOutputOf: (TFElementWiseMultiplication of: x and: y)
		isMatrixCloseTo: #((-3 8) (-12 28))
]

{ #category : 'Test' }
TFElementWiseMultiplicationTest >> testMultiplyVectorByScalar [

	| x y |

	x := tf integerConstantWith: #(3 4).
	y := tf integerConstantWith: 4.

	self
		assertOutputOf: (TFElementWiseMultiplication of: x and: y)
		isIntegerVectorEqualsTo: #(12 16)
]
