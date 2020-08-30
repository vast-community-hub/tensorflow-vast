Class {
	#name : 'LSTMNeuralNetworkTest',
	#superclass : 'TensorFlowComputationBasedTest',
	#category : 'FeedforwardNeuralNetworkModelTests'
}

{ #category : 'Test' }
LSTMNeuralNetworkTest >> testPredictAndCompare [

	| images nn prediction expected |

	images :=
		OrderedCollection new
			add: #(1 3 4);
			add: #(3 4 5);
			yourself.

	expected := #(6.5 7.8) asFloatTensor.
	nn := LSTMNeuralNetwork new.

	prediction := nn predictFrom: images andCompareTo: expected.

	self
		assert: (prediction at: 'Tanh_2')
		isMatrixCloseTo: #(-9.95241761207581e-1 -9.94422078132629e-1).
	self assert: (prediction at: 'Mean') isFloatScalarCloseTo: 66.7607879638672
]

{ #category : 'Test' }
LSTMNeuralNetworkTest >> testPredictFrom [

	| images nn prediction |

	images :=
		OrderedCollection new
			add: #(1 3 4);
			add: #(3 4 5);
			yourself.

	nn := LSTMNeuralNetwork new.

	prediction := nn predictFrom: images.

	self assert: prediction shape equals: #(2 1)
]
