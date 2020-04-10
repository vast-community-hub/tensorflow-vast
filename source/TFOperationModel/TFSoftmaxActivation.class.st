Class {
	#name : 'TFSoftmaxActivation',
	#superclass : 'TFActivationFunction',
	#category : 'TFOperationModel'
}

{ #category : 'Instance Creation' }
TFSoftmaxActivation class >> activating: aNeuron [

	^self named: (aNeuron value nameFor: 'Softmax') activating: aNeuron
]

{ #category : 'Instance Creation' }
TFSoftmaxActivation class >> named: anOperationName activating: aNeuron [

	^self new initializeNamed: anOperationName activating: aNeuron
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
TFSoftmaxActivation >> calculateValue [

	^self unaryOperation: 'Softmax' with: neuron
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
TFSoftmaxActivation >> initializeNamed: anOperationName activating: aNeuron [

	operationName := anOperationName.
	neuron := aNeuron.
	value := self calculateValue
]
