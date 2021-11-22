Class {
	#name : 'TensorDomain',
	#superclass : 'Object',
	#instVars : [
		'type',
		'shape'
	],
	#category : 'TensorFlowCore'
}

{ #category : 'Instance Creation' }
TensorDomain class >> of: aTensorType withShape: aTensorShape [

	^self new initializeOf: aTensorType withShape: aTensorShape
]

{ #category : 'Instance Creation' }
TensorDomain class >> ofFloatMatrixSized: aNumberOfRows by: aNumberOfColumns [

	^self
		of: FloatDataType new
		withShape: (TensorShape matrixSized: aNumberOfRows by: aNumberOfColumns)
]

{ #category : 'Instance Creation' }
TensorDomain class >> ofFloatScalar [

	^self of: FloatDataType new withShape: TensorShape scalar
]

{ #category : 'Instance Creation' }
TensorDomain class >> ofFloatVectorSized: anInteger [

	^self of: FloatDataType new withShape: (TensorShape vectorSized: anInteger)
]

{ #category : 'Instance Creation' }
TensorDomain class >> ofIntegerScalar [

	^self of: Int32DataType new withShape: TensorShape scalar
]

{ #category : 'Instance Creation' }
TensorDomain class >> ofLargeIntegerScalar [

	^self of: Int64DataType new withShape: TensorShape scalar
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
TensorDomain >> initializeOf: aTensorType withShape: aTensorShape [

	type := aTensorType.
	shape := aTensorShape
]

{ #category : 'Printing' }
TensorDomain >> printOn: aStream [

	aStream
		nextPutAll: type description;
		space;
		print: shape
]

{ #category : 'Accessing' }
TensorDomain >> shape [

	^shape
]

{ #category : 'Accessing' }
TensorDomain >> type [

	^type
]

{ #category : 'Accessing' }
TensorDomain >> withNewUnknownDimension [

	^TensorDomain
		of: self type
		withShape: (
			TensorShape withDimensionsSized: (
				OrderedCollection new
					add: -1;
					addAll: self shape dimensionSizes;
					asArray))
]

{ #category : 'Accessing' }
TensorDomain >> withSlicedShape [

	self shape representsScalar
		ifTrue: [ AssertionFailure signal: 'A scalar shaped can''t be sliced' ].

	^ TensorDomain
		of: self type
		withShape: ( TensorShape withDimensionsSized: self shape dimensionSizes allButFirst )
]
