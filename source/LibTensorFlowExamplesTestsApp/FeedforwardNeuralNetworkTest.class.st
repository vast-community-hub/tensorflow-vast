Class {
	#name : 'FeedforwardNeuralNetworkTest',
	#superclass : 'TestCase',
	#category : 'LibTensorFlowExamplesTestsApp'
}

{ #category : 'Tests' }
FeedforwardNeuralNetworkTest >> testLearningImprovement [

	| inputs weights nn prediction targetValues |

	inputs := (Array with: #(1) with: (Array with: 2 ln)) asFloatTensor.
	targetValues := #(0.5 0.5).
	weights := #((1 1) (1 0)).
	nn :=
		NeuralNetworkBuilder new
			trainingIterations: 100;
			buildBasedOn: (FeedforwardNeuralNetwork weightingFeaturesWith: weights asFloatTensor)
				toFitPredictionFrom: inputs
				to: targetValues asFloatTensor.
	prediction := nn predictFrom: inputs.
	targetValues
		with: prediction allFloats
		do: [:real :predicted | self assert: (real - predicted) abs < 0.109]
]
