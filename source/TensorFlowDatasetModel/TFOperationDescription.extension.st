Extension {
	#name : 'TFOperationDescription'
}

{ #category : 'attributes' }
TFOperationDescription >> atContainerPut: aString [

	self at: TFAttributeName container putString: aString
]

{ #category : 'attributes' }
TFOperationDescription >> atFieldDelimiterPut: aListOfTypes [

	self at: 'field_delim' putString: aListOfTypes
]

{ #category : 'attributes' }
TFOperationDescription >> atNotAvailableValuePut: aListOfTypes [

	self at: 'na_value' putString: aListOfTypes
]

{ #category : 'attributes' }
TFOperationDescription >> atOutputShapesPut: aListOfShapes [

	self at: TFAttributeName outputShapes putShapes: aListOfShapes
]

{ #category : 'attributes' }
TFOperationDescription >> atOutputTypesPut: aListOfTypes [

	self at: TFAttributeName outputTypes putTypes: aListOfTypes
]

{ #category : 'attributes' }
TFOperationDescription >> atSharedNamePut: aString [

	self at: TFAttributeName sharedName putString: aString
]
