Extension {
	#name : 'String'
}

{ #category : '*PharoCompatibilityModel',
 #vaCategories : ['Squeak Family compatibility'] }
String >> beginsWith: aString [
	^ self beginsWithSubCollection: aString.
	
]

{ #category : '*PharoCompatibilityModel',
 #vaCategories : ['Squeak Family compatibility'] }
String >> endsWith: aString [
	^ self endsWithSubCollection: aString
]
