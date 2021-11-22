Class {
	#name : 'TFTensor',
	#superclass : 'TFStructure',
	#category : 'TensorFlowCore'
}

{ #category : 'utils' }
TFTensor class >> copyArrayOf: type with: values into: anExternalAddressOrByteArray [

	| index |

	index := 0.
	values singleElementsDo: [:value |
		type put: value at: index in: anExternalAddressOrByteArray.
		index := index + 1]
]

{ #category : 'instance creation' }
TFTensor class >> fromBooleans: values [

	^self fromNumbers: values type: BooleanDataType new
]

{ #category : 'instance creation' }
TFTensor class >> fromDoubles: values [

	^self fromNumbers: values type: DoubleDataType new
]

{ #category : 'instance creation' }
TFTensor class >> fromDoubles: values shape: shape [

	^self fromNumbers: values type: DoubleDataType new shape: shape
]

{ #category : 'instance creation' }
TFTensor class >> fromFloats: values [

	^self fromNumbers: values type: FloatDataType new
]

{ #category : 'instance creation' }
TFTensor class >> fromFloats: values shape: shape [

	^self fromNumbers: values type: FloatDataType new shape: shape
]

{ #category : 'instance creation' }
TFTensor class >> fromInt32: value [
	^ self fromInt32s: value
]

{ #category : 'instance creation' }
TFTensor class >> fromInt32s: values [

	^self fromNumbers: values type: Int32DataType new
]

{ #category : 'instance creation' }
TFTensor class >> fromInt32s: values shape: shape [

	^self fromNumbers: values type: Int32DataType new shape: shape
]

{ #category : 'instance creation' }
TFTensor class >> fromInt64: value [
	^ self fromInt64s: value
]

{ #category : 'instance creation' }
TFTensor class >> fromInt64s: values [

	^self fromNumbers: values type: Int64DataType new
]

{ #category : 'instance creation' }
TFTensor class >> fromInt64s: values shape: shape [

	^self fromNumbers: values type: Int64DataType new shape: shape
]

{ #category : 'instance creation' }
TFTensor class >> fromNumbers: values type: type [

	^self fromNumbers: values type: type shape: values inferTensorShape
]

{ #category : 'instance creation' }
TFTensor class >> fromNumbers: values type: type shape: shape [

	| size count |

	size := values singleElementsInCollection.
	count := shape totalAmountOfElements.
	count = size ifFalse: [Error signal: 'Inferred size and real size don''t match.'].
	^self
		newTyped: type
		shaped: shape
		thenDo: [:tensor | self copyArrayOf: type with: values into: tensor data]
]

{ #category : 'instance creation' }
TFTensor class >> fromString: aString [
	
	^ TensorFlowCAPI current tensorFromString: aString
]

{ #category : 'instance creation' }
TFTensor class >> fromStringArray: aStringArray [

	^self fromStrings: aStringArray shape: (TensorShape vectorSized: aStringArray size)
]

{ #category : 'instance creation' }
TFTensor class >> fromStringArray: aStringArray shape: shape [

	^ TensorFlowCAPI current tensorFromStrings: aStringArray shaped: shape
]

{ #category : 'instance creation' }
TFTensor class >> fromStrings: aStringArray [

	^self fromStrings: aStringArray shape: aStringArray inferTensorShape
]

{ #category : 'instance creation' }
TFTensor class >> fromStrings: strings shape: shape [

	| flatten |

	flatten :=
		Array
			new: strings singleElementsInCollection
			streamContents: [:stream | strings singleElementsDo: [:each | stream nextPut: each]].
	^self fromStringArray: flatten shape: shape
]

{ #category : 'Startup/Shutdown',
  #vaVisibility : 'private' }
TFTensor class >> initializeAfterLoad [
	"Set an opaque layout."

	self initializeOpaqueLayout
]

{ #category : 'instance creation' }
TFTensor class >> new [

	^super new initialize
]

{ #category : 'instance creation' }
TFTensor class >> newTyped: anInteger shaped: aTensorShape [

	^ self newTyped: anInteger shaped: aTensorShape thenDo: [ :tensor | ]
]

{ #category : 'instance creation' }
TFTensor class >> newTyped: aTensorType shaped: aTensorShape bytesize: bytesizeInteger thenDo: aBlock [


	| tensor |

	tensor := TensorFlowCAPI current
		allocateTensorOf: ( TensorDomain of: aTensorType withShape: aTensorShape )
		length: bytesizeInteger.
	aBlock value: tensor.
	^ tensor
]

{ #category : 'instance creation' }
TFTensor class >> newTyped: aDataType shaped: aTensorShape thenDo: aBlock [
	" I understand dimenssions are:
		#()		-> Scalar
		#(7)		-> Unidimensional array of 7 elements
		#(7 4)		-> 7x4 elements matrix
		#(2 5 9)	-> 2x5x9 elements cube
		etc.
	"

	| bytesize |

	bytesize := aTensorShape totalAmountOfElements * aDataType dataSize.
	^self newTyped: aDataType shaped: aTensorShape bytesize: bytesize thenDo: aBlock
]

{ #category : 'instance creation' }
TFTensor class >> pi [
	^ Float pi asTensor
]

{ #category : 'converting' }
TFTensor >> allElements [
	^ self asStream contents
]

{ #category : 'converting' }
TFTensor >> allFloats [
	^ self allElements
]

{ #category : 'converting' }
TFTensor >> allInt32s [
	^ self allElements
]

{ #category : 'converting' }
TFTensor >> allInt64s [
	^ self allElements
]

{ #category : 'converting' }
TFTensor >> allStrings [

	^ self library allStringsOf: self
]

{ #category : 'converting' }
TFTensor >> arrayFromStream: strm shape: shape [

	^shape representsScalar
		ifTrue: [strm next]
		ifFalse: [| first tail |
			first := shape dimensionSizes first.
			tail := TensorShape withDimensionsSized: shape dimensionSizes allButFirst.
			Array streamContents: [:answer |
				first timesRepeat: [| next |
					next := self arrayFromStream: strm shape: tail.
					answer nextPut: next]]]
]

{ #category : 'converting' }
TFTensor >> asNumbers [
	^ self arrayFromStream: self asStream shape: self shape
]

{ #category : 'converting' }
TFTensor >> asStream [
	| answer |
	answer := ReadWriteStream on: (Array new: self size).
	self elementsDo: [ :each | answer nextPut: each ].
	^ answer reset
]

{ #category : 'converting' }
TFTensor >> asTensor [

	^ self
]

{ #category : 'release' }
TFTensor >> basicDelete [
	self library deleteTensor: self
]

{ #category : 'accessing' }
TFTensor >> byteSize [
	^ self library tensorByteSize: self
]

{ #category : 'accessing' }
TFTensor >> data [
	
	^ self library tensorDataOf: self
]

{ #category : 'accessing' }
TFTensor >> dataBytes [
	^ self data byteArrayAt: 0 size: self byteSize
]

{ #category : 'iterating' }
TFTensor >> elementsDo: oneArgBlock [

	| data |

	data := self data.
	1 to: self size do: [:i | oneArgBlock value: (self type getElementAt: i in: data)]
]

{ #category : 'accessing' }
TFTensor >> elementSize [

	^self type dataSize
]

{ #category : 'Memory Management' }
TFTensor >> free [
	"Destroy a Tensor"

	self basicDelete. 
	self makeUndefined
]

{ #category : 'accessing' }
TFTensor >> numBytes [

	^self byteSize
]

{ #category : 'accessing' }
TFTensor >> rank [
	^ self library tensorRank: self
]

{ #category : 'accessing' }
TFTensor >> scalarOutput [

	self isScalar ifTrue: [^self allElements any].

	AssertionFailure signal: 'This tensor is not a scalar'
]

{ #category : 'accessing' }
TFTensor >> shape [

	| answer count |

	count := self rank.
	answer := WriteStream on: (Array new: count).
	1 to: count do: [:i | answer nextPut: (self sizeOn: i - 1)].
	^TensorShape withDimensionsSized: answer contents
]

{ #category : 'accessing' }
TFTensor >> size [

	^self shape totalAmountOfElements
]

{ #category : 'accessing' }
TFTensor >> sizeOn: dimension [
	^ self library tensor: self sizeOn: dimension
]

{ #category : 'accessing' }
TFTensor >> type [

	^ self library tensorType: self
]
