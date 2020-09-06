Class {
	#name : 'Softmax',
	#superclass : 'ActivationFunction',
	#instVars : [
		'neuron'
	],
	#category : 'TFOperationModel'
}

{ #category : 'Instance Creation' }
Softmax class >> activating: aNeuron [

	^self named: self operationType activating: aNeuron
]

{ #category : 'Instance Creation' }
Softmax class >> named: anOperationName activating: aNeuron [

	^self new initializeNamed: anOperationName activating: aNeuron
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
Softmax class >> operationType [

	^'Softmax'
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
Softmax >> initializeNamed: anOperationName activating: aNeuron [

	neuron := aNeuron.
	value :=
		neuron currentComputation
			newOperationOf: self class operationType
			namePrefixed: anOperationName
			with: neuron
]

{ #category : 'Printing' }
Softmax >> printOn: aStream [

	aStream nextPutAll: ('softmax(<1p>)' expandMacrosWith: neuron)
]
