Extension {
	#name : 'TFTensor'
}

{ #category : '*TFOperationModel',
 #vaCategories : ['converting'] }
TFTensor >> asOperationOn: aComputation [


	^ ConstantNode on: aComputation with: self
]

{ #category : '*TFOperationModel',
 #vaCategories : ['accessing'],
  #vaVisibility : 'private' }
TFTensor >> isScalar [
	^self rank = 0
]

{ #category : '*TFOperationModel',
 #vaCategories : ['accessing'] }
TFTensor >> outputOn: aComputation [


	^ ( self asOperationOn: aComputation ) value firstOutput
]

{ #category : '*TFOperationModel',
 #vaCategories : ['Printing'] }
TFTensor >> printOn: aStream [

	aStream nextPutAll:
		('<1s> <2s>' expandMacrosWith: self typeDescription with: self shapeDescription asLowercase)
]

{ #category : '*TFOperationModel',
 #vaCategories : ['accessing'] }
TFTensor >> shapeDescription [

	^self shape description
]

{ #category : '*TFOperationModel',
 #vaCategories : ['accessing'] }
TFTensor >> typeDescription [

	^self type description
]
