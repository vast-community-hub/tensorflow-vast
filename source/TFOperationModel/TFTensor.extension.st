Extension {
	#name : 'TFTensor'
}

{ #category : '*TFOperationModel',
 #vaCategories : ['Accessing'] }
TFTensor class >> descriptionOf: aType [

	^Dictionary new
		at: TF_BFLOAT16 put: 'BFloat16';
		at: TF_BOOL put: 'Bool';
		at: TF_COMPLEX put: 'Complex';
		at: TF_COMPLEX128 put: 'Complex128';
		at: TF_COMPLEX64 put: 'Complex64';
		at: TF_DOUBLE put: 'Double';
		at: TF_FLOAT put: 'Float';
		at: TF_HALF put: 'Half';
		at: TF_INT16 put: 'Int16';
		at: TF_INT32 put: 'Int32';
		at: TF_INT64 put: 'Int64';
		at: TF_INT8 put: 'Int8';
		at: TF_QINT16 put: 'QInt16';
		at: TF_QINT32 put: 'QInt32';
		at: TF_QINT8 put: 'QInt8';
		at: TF_QUINT16 put: 'QUInt16';
		at: TF_QUINT8 put: 'QUInt8';
		at: TF_RESOURCE put: 'Resource';
		at: TF_STRING put: 'String';
		at: TF_UINT16 put: 'UInt16';
		at: TF_UINT32 put: 'Uint32';
		at: TF_UINT64 put: 'Uint64';
		at: TF_UINT8 put: 'Uint8';
		at: TF_VARIANT put: 'Variant';
		at: aType
]

{ #category : '*TFOperationModel',
 #vaCategories : ['converting'] }
TFTensor >> asOperationOn: aComputation [


	^ ConstantNode on: aComputation with: self
]

{ #category : '*TFOperationModel',
 #vaCategories : ['Accessing'],
  #vaVisibility : 'private' }
TFTensor >> isScalar [
	^self rank = 0
]

{ #category : '*TFOperationModel',
 #vaCategories : ['Accessing'] }
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
 #vaCategories : ['Accessing'] }
TFTensor >> shapeDescription [

	^self shape description
]

{ #category : '*TFOperationModel',
 #vaCategories : ['Accessing'] }
TFTensor >> typeDescription [

	^self class descriptionOf: self type
]
