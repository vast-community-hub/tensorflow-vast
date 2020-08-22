Class {
	#name : 'SequentialModel',
	#superclass : 'TFOperationAbstract',
	#instVars : [
		'layers'
	],
	#category : 'MLNeuralNetworkLayerModel'
}

{ #category : 'Instance Creation' }
SequentialModel class >> composedOf: aLayersCollection [

	^self new initializeComposedOf: aLayersCollection
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
SequentialModel >> initializeComposedOf: aLayersCollection [

	layers := aLayersCollection.
	value := layers last
]

{ #category : 'Printing' }
SequentialModel >> printOn: aStream [

	aStream
		nextPutAll: ('Sequential Model (Layers: <1p>)' expandMacrosWith: layers size);
		cr.
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
