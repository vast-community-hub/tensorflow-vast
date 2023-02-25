Extension {
	#name : 'String'
}

{ #category : 'Squeak Family compatibility' }
String >> beginsWith: aString [
	^ self beginsWithSubCollection: aString.
	
]

{ #category : 'Squeak Family compatibility' }
String >> endsWith: aString [
	^ self endsWithSubCollection: aString
]
