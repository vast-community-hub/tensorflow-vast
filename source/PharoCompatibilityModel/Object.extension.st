Extension {
	#name : 'Object'
}

{ #category : '*PharoCompatibilityModel',
 #vaCategories : ['pharo'] }
Object >> literalEqual: other [

	^ self class == other class and: [self = other]
]
