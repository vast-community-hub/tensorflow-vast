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
		isMatrixCloseTo: #(-1.625294535188e-4 -2.54893238889053e-4).
	self assert: (prediction at: 'MSE') isFloatScalarCloseTo: 51.5479850769043
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

	self assert: prediction shape equals: (TensorShape matrixSized: 2 by: 1)
]
