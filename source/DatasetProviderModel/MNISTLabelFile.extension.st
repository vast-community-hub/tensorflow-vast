Extension {
	#name : 'MNISTLabelFile'
}

{ #category : '*DatasetProviderModel',
 #vaCategories : ['accessing'] }
MNISTLabelFile >> asInt32Tensor [

	^self asTensor
]

{ #category : '*DatasetProviderModel',
 #vaCategories : ['accessing'] }
MNISTLabelFile >> copyFrom: aStartingIndex to: anUpperIndex [

	^(aStartingIndex to: anUpperIndex) collect: [:index | self at: index]
]
