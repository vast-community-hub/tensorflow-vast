Class {
	#name : 'TFTanhActivation',
	#superclass : 'TFActivationFunction',
	#instVars : [
		'neuron'
	],
	#category : 'TFOperationModel'
}

{ #category : 'Instance Creation' }
TFTanhActivation class >> activating: aNeuron [

	^self named: self operationType activating: aNeuron
]

{ #category : 'Instance Creation' }
TFTanhActivation class >> named: anOperationName activating: aNeuron [

	^self new initializeNamed: anOperationName activating: aNeuron
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TFTanhActivation class >> operationType [

	^'Tanh'
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
TFTanhActivation >> initializeNamed: anOperationName activating: aNeuron [

	neuron := aNeuron.
	value :=
		neuron currentComputation
			newOperationOf: self class operationType
			namePrefixed: anOperationName
			with: neuron
]

{ #category : 'Printing' }
TFTanhActivation >> printOn: aStream [

	aStream nextPutAll: ('tanh(<1p>)' expandMacrosWith: neuron)
]
