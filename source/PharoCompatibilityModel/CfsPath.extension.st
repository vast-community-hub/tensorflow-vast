Extension {
	#name : 'CfsPath'
}

{ #category : '*PharoCompatibilityModel',
 #vaCategories : ['CFS-API'] }
CfsPath >> / aString [


	^ self extend: ('/%1' bindWith: aString)
]

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
