Extension {
	#name : 'TFOperationDescription'
}

{ #category : '*TFExperimentalOperationModel',
 #vaCategories : ['attributes'] }
TFOperationDescription >> atPaddingPut: aListOfIntegers [

	^self at: 'padding' putString: aListOfIntegers
]

{ #category : '*TFExperimentalOperationModel',
 #vaCategories : ['attributes'] }
TFOperationDescription >> atStridesPut: aListOfIntegers [

	^self at: 'strides' putInts: aListOfIntegers
]
