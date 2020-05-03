Class {
	#name : 'TFTanhGradientTest',
	#superclass : 'TensorFlowComputationBasedTest',
	#category : 'TFOperationGradientModelTests'
}

{ #category : 'Test' }
TFTanhGradientTest >> testFromTensorflow [
	
	"\tensorflow\compiler\tests\binary_ops_test.py"
	
	| dy y grad |

	y := tf variableNamed: 'y' with: #(4 3 2 1) asFloatTensor.
	dy := tf variableNamed: 'dy' with: #(5 6 7 8) asFloatTensor.

	grad := TFTanhGradient considering: y andGradientsOfInputs: dy.

	self assertOutputOf: grad isFloatVectorCloseTo: #(-75 -48 -21 0)
]

{ #category : 'Test' }
TFTanhGradientTest >> testValue [

	| dy y grad |

	y := tf variableNamed: 'y' with: 4.0 asTensor.
	dy := tf variableNamed: 'dy' with: 3.0 asTensor.

	grad := TFTanhGradient considering: y andGradientsOfInputs: dy.

	self assertOutputOf: grad isFloatScalarCloseTo: 3 * (1 - (4 * 4))
]
