Class {
	#name : 'Rectified3LayerNeuralNetworkTest',
	#superclass : 'TestCase',
	#category : 'MLNeuralNetworkModelTests'
}

{ #category : 'Test' }
Rectified3LayerNeuralNetworkTest >> testMNIST3LayersNNForwardGraph [

	| nn result first second |

	nn := Rectified3LayerNeuralNetwork new.
	result :=
		nn predictFrom: (
			Array
				with: (ByteArray new: nn inputSize withAll: 2)
				with: (ByteArray new: nn inputSize withAll: 1)).
	self assert: #(2) equals: result shape.
	first := result asNumbers first.
	second := result asNumbers second.
	self assert: (0 <= first and: [first < 10]).
	self assert: (0 <= second and: [second < 10])



]

{ #category : 'Test' }
Rectified3LayerNeuralNetworkTest >> testMNIST3LayersNNLossGraph [

	| nn results first second prediction loss |

	nn := Rectified3LayerNeuralNetwork new.
	results :=
		nn
			predictFrom: (
				Array
					with: (ByteArray new: nn inputSize)
					with: (ByteArray new: nn inputSize withAll: 1))
			andCompareTo: #(1 2).

	prediction := results at: 'prediction'.
	self assert: #(2) equals: prediction shape.
	first := prediction asNumbers first.
	second := prediction asNumbers second.
	self assert: (0 <= first and: [first < 10]).
	self assert: (0 <= second and: [second < 10]).

	loss := results at: 'loss/Mean'.
	self assert: #() equals: loss shape.
	self assert: loss asNumbers > 0


]

{ #category : 'Test' }
Rectified3LayerNeuralNetworkTest >> testPrediction3Layers [

	| images labels loss nn result prediction |

	images := (1 to: 2) collect: [:i | MNISTImageFile trainingSet bytesAt: i].
	labels := (1 to: 2) collect: [:i | MNISTLabelFile trainingSet at: i].

	nn := Rectified3LayerNeuralNetwork new.

	result := nn predictFrom: images andCompareTo: labels.
	loss := (result at: 'loss/Mean') allFloats.
	self deny: (loss first closeTo: 0).

	nn :=
		NeuralNetworkBuilder new
			trainingIterations: 100;
			buildBasedOn: nn toFitPredictionFrom: images to: labels.

	result := nn predictFrom: images andCompareTo: labels.
	loss := (result at: 'loss/Mean') allFloats.
	self assert: (loss first closeTo: 0).

	prediction := nn predictFrom: images.
	self assert: prediction asNumbers first equals: labels first.
	self assert: prediction asNumbers second equals: labels second
]
