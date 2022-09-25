Class {
	#name : 'Tanh',
	#superclass : 'ActivationFunction',
	#instVars : [
		'neuron'
	],
	#category : 'TensorFlowOperationMathModel'
}

{ #category : 'Instance Creation' }
Tanh class >> activating: aNeuron [

	^self named: self operationType activating: aNeuron
]

{ #category : 'Instance Creation' }
Tanh class >> named: anOperationName activating: aNeuron [

	^self new initializeNamed: anOperationName activating: aNeuron
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
Tanh class >> operationType [

	^'Tanh'
]

{ #category : 'Accessing' }
Tanh >> currentComputation [

	^neuron currentComputation
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
Tanh >> initializeNamed: anOperationName activating: aNeuron [

	neuron := aNeuron.
	value :=
		self currentComputation
			newOperationOf: self class operationType
			namePrefixed: anOperationName
			with: neuron
]

{ #category : 'Printing' }
Tanh >> printOn: aStream [

	aStream nextPutAll: ('tanh(<1p>)' expandMacrosWith: neuron)
]
