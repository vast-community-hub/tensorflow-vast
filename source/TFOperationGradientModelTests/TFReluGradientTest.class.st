Class {
	#name : 'TFReluGradientTest',
	#superclass : 'TensorFlowComputationBasedTest',
	#category : 'TFOperationGradientModelTests'
}

{ #category : 'Test' }
TFReluGradientTest >> testFromTensorflow [

	"\tensorflow\compiler\tests\binary_ops_test.py"

	| y dy relu |

	y := tf variableNamed: 'backprop' with: #(1 2 3 4 5 6 7 8 9 10) asFloatTensor.
	dy := tf variableNamed: 'inputGrad' with: #(0 0 0 0 0 0.1 0.3 0.5 0.7 0.9) asFloatTensor.

	relu := TFReluGradient considering: y andGradientsOfInputs: dy.

	self assertOutputOf: relu isFloatVectorCloseTo: #(0 0 0 0 0 6 7 8 9 10)
]

{ #category : 'Test' }
TFReluGradientTest >> testValue [

	| backprop input relu |

	backprop := tf variableNamed: 'backprop' with: #(10 5) asFloatTensor.
	input := tf variableNamed: 'input' with: #(3 1) asFloatTensor.

	relu := TFReluGradient considering: backprop andGradientsOfInputs: input.

	self assertOutputOf: relu isFloatVectorCloseTo: #(10.0 5.0)
]
