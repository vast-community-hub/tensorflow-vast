Class {
	#name : 'TFSigmoidGradientTest',
	#superclass : 'TensorFlowComputationBasedTest',
	#category : 'TFOperationGradientModelTests'
}

{ #category : 'Test' }
TFSigmoidGradientTest >> testFromTensorflow [

	"\tensorflow\compiler\tests\binary_ops_test.py"

	| y dy grad |

	y := tf floatConstantWith: #(4 3 2 1).
	dy := tf floatConstantWith: #(5 6 7 8).

	grad := TFSigmoidGradient considering: y andGradientsOfInputs: dy.

	self assertOutputOf: grad isFloatVectorCloseTo: #(-60 -36 -14 0).

	self
		assertOutputOf: grad
		isFloatVectorCloseTo: (
			OrderedCollection new
				add: 5 * 4 * (1 - 4);
				add: 6 * 3 * (1 - 3);
				add: 7 * 2 * (1 - 2);
				add: 8 * 1 * (1 - 1);
				yourself)
]
