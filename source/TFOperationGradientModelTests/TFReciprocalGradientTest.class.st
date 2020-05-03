Class {
	#name : 'TFReciprocalGradientTest',
	#superclass : 'TensorFlowComputationBasedTest',
	#category : 'TFOperationGradientModelTests'
}

{ #category : 'Not categorized' }
TFReciprocalGradientTest >> testFromTensorflow [

	"\tensorflow\compiler\tests\binary_ops_test.py"

	| y dy grad |

	y := tf floatConstantWith: #(4 -3 -2 1).
	dy := tf floatConstantWith: #(5 -6 7 -8).

	grad := TFReciprocalGradient considering: y andGradientsOfInputs: dy.

	self assertOutputOf: grad isFloatVectorCloseTo: #(-80 54 -28 8)
]
