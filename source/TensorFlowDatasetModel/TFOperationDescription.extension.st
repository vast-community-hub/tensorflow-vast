Extension {
	#name : 'TFOperationDescription'
}

{ #category : '*TensorFlowDatasetModel',
 #vaCategories : ['attributes'] }
TFOperationDescription >> atContainerPut: aString [

	self at: TFAttributeName container putString: aString
]

{ #category : '*TensorFlowDatasetModel',
 #vaCategories : ['attributes'] }
TFOperationDescription >> atFieldDelimiterPut: aListOfTypes [

	self at: 'field_delim' putString: aListOfTypes
]

{ #category : '*TensorFlowDatasetModel',
 #vaCategories : ['attributes'] }
TFOperationDescription >> atNotAvailableValuePut: aListOfTypes [

	self at: 'na_value' putString: aListOfTypes
]

{ #category : '*TensorFlowDatasetModel',
 #vaCategories : ['attributes'] }
TFOperationDescription >> atOutputShapesPut: aListOfShapes [

	self at: TFAttributeName outputShapes putShapes: aListOfShapes
]

{ #category : '*TensorFlowDatasetModel',
 #vaCategories : ['attributes'] }
TFOperationDescription >> atOutputTypesPut: aListOfTypes [

	self at: TFAttributeName outputTypes putTypes: aListOfTypes
]

{ #category : '*TensorFlowDatasetModel',
 #vaCategories : ['attributes'] }
TFOperationDescription >> atSharedNamePut: aString [

	self at: TFAttributeName sharedName putString: aString
]
