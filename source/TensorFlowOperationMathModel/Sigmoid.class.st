Class {
	#name : 'Sigmoid',
	#superclass : 'ActivationFunction',
	#instVars : [
		'neuron'
	],
	#category : 'TensorFlowOperationMathModel'
}

{ #category : 'Instance Creation' }
Sigmoid class >> named: anOperationName activating: aNeuron [

	^self new initializeNamed: anOperationName activating: aNeuron
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
Sigmoid class >> operationType [

	^'Sigmoid'
]

{ #category : 'Accessing' }
Sigmoid >> currentComputation [

	^neuron currentComputation
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
Sigmoid >> initializeNamed: anOperationName activating: aNeuron [

	neuron := aNeuron.
	value :=
		neuron currentComputation
			newOperationOf: self class operationType
			namePrefixed: anOperationName
			with: neuron
]

{ #category : 'Printing' }
Sigmoid >> printOn: aStream [

	aStream nextPutAll: ('sigmoid(<1p>)' expandMacrosWith: neuron)
]
