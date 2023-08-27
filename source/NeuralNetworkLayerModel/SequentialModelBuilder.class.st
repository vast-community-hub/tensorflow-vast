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

	self
		inScopeNamed: 'dense'
		withCountOf: DenseLayer
		do: [| input layerBuilder |
			input := layers isEmpty ifTrue: [tf floatInputNamed: 'input'] ifFalse: [layers last].
			layerBuilder := DenseLayerBuilder ofSize: anOutputSize receiving: input.
			layers isEmpty ifFalse: [layerBuilder makeInputSizeOptional].
			aBlock value: layerBuilder.
			self addLayer: layerBuilder build]
]

{ #category : 'Configuring' }
SequentialModelBuilder >> addFlattenLayerSized: aTensorShape [

	self
		inScopeNamed: 'flatten'
		withCountOf: FlattenLayer
		do: [| input |
			input :=
				layers isEmpty
					ifTrue: [
						InputTensor
							on: tf
							named: 'input'
							of: FloatDataType new
							shaped: aTensorShape withUnknowBatchDimension]
					ifFalse: [layers last].
			self addLayer: (FlattenLayer receiving: input)]
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

{ #category : 'Configuring',
  #vaVisibility : 'private' }
SequentialModelBuilder >> inScopeNamed: aLayerName withCountOf: aLayerClass do: aBlock [

	| denseCount |

	denseCount := layers count: [:layer | layer isA: aLayerClass].
	tf
		inScopeNamed: (
			denseCount = 0
				ifTrue: [aLayerName]
				ifFalse: ['%1_%2' bindWith: aLayerName with: denseCount])
		do: aBlock
]
