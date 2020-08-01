Class {
	#name : 'TFFiller',
	#superclass : 'TFTensorModifier',
	#category : 'TFTensorModifierModel'
}

{ #category : 'Instance Creation' }
TFFiller class >> fillWith: aValue tensorShaped: aShape [

	^aShape currentComputation
		newOperationOf: 'Fill'
		named: 'Fill'
		with: aShape
		with: aValue asTensor
]

{ #category : 'Instance Creation' }
TFFiller class >> on: aTensorFlowComputation fillWith: aValue tensorShaped: aShape andType: aTensorType [

	^aTensorFlowComputation
		newOperationOf: 'Fill'
		named: 'Fill'
		with: aShape asInt32Tensor
		with: (TFTensor fromNumbers: aValue type: aTensorType)
]
