Class {
	#name : 'TFElementWiseNegativeTest',
	#superclass : 'TensorFlowComputationBasedTest',
	#category : 'TFOperationModelTests'
}

{ #category : 'Tests' }
TFElementWiseNegativeTest >> testFloatScalarNegative [

	| x y |

	x := tf constantWith: 3.0.

	y := TFElementWiseNegative negativeOf: x.

	self assertOutputOf: y isFloatScalarCloseTo: -3
]

{ #category : 'Tests' }
TFElementWiseNegativeTest >> testFloatVectorNegative [

	| x y |

	x := tf floatConstantWith: #(3 -1.5).

	y := TFElementWiseNegative negativeOf: x.

	self assertOutputOf: y isFloatVectorCloseTo: #(-3 1.5)
]

{ #category : 'Tests' }
TFElementWiseNegativeTest >> testIntegerScalarNegative [

	| x y |

	x := tf integerConstantWith: 3.

	y := TFElementWiseNegative negativeOf: x.

	self assertOutputOf: y isIntegerScalarEqualTo: -3
]
