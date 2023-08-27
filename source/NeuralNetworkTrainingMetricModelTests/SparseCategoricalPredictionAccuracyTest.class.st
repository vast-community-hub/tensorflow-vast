Class {
	#name : 'SparseCategoricalPredictionAccuracyTest',
	#superclass : 'TensorFlowComputationBasedTest',
	#category : 'NeuralNetworkTrainingMetricModelTests'
}

{ #category : 'Test' }
SparseCategoricalPredictionAccuracyTest >> testAccuracyBetweenTwo32BitIntegerTensor [

	| x y accuracy |

	x :=
		tf constantWith:
			#((0.7 0.2 0.1) (0.8 0.98 0.9) (0.21 0.2 0.1) (0.49 0.5 0.23)) asFloatTensor.
	y := tf constantWith: #((0) (1) (1) (1)) asFloatTensor.

	accuracy := SparseCategoricalPredictionAccuracy of: x whenExpectedIs: y.

	self assertOutputOf: accuracy isFloatScalarCloseTo: 0.75
]

{ #category : 'Test' }
SparseCategoricalPredictionAccuracyTest >> testAccuracyBetweenTwoFloatTensors [

	| prediction real accuracy |

	prediction := tf constantWith: #((0.1 0.6 0.3) (0.05 0.95 0)) asFloatTensor.
	real := tf constantWith: #((2) (1)) asFloatTensor.

	accuracy := SparseCategoricalPredictionAccuracy of: prediction whenExpectedIs: real.

	self assertOutputOf: accuracy isFloatScalarCloseTo: 0.5
]

{ #category : 'Test' }
SparseCategoricalPredictionAccuracyTest >> testAccuracyWithFlattenTarget [

	| prediction real accuracy |

	prediction := tf constantWith: #((0.1 0.6 0.3) (0.05 0.95 0)) asFloatTensor.
	real := tf constantWith: #(2 1) asFloatTensor.

	accuracy := SparseCategoricalPredictionAccuracy of: prediction whenExpectedIs: real.

	self assertOutputOf: accuracy isFloatScalarCloseTo: 0.5
]
