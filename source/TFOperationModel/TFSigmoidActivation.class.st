Class {
	#name : 'TFSigmoidActivation',
	#superclass : 'TFActivationFunction',
	#category : 'TFOperationModel'
}

{ #category : 'Instance Creation' }
TFSigmoidActivation class >> activating: aNeuron [

	^self named: (aNeuron value nameFor: 'Sigmoid') activating: aNeuron
]

{ #category : 'Instance Creation' }
TFSigmoidActivation class >> named: anOperationName activating: aNeuron [

	^self new initializeNamed: anOperationName activating: aNeuron
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
TFSigmoidActivation >> calculateValue [

	^self unaryOperation: 'Sigmoid' with: neuron
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
TFSigmoidActivation >> initializeNamed: anOperationName activating: aNeuron [

	operationName := anOperationName.
	neuron := aNeuron.
	value := self calculateValue
]
