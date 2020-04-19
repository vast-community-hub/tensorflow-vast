Class {
	#name : 'TFReluGradientTest',
	#superclass : 'TensorFlowComputationBasedTest',
	#category : 'TFOperationGradientModelTests'
}

{ #category : 'Test' }
TFReluGradientTest >> testValue [

	| backprop input relu |

	backprop := tf variableNamed: 'backprop' with: #(10 5) asFloatTensor.
	input := tf variableNamed: 'input' with: #(3 1) asFloatTensor.

	relu := TFReluGradient considering: backprop andGradientsOfInputs: input.

	self assertOutputOf: relu isFloatVectorCloseTo: #(10.0 5.0)
]
