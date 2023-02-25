Extension {
	#name : 'TFTensor'
}

{ #category : 'converting' }
TFTensor >> asOperationOn: aComputation [

	^ ConstantTensor on: aComputation with: self
]

{ #category : 'accessing' }
TFTensor >> outputOn: aComputation [

	^ ( self asOperationOn: aComputation ) value firstOutput
]

{ #category : 'Printing' }
TFTensor >> printOn: aStream [

	aStream nextPutAll:
		('<1s> <2s>' expandMacrosWith: self typeDescription with: self shapeDescription asLowercase)
]

{ #category : 'accessing' }
TFTensor >> shapeDescription [

	^self shape description
]

{ #category : 'accessing' }
TFTensor >> typeDescription [

	^self type description
]
