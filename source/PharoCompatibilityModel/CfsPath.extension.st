Extension {
	#name : 'CfsPath'
}

{ #category : '*PharoCompatibilityModel',
 #vaCategories : ['CFS-API'] }
CfsPath >> asFileReference [

	^self asPath
]

{ #category : '*PharoCompatibilityModel',
 #vaCategories : ['CFS-API'] }
CfsPath >> deleteIfAbsent: aBlock [

	self exists ifTrue: [self delete] ifFalse: aBlock
]
