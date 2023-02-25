Extension {
	#name : 'CfsPath'
}

{ #category : 'CFS-API' }
CfsPath >> / aString [


	^ self extend: ('/%1' bindWith: aString)
]

{ #category : 'CFS-API' }
CfsPath >> asFileReference [

	^self asPath
]

{ #category : 'CFS-API' }
CfsPath >> deleteIfAbsent: aBlock [

	self exists ifTrue: [self delete] ifFalse: aBlock
]
