Extension {
	#name : 'TFOperationDescription'
}

{ #category : 'attributes' }
TFOperationDescription >> atDataTypePut: aType [

	self at: TFAttributeName dataType putType: aType
]

{ #category : 'attributes' }
TFOperationDescription >> atShapePut: aShape [

	self at: TFAttributeName shape putShape: aShape
]

{ #category : 'attributes' }
TFOperationDescription >> atTransposeAPut: aBoolean [

	self at: TFAttributeName transposeA putBoolean: aBoolean
]

{ #category : 'attributes' }
TFOperationDescription >> atTransposeBPut: aBoolean [

	self at: TFAttributeName transposeB putBoolean: aBoolean
]

{ #category : 'attributes' }
TFOperationDescription >> atValuePut: aType [

	self at: TFAttributeName value putTensor: aType
]
