Extension {
	#name : 'Object'
}

{ #category : 'pharo' }
Object >> literalEqual: other [

	^ self class == other class and: [self = other]
]
