Class {
	#name : 'TFReluActivation',
	#superclass : 'TFActivationFunction',
	#category : 'TFOperationModel'
}

{ #category : 'Instance Creation' }
TFReluActivation class >> activating: aNeuron [

	^self named: (aNeuron value nameFor: 'Relu') activating: aNeuron
]

{ #category : 'Instance Creation' }
TFReluActivation class >> named: anOperationName activating: aNeuron [

	^self new initializeNamed: anOperationName activating: aNeuron
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
TFReluActivation >> calculateValue [

	^self unaryOperation: 'Relu' with: neuron
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
TFReluActivation >> initializeNamed: anOperationName activating: aNeuron [

	operationName := anOperationName.
	neuron := aNeuron.
	value := self calculateValue
]
