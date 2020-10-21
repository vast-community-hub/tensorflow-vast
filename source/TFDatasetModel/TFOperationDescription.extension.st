Extension {
	#name : 'TFOperationDescription'
}

{ #category : '*TFDatasetModel',
 #vaCategories : ['attributes'] }
TFOperationDescription >> atContainerPut: aString [

	self at: TFAttributeName container putString: aString
]

{ #category : '*TFDatasetModel',
 #vaCategories : ['attributes'] }
TFOperationDescription >> atFieldDelimiterPut: aListOfTypes [

	self at: 'field_delim' putString: aListOfTypes
]

{ #category : '*TFDatasetModel',
 #vaCategories : ['attributes'] }
TFOperationDescription >> atNotAvailableValuePut: aListOfTypes [

	self at: 'na_value' putString: aListOfTypes
]

{ #category : '*TFDatasetModel',
 #vaCategories : ['attributes'] }
TFOperationDescription >> atOutputShapesPut: aListOfShapes [

	self at: TFAttributeName outputShapes putShapes: aListOfShapes
]

{ #category : '*TFDatasetModel',
 #vaCategories : ['attributes'] }
TFOperationDescription >> atOutputTypesPut: aListOfTypes [

	self at: TFAttributeName outputTypes putTypes: aListOfTypes
]

{ #category : '*TFDatasetModel',
 #vaCategories : ['attributes'] }
TFOperationDescription >> atSharedNamePut: aString [

	self at: TFAttributeName sharedName putString: aString
]
