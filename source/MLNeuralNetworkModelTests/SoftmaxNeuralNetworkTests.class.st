Class {
	#name : 'SoftmaxNeuralNetworkTests',
	#superclass : 'TestCase',
	#category : 'MLNeuralNetworkModelTests'
}

{ #category : 'testing MNIST' }
SoftmaxNeuralNetworkTests >> testMNISTSoftMaxForwardGraph [

	| mnist result |

	mnist := SoftmaxNeuralNetwork new.
	result :=
		mnist predictFrom: (
			Array
				with: (ByteArray new: mnist inputSize)
				with: (ByteArray new: mnist inputSize withAll: 1)).
	self assert: #(2) equals: result shape.
	self assert: (result allInt32s first closeTo: 0).
	self assert: (result allInt32s second closeTo: 0)
]

{ #category : 'testing MNIST' }
SoftmaxNeuralNetworkTests >> testMNISTSoftMaxLossGraph [

	| mnist results prediction loss |

	mnist := SoftmaxNeuralNetwork new.
	results :=
		mnist
			predictFrom: (
				Array
					with: (ByteArray new: mnist inputSize)
					with: (ByteArray new: mnist inputSize withAll: 1))
			andCompareTo: #(1 2).

	prediction := results at: 'prediction'.
	self assert: #(2) equals: prediction shape.
	self assert: prediction asNumbers first equals: 0.
	self assert: prediction asNumbers second equals: 0.

	loss := results at: 'loss'.
	self assert: #() equals: loss shape.
	self assert: loss allFloats sum abs > 0
]

{ #category : 'testing MNIST' }
SoftmaxNeuralNetworkTests >> testPrediction [

	| loss nn prediction result images labels |

	images := (1 to: 2) collect: [:i | MNISTImageFile trainingSet bytesAt: i].
	labels := (1 to: 2) collect: [:i | MNISTLabelFile trainingSet at: i].

	nn := SoftmaxNeuralNetwork new.
	result := nn predictFrom: images andCompareTo: labels.

	loss := (result at: 'loss') asNumbers.
	self deny: (loss closeTo: 0).

	nn :=
		NeuralNetworkBuilder new
			trainingIterations: 100;
			buildBasedOn: nn toFitPredictionFrom: images to: labels.
			
	result := nn predictFrom: images andCompareTo: labels.
	loss := (result at: 'loss') asNumbers.
	self assert: (0 closeTo: loss).

	prediction := nn predictFrom: images.
	self assert: prediction asNumbers first equals: labels first.
	self assert: prediction asNumbers second equals: labels second
]
