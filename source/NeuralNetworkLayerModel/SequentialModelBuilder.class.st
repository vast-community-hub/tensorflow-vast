Class {
	#name : 'SequentialModelBuilder',
	#superclass : 'Object',
	#instVars : [
		'tf',
		'layers'
	],
	#category : 'NeuralNetworkLayerModel'
}

{ #category : 'Instance Creation' }
SequentialModelBuilder class >> new [

	^self on: TensorFlowComputation new
]

{ #category : 'Instance Creation' }
SequentialModelBuilder class >> on: aTensorFlowComputation [

	^super new initializeOn: aTensorFlowComputation
]

{ #category : 'Configuring' }
SequentialModelBuilder >> addDenseLayerSized: anOutputSize builtWith: aBlock [

	| input layerBuilder |

	input := layers isEmpty ifTrue: [tf floatInputNamed: 'input'] ifFalse: [layers last].
	layerBuilder := DenseLayerBuilder ofSize: anOutputSize receiving: input.
	layers isEmpty ifFalse: [layerBuilder makeInputSizeOptional].
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

	^self buildApplyingToLogits: [:logits | logits]
]

{ #category : 'Building' }
SequentialModelBuilder >> buildApplyingToLogits: aBlock [

	^SequentialModel composedOf: layers applyingToLogits: aBlock
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
SequentialModelBuilder >> initializeOn: aTensorFlowComputation [

	tf := aTensorFlowComputation.
	layers := OrderedCollection new
]
