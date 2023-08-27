Class {
	#name : 'ReLU',
	#superclass : 'ActivationFunction',
	#instVars : [
		'neuron'
	],
	#category : 'TensorFlowOperationMathModel'
}

{ #category : 'Instance Creation' }
ReLU class >> named: anOperationName activating: aNeuron [

	^self new initializeNamed: anOperationName activating: aNeuron
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
ReLU class >> operationType [

	^'Relu'
]

{ #category : 'Accessing' }
ReLU >> currentComputation [

	^neuron currentComputation
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
ReLU >> initializeNamed: anOperationName activating: aNeuron [

	neuron := aNeuron.
	value :=
		neuron currentComputation
			newOperationOf: self class operationType
			namePrefixed: anOperationName
			with: neuron
]

{ #category : 'Printing' }
ReLU >> printOn: aStream [

	aStream nextPutAll: ('relu(<1p>)' expandMacrosWith: neuron)
]
