Class {
	#name : 'FlattenLayer',
	#superclass : 'SequentialModelLayer',
	#instVars : [
		'input'
	],
	#category : 'NeuralNetworkLayerModel'
}

{ #category : 'Not categorized' }
FlattenLayer class >> receiving: anInputTensor [

	^ self new initializeReceiving: anInputTensor
]

{ #category : 'Accessing' }
FlattenLayer >> currentComputation [

	^value currentComputation
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
FlattenLayer >> initializeReceiving: anInputTensor [

	| outputShape |

	input := anInputTensor.
	outputShape := input outputShape.
	value :=
		input reshapeTo: (
			TensorShape
				matrixSized: outputShape batchDimension
				by: outputShape nonBatchDimensionsSize)
]

{ #category : 'Accessing' }
FlattenLayer >> inputVariableName [

	^input operationName
]

{ #category : 'Printing' }
FlattenLayer >> printOn: aStream [

	aStream nextPutAll: 'Flatten Layer'
]

{ #category : 'Accessing' }
FlattenLayer >> trainableVariables [

	^#()
]
