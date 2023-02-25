Extension {
	#name : 'TFOperationDescription'
}

{ #category : 'attributes' }
TFOperationDescription >> atPaddingPut: aListOfIntegers [

	^self at: 'padding' putString: aListOfIntegers
]

{ #category : 'attributes' }
TFOperationDescription >> atStridesPut: aListOfIntegers [

	^self at: 'strides' putInts: aListOfIntegers
]
