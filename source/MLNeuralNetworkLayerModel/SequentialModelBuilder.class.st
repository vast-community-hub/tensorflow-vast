Class {
	#name : 'SequentialModelBuilder',
	#superclass : 'Object',
	#instVars : [
		'tf',
		'layers'
	],
	#category : 'MLNeuralNetworkLayerModel'
}

{ #category : 'Instance Creation' }
SequentialModelBuilder class >> on: aTensorFlowComputation [

	^self new initializeOn: aTensorFlowComputation
]

{ #category : 'Configuring' }
SequentialModelBuilder >> addDenseLayerSized: anOutputSize builtWith: aBlock [

	| input layerBuilder |

	input := layers isEmpty ifTrue: [tf floatInputNamed: 'input'] ifFalse: [layers last].
	layerBuilder := DenseLayerBuilder ofSize: anOutputSize receiving: input.
	aBlock value: layerBuilder.
	self addLayer: layerBuilder build
]

{ #category : 'Configuring',
  #vaVisibility : 'private' }
SequentialModelBuilder >> addLayer: aDenseLayer [

	layers add: aDenseLayer
]

{ #category : 'Building' }
SequentialModelBuilder >> build [

	^layers last
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
SequentialModelBuilder >> initializeOn: aTensorFlowComputation [

	tf := aTensorFlowComputation.
	layers := OrderedCollection new
]
