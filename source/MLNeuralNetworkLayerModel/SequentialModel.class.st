Class {
	#name : 'SequentialModel',
	#superclass : 'TFOperationAbstract',
	#instVars : [
		'layers',
		'logits'
	],
	#category : 'MLNeuralNetworkLayerModel'
}

{ #category : 'Instance Creation' }
SequentialModel class >> composedOf: aLayersCollection [

	^self composedOf: aLayersCollection applyingToLogits: [:output | output]
]

{ #category : 'Instance Creation' }
SequentialModel class >> composedOf: aLayersCollection applyingToLogits: aBlock [

	^self new initializeComposedOf: aLayersCollection applyingToLogits: aBlock
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
SequentialModel >> initializeComposedOf: aLayersCollection applyingToLogits: aBlock [

	layers := aLayersCollection.
	logits := layers last. 
	value := aBlock value: logits.
]

{ #category : 'Accessing' }
SequentialModel >> logits [

	^logits
]

{ #category : 'Printing' }
SequentialModel >> printOn: aStream [

	aStream nextPutAll: ('Sequential Model with <1p> layer' expandMacrosWith: layers size).
	layers size > 1 ifTrue: [aStream nextPut: $s].
	aStream cr.
	layers do: [:layer | aStream print: layer] separatedBy: [aStream crlf]
]

{ #category : 'Accessing' }
SequentialModel >> trainableVariables [

	^layers
		inject: OrderedCollection new
		into: [:vars :layer |
			vars
				addAll: layer trainableVariables;
				yourself]
]
