Class {
	#name : 'CategoricalPredictionAccuracyTest',
	#superclass : 'TensorFlowComputationBasedTest',
	#category : 'NeuralNetworkTrainingMetricModelTests'
}

{ #category : 'Test' }
CategoricalPredictionAccuracyTest >> testAccuracyBetweenTwo32BitIntegerTensor [

	| x y accuracy |

	x := tf constantWith: #(1 2 3 4) asInt32Tensor.
	y := tf constantWith: #(0 2 3 4) asInt32Tensor.

	accuracy := CategoricalPredictionAccuracy of: x whenExpectedIs: y.

	self assertOutputOf: accuracy isFloatScalarCloseTo: 1
]

{ #category : 'Test' }
CategoricalPredictionAccuracyTest >> testAccuracyBetweenTwoFloatTensors [

	| prediction real accuracy |

	prediction := tf constantWith: #((0.1 0.9 0.8) (0.05 0.95 0)) asFloatTensor.
	real := tf constantWith: #((0 0 1) (0 1 0)) asFloatTensor.

	accuracy := CategoricalPredictionAccuracy of: prediction whenExpectedIs: real.

	self assertOutputOf: accuracy isFloatScalarCloseTo: 0.5
]
