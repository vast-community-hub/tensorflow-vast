Class {
	#name : 'TFTensor',
	#superclass : 'TFStructure',
	#category : 'TensorFlowCore'
}

{ #category : 'utils',
  #vaVisibility : 'private' }
TFTensor class >> copyArrayOf: type with: values into: anExternalAddressOrByteArray [

	| index |

	index := 0.
	values singleElementsDo: [:value |
		type put: value at: index in: anExternalAddressOrByteArray.
		index := index + 1]
]

{ #category : 'instance creation' }
TFTensor class >> fromBooleans: values [

	^self newTyped: BooleanDataType new containing: values
]

{ #category : 'instance creation' }
TFTensor class >> fromDoubles: values [

	^self newTyped: DoubleDataType new containing: values
]

{ #category : 'instance creation' }
TFTensor class >> fromDoubles: values shape: shape [

	^self newTyped: DoubleDataType new shaped: shape containing: values
]

{ #category : 'instance creation' }
TFTensor class >> fromFloats: values [

	^self newTyped: FloatDataType new containing: values
]

{ #category : 'instance creation' }
TFTensor class >> fromFloats: values shape: shape [

	^self newTyped: FloatDataType new shaped: shape containing: values
]

{ #category : 'instance creation' }
TFTensor class >> fromInt32: value [
	^ self fromInt32s: value
]

{ #category : 'instance creation' }
TFTensor class >> fromInt32s: values [

	^self newTyped: Int32DataType new containing: values
]

{ #category : 'instance creation' }
TFTensor class >> fromInt32s: values shape: shape [

	^self newTyped: Int32DataType new shaped: shape containing: values
]

{ #category : 'instance creation' }
TFTensor class >> fromInt64: value [
	^ self fromInt64s: value
]

{ #category : 'instance creation' }
TFTensor class >> fromInt64s: values [

	^self newTyped: Int64DataType new containing: values
]

{ #category : 'instance creation' }
TFTensor class >> fromInt64s: values shape: shape [

	^self newTyped: Int64DataType new shaped: shape containing: values
]

{ #category : 'instance creation' }
TFTensor class >> fromStrings: aStringArray [

	^self fromStrings: aStringArray shape: aStringArray inferTensorShape
]

{ #category : 'instance creation' }
TFTensor class >> fromStrings: aStringArray shape: shape [

	| flatten |

	flatten :=
		Array
			new: aStringArray singleElementsInCollection
			streamContents: [:stream | aStringArray singleElementsDo: [:each | stream nextPut: each]].
	^self newTyped: StringDataType new shaped: shape containing: flatten
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
TFTensor class >> newTyped: type containing: values [

	^self newTyped: type shaped: values inferTensorShape containing: values
]

{ #category : 'instance creation' }
TFTensor class >> newTyped: anInteger shaped: aTensorShape [

	^ self newTyped: anInteger shaped: aTensorShape thenDo: [ :tensor | ]
]

{ #category : 'instance creation' }
TFTensor class >> newTyped: type shaped: shape containing: values [

	| size count |

	size := values singleElementsInCollection.
	count := shape totalAmountOfElements.
	count = size ifFalse: [Error signal: 'Inferred size and real size don''t match.'].
	^self
		newTyped: type
		shaped: shape
		thenDo: [:tensor | self copyArrayOf: type with: values into: tensor data]
]

{ #category : 'instance creation',
  #vaVisibility : 'private' }
TFTensor class >> newTyped: aDataType shaped: aTensorShape thenDo: aBlock [

	| tensor |

	tensor :=
		TensorFlowCAPI current
			allocateTensorOf: (TensorDomain of: aDataType withShape: aTensorShape)
			length: aTensorShape totalAmountOfElements * aDataType dataSize.
	aBlock value: tensor.
	^tensor
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

	^self allElements collect: #content
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

{ #category : 'accessing',
  #vaVisibility : 'private' }
TFTensor >> isScalar [
	^self rank = 0
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
