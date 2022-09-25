Extension {
	#name : 'TFOperationDescription'
}

{ #category : '*TensorFlowOperationExperimentalModel',
 #vaCategories : ['attributes'] }
TFOperationDescription >> atPaddingPut: aListOfIntegers [

	^self at: 'padding' putString: aListOfIntegers
]

{ #category : '*TensorFlowOperationExperimentalModel',
 #vaCategories : ['attributes'] }
TFOperationDescription >> atStridesPut: aListOfIntegers [

	^self at: 'strides' putInts: aListOfIntegers
]
