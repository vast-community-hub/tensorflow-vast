Extension {
	#name : 'TFOperationDescription'
}

{ #category : '*TFOperationModel',
 #vaCategories : ['attributes'] }
TFOperationDescription >> atDataTypePut: aType [

	self at: TFAttributeName dataType putType: aType
]

{ #category : '*TFOperationModel',
 #vaCategories : ['attributes'] }
TFOperationDescription >> atShapePut: aShape [

	self at: TFAttributeName shape putShape: aShape
]

{ #category : '*TFOperationModel',
 #vaCategories : ['attributes'] }
TFOperationDescription >> atTransposeAPut: aBoolean [

	self at: TFAttributeName transposeA putBoolean: aBoolean
]

{ #category : '*TFOperationModel',
 #vaCategories : ['attributes'] }
TFOperationDescription >> atTransposeBPut: aBoolean [

	self at: TFAttributeName transposeB putBoolean: aBoolean
]

{ #category : '*TFOperationModel',
 #vaCategories : ['attributes'] }
TFOperationDescription >> atValuePut: aType [

	self at: TFAttributeName value putTensor: aType
]
