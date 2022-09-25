Extension {
	#name : 'TFOperationDescription'
}

{ #category : '*TensorFlowOperationMathModel',
 #vaCategories : ['attributes'] }
TFOperationDescription >> atDataTypePut: aType [

	self at: TFAttributeName dataType putType: aType
]

{ #category : '*TensorFlowOperationMathModel',
 #vaCategories : ['attributes'] }
TFOperationDescription >> atShapePut: aShape [

	self at: TFAttributeName shape putShape: aShape
]

{ #category : '*TensorFlowOperationMathModel',
 #vaCategories : ['attributes'] }
TFOperationDescription >> atTransposeAPut: aBoolean [

	self at: TFAttributeName transposeA putBoolean: aBoolean
]

{ #category : '*TensorFlowOperationMathModel',
 #vaCategories : ['attributes'] }
TFOperationDescription >> atTransposeBPut: aBoolean [

	self at: TFAttributeName transposeB putBoolean: aBoolean
]

{ #category : '*TensorFlowOperationMathModel',
 #vaCategories : ['attributes'] }
TFOperationDescription >> atValuePut: aType [

	self at: TFAttributeName value putTensor: aType
]
