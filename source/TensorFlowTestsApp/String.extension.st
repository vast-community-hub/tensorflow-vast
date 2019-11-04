Extension {
	#name : 'String'
}

{
	#category : '*TensorFlowTestsApp',
	#vaCategories : ['Squeak Family compatibility']
}
String >> beginsWith: aString [
	^ self beginsWithSubCollection: aString.
	
]

{
	#category : '*TensorFlowTestsApp',
	#vaCategories : ['Squeak Family compatibility']
}
String >> endsWith: aString [
	^ self endsWithSubCollection: aString
]
