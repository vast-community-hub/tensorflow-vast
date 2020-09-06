Class {
	#name : 'ElementWiseNegativeTest',
	#superclass : 'TensorFlowComputationBasedTest',
	#category : 'TFOperationModelTests'
}

{ #category : 'Tests' }
ElementWiseNegativeTest >> testFloatScalarNegative [

	| x |

	x := tf constantWith: 3.0.
	
	self assertOutputOf: x negated isFloatScalarCloseTo: -3
]

{ #category : 'Tests' }
ElementWiseNegativeTest >> testFloatVectorNegative [

	| x |

	x := tf floatConstantWith: #(3 -1.5).

	self assertOutputOf: x negated isFloatVectorCloseTo: #(-3 1.5)
]

{ #category : 'Tests' }
ElementWiseNegativeTest >> testIntegerScalarNegative [

	| x |

	x := tf integerConstantWith: 3.

	self assertOutputOf: x negated isIntegerScalarEqualTo: -3
]

{ #category : 'Tests' }
ElementWiseNegativeTest >> testOperationName [

	| x |

	x := tf constantWith: 3.0.

	self assert: (ElementWiseNegative of: x) isNamedInGraphAs: 'Neg'.
	self assert: (ElementWiseNegative of: x) isNamedInGraphAs: 'Neg_1'.
	self assert: (ElementWiseNegative named: 'output' of: x) isNamedInGraphAs: 'output'.
	self assert: (ElementWiseNegative named: 'output' of: x) isNamedInGraphAs: 'output_1'
]

{ #category : 'Tests' }
ElementWiseNegativeTest >> testPrintString [

	| x |

	x := tf constantWith: 3.0.

	self assert: (ElementWiseNegative of: x) printString equals: '(- Const)'
]
