Class {
	#name : 'Sigmoid3LayerNeuralNetworkTest',
	#superclass : 'TestCase',
	#category : 'MLNeuralNetworkModelTests'
}

{ #category : 'Test' }
Sigmoid3LayerNeuralNetworkTest >> testPrediction3LayersSigmoid [

	| loss nn result prediction images labels |

	images := (1 to: 2) collect: [:i | MNISTImageFile trainingSet bytesAt: i].
	labels := (1 to: 2) collect: [:i | MNISTLabelFile trainingSet at: i].

	nn := Sigmoid3LayerNeuralNetwork new.
	result := nn predictFrom: images andCompareTo: labels.
	loss := (result at: 'Mean') allFloats.
	self deny: (loss first closeTo: 0).

	nn :=
		NeuralNetworkBuilder new
			trainingIterations: 100;
			buildBasedOn: nn toFitPredictionFrom: images to: labels.

	result := nn predictFrom: images andCompareTo: labels.
	loss := (result at: 'Mean') asNumbers.
	self assert: (loss < 1).
	prediction := nn predictFrom: images.
	self assert: prediction asNumbers equals: labels
]
