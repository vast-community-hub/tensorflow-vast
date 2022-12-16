Extension {
	#name : 'TFTensor'
}

{ #category : '*TensorFlowOperationBasicModel',
 #vaCategories : ['converting'] }
TFTensor >> asOperationOn: aComputation [

	^ ConstantTensor on: aComputation with: self
]

{ #category : '*TensorFlowOperationBasicModel',
 #vaCategories : ['accessing'] }
TFTensor >> outputOn: aComputation [

	^ ( self asOperationOn: aComputation ) value firstOutput
]

{ #category : '*TensorFlowOperationBasicModel',
 #vaCategories : ['Printing'] }
TFTensor >> printOn: aStream [

	aStream nextPutAll:
		('<1s> <2s>' expandMacrosWith: self typeDescription with: self shapeDescription asLowercase)
]

{ #category : '*TensorFlowOperationBasicModel',
 #vaCategories : ['accessing'] }
TFTensor >> shapeDescription [

	^self shape description
]

{ #category : '*TensorFlowOperationBasicModel',
 #vaCategories : ['accessing'] }
TFTensor >> typeDescription [

	^self type description
]
