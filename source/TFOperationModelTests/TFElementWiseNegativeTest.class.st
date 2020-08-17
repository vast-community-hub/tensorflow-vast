Class {
	#name : 'TFElementWiseNegativeTest',
	#superclass : 'TensorFlowComputationBasedTest',
	#category : 'TFOperationModelTests'
}

{ #category : 'Tests' }
TFElementWiseNegativeTest >> testFloatScalarNegative [

	| x |

	x := tf constantWith: 3.0.
	
	self assertOutputOf: x negated isFloatScalarCloseTo: -3
]

{ #category : 'Tests' }
TFElementWiseNegativeTest >> testFloatVectorNegative [

	| x |

	x := tf floatConstantWith: #(3 -1.5).

	self assertOutputOf: x negated isFloatVectorCloseTo: #(-3 1.5)
]

{ #category : 'Tests' }
TFElementWiseNegativeTest >> testIntegerScalarNegative [

	| x |

	x := tf integerConstantWith: 3.

	self assertOutputOf: x negated isIntegerScalarEqualTo: -3
]

{ #category : 'Tests' }
TFElementWiseNegativeTest >> testOperationName [

	| x |

	x := tf constantWith: 3.0.

	self assert: (TFElementWiseNegative negativeOf: x) isNamedInGraphAs: 'Neg'.
	self assert: (TFElementWiseNegative negativeOf: x) isNamedInGraphAs: 'Neg_1'.
	self assert: (TFElementWiseNegative named: 'output' negativeOf: x) isNamedInGraphAs: 'output'.
	self assert: (TFElementWiseNegative named: 'output' negativeOf: x) isNamedInGraphAs: 'output_1'
]

{ #category : 'Tests' }
TFElementWiseNegativeTest >> testPrintString [

	| x |

	x := tf constantWith: 3.0.

	self assert: (TFElementWiseNegative negativeOf: x) printString equals: '(- Const)'
]
