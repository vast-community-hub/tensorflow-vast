Class {
	#name : 'TFSoftmaxActivation',
	#superclass : 'TFActivationFunction',
	#instVars : [
		'neuron'
	],
	#category : 'TFOperationModel'
}

{ #category : 'Instance Creation' }
TFSoftmaxActivation class >> activating: aNeuron [

	^self named: self operationType activating: aNeuron
]

{ #category : 'Instance Creation' }
TFSoftmaxActivation class >> named: anOperationName activating: aNeuron [

	^self new initializeNamed: anOperationName activating: aNeuron
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TFSoftmaxActivation class >> operationType [

	^'Softmax'
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
TFSoftmaxActivation >> initializeNamed: anOperationName activating: aNeuron [

	neuron := aNeuron.
	value :=
		neuron currentComputation
			newOperationOf: self class operationType
			namePrefixed: anOperationName
			with: neuron
]

{ #category : 'Printing' }
TFSoftmaxActivation >> printOn: aStream [

	aStream nextPutAll: ('softmax(<1p>)' expandMacrosWith: neuron)
]
