Class {
	#name : 'TFTanhActivation',
	#superclass : 'TFActivationFunction',
	#category : 'TFOperationModel'
}

{ #category : 'Instance Creation' }
TFTanhActivation class >> activating: aNeuron [

	^self named: (aNeuron value nameFor: 'Tanh') activating: aNeuron
]

{ #category : 'Instance Creation' }
TFTanhActivation class >> named: anOperationName activating: aNeuron [

	^self new initializeNamed: anOperationName activating: aNeuron
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
TFTanhActivation >> calculateValue [

	^self unaryOperation: 'Tanh' with: neuron
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
TFTanhActivation >> initializeNamed: anOperationName activating: aNeuron [

	operationName := anOperationName.
	neuron := aNeuron.
	value := self calculateValue
]
