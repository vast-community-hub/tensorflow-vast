Extension {
	#name : 'MNISTImageFile'
}

{ #category : '*DatasetProviderModel',
 #vaCategories : ['accessing'] }
MNISTImageFile >> asFloatTensor [

	^self asTensor
]

{ #category : '*DatasetProviderModel',
 #vaCategories : ['accessing'] }
MNISTImageFile >> copyFrom: aStartingIndex to: anUpperIndex [

	^(aStartingIndex to: anUpperIndex) collect: [:index | self bytesAt: index]
]

{ #category : '*DatasetProviderModel',
 #vaCategories : ['converting'] }
MNISTImageFile >> transformFeaturesDoing: aBlock [

	items := items collect: aBlock
]
