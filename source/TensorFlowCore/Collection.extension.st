Extension {
	#name : 'Collection'
}

{ #category : 'TensorFlow - Kernel' }
Collection >> singleElementsDo: aBlock [


	^ self do: [:each | each singleElementsDo: aBlock ]
]

{ #category : 'TensorFlow-Kernel' }
Collection >> singleElementsInCollection [

	^self isEmpty
		ifTrue: [0]
		ifFalse: [self inject: 0 into: [:prev :each | prev + each singleElementsInCollection]]
]
