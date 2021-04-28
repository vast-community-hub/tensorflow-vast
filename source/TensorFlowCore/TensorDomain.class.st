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
		of: TFTensor typeFloat
		withShape: (TensorShape matrixSized: aNumberOfRows by: aNumberOfColumns)
]

{ #category : 'Instance Creation' }
TensorDomain class >> ofFloatScalar [

	^self of: TFTensor typeFloat withShape: TensorShape scalar
]

{ #category : 'Instance Creation' }
TensorDomain class >> ofFloatVectorSized: anInteger [

	^self of: TFTensor typeFloat withShape: (TensorShape vectorSized: anInteger)
]

{ #category : 'Instance Creation' }
TensorDomain class >> ofIntegerScalar [

	^self of: TFTensor typeInt32 withShape: TensorShape scalar
]

{ #category : 'Instance Creation' }
TensorDomain class >> ofLargeIntegerScalar [

	^self of: TFTensor typeInt64 withShape: TensorShape scalar
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
		nextPutAll: (TFTensor descriptionOf: type);
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

	^TensorDomain
		of: self type
		withShape: (TensorShape withDimensionsSized: self shape dimensionSizes allButFirst)
]
