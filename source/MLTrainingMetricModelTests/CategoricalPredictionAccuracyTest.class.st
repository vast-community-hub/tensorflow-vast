Class {
	#name : 'CategoricalPredictionAccuracyTest',
	#superclass : 'TensorFlowComputationBasedTest',
	#category : 'MLTrainingMetricModelTests'
}

{ #category : 'Test' }
CategoricalPredictionAccuracyTest >> testAccuracyBetweenTwo32BitIntegerTensor [

	| x y accuracy |

	x := tf constantWith: #(1 2 3 4) asInt32Tensor.
	y := tf constantWith: #(0 2 3 4) asInt32Tensor.

	accuracy := CategoricalPredictionAccuracy of: x whenExpectedIs: y.

	self assertOutputOf: accuracy isFloatScalarCloseTo: ((0 + 1 + 1 + 1)) / 4
]

{ #category : 'Test' }
CategoricalPredictionAccuracyTest >> testAccuracyBetweenTwoDifferentBitIntegerTensor [

	| x y accuracy |

	x := tf constantWith: #((0 1 0 0 0) (0 0 1 0 0) (0 0 0 1 0) (0 0 0 0 1)) asInt32Tensor.
	y := tf constantWith: #(0 2 3 4) asInt32Tensor.

	accuracy := CategoricalPredictionAccuracy of: x argMaxOnRows whenExpectedIs: y.

	self assertOutputOf: accuracy isFloatScalarCloseTo: ((0 + 1 + 1 + 1)) / 4
]
