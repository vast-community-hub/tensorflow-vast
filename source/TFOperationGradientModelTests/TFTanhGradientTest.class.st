Class {
	#name : 'TFTanhGradientTest',
	#superclass : 'TensorFlowComputationBasedTest',
	#category : 'TFOperationGradientModelTests'
}

{ #category : 'Test' }
TFTanhGradientTest >> testValue [

	| dy y grad |

	y := tf variableNamed: 'y' with: 4.0 asTensor.
	dy := tf variableNamed: 'dy' with: 3.0 asTensor.

	grad := TFTanhGradient considering: y andGradientsOfInputs: dy.

	self assertOutputOf: grad isFloatScalarCloseTo: 3 * (1 - (4 * 4))
]
