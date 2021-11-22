Extension {
	#name : 'Collection'
}

{ #category : '*TensorFlowCore',
 #vaCategories : ['TensorFlow - Kernel'] }
Collection >> singleElementsDo: aBlock [


	^ self do: [:each | each singleElementsDo: aBlock ]
]

{ #category : '*TensorFlowCore',
 #vaCategories : ['TensorFlow-Kernel'] }
Collection >> singleElementsInCollection [

	^self isEmpty
		ifTrue: [0]
		ifFalse: [self inject: 0 into: [:prev :each | prev + each singleElementsInCollection]]
]
