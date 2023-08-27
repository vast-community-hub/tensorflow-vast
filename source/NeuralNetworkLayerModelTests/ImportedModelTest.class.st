Class {
	#name : 'ImportedModelTest',
	#superclass : 'TensorFlowComputationBasedTest',
	#category : 'NeuralNetworkLayerModelTests'
}

{ #category : 'Asserting',
  #vaVisibility : 'private' }
ImportedModelTest >> assert: aTFTensor isEquivalentTensorAs: anotherTFTensor [

	self assert: aTFTensor shape equals: anotherTFTensor shape.
	self assert: aTFTensor allElements equals: anotherTFTensor allElements
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
ImportedModelTest >> inputWithTwoFeatures [

	^#((1 2)) asFloatTensor
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
ImportedModelTest >> protoBufferModelName [

	^'testLoadAndPredict-model.pb'
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
ImportedModelTest >> tearDown [

	self protoBufferModelName asFileReference deleteIfAbsent: []
]

{ #category : 'Test' }
ImportedModelTest >> testLoadAndPredict [

	| model loadedModel newContext |

	model :=
		(SequentialModelBuilder on: tf)
			addDenseLayerSized: 1
				builtWith: [:layer |
					layer
						inputSize: 2;
						weightInitializedTo: #((2) (3));
						withoutBias];
			build.
	model saveModelTo: self protoBufferModelName.

	newContext := TensorFlowComputation new.
	loadedModel :=
		ImportedModel
			on: newContext
			loadedFrom: self protoBufferModelName
			inputNamed: 'dense/input'
			outputNamed: 'dense/MatMul'.

	self
		assert: (model predictFrom: self inputWithTwoFeatures)
		isEquivalentTensorAs: (loadedModel predictFrom: self inputWithTwoFeatures)
]
