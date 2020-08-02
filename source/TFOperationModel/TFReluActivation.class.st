Class {
	#name : 'TFReluActivation',
	#superclass : 'TFActivationFunction',
	#instVars : [
		'neuron'
	],
	#category : 'TFOperationModel'
}

{ #category : 'Instance Creation' }
TFReluActivation class >> activating: aNeuron [

	^self named: self operationType activating: aNeuron
]

{ #category : 'Instance Creation' }
TFReluActivation class >> named: anOperationName activating: aNeuron [

	^self new initializeNamed: anOperationName activating: aNeuron
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TFReluActivation class >> operationType [

	^'Relu'
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
TFReluActivation >> initializeNamed: anOperationName activating: aNeuron [

	neuron := aNeuron.
	value :=
		neuron currentComputation
			newOperationOf: self class operationType
			namePrefixed: anOperationName
			with: neuron
]

{ #category : 'Printing' }
TFReluActivation >> printOn: aStream [

	aStream nextPutAll: ('relu(<1p>)' expandMacrosWith: neuron)
]
