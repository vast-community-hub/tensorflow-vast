Class {
	#name : 'TensorFiller',
	#superclass : 'TensorModifier',
	#category : 'TFTensorModifierModel'
}

{ #category : 'Instance Creation' }
TensorFiller class >> fillWith: aValue tensorShaped: aShape [

	^aShape currentComputation
		newOperationOf: 'Fill'
		namePrefixed: 'Fill'
		with: aShape
		with: aValue asTensor
]

{ #category : 'Instance Creation' }
TensorFiller class >> on: aTensorFlowComputation fillWith: aValue tensorShaped: aShape andType: aTensorType [

	^aTensorFlowComputation
		newOperationOf: 'Fill'
		namePrefixed: 'Fill'
		with: aShape asInt32Tensor
		with: (TFTensor newTyped: aTensorType containing: aValue)
]
