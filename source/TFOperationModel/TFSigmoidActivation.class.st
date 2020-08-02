Class {
	#name : 'TFSigmoidActivation',
	#superclass : 'TFActivationFunction',
	#instVars : [
		'neuron'
	],
	#category : 'TFOperationModel'
}

{ #category : 'Instance Creation' }
TFSigmoidActivation class >> activating: aNeuron [

	^self named: self operationType activating: aNeuron
]

{ #category : 'Instance Creation' }
TFSigmoidActivation class >> named: anOperationName activating: aNeuron [

	^self new initializeNamed: anOperationName activating: aNeuron
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TFSigmoidActivation class >> operationType [

	^'Sigmoid'
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
TFSigmoidActivation >> initializeNamed: anOperationName activating: aNeuron [

	neuron := aNeuron.
	value :=
		neuron currentComputation
			newOperationOf: self class operationType
			namePrefixed: anOperationName
			with: neuron
]

{ #category : 'Printing' }
TFSigmoidActivation >> printOn: aStream [

	aStream nextPutAll: ('sigmoid(<1p>)' expandMacrosWith: neuron)
]
