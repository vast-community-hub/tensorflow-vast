Extension {
	#name : 'TFTensor'
}

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['utils'] }
TFTensor class >> array: values type: type into: anExternalAddressOrByteArray [
	| size index setter |
	size := self sizeForType: type.
	setter := self setterBlockFor: type.
	index := 0.
	self
		elementsOf: values
		do: [ :value | 
			setter
				value: anExternalAddressOrByteArray
				value: index * size + 1
				value: value.
			index := index + 1 ]
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['utils'] }
TFTensor class >> elementsOf: aMultidimensionalTensor [
	| answer |
	answer := (Array new: (self sizeOf: aMultidimensionalTensor))
		writeStream.
	self
		elementsOf: aMultidimensionalTensor
		do: [ :each | answer nextPut: each ].
	^ answer contents
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['utils'] }
TFTensor class >> elementsOf: tensorArray do: oneArgBlock [
	^ (tensorArray isCollection and: [ tensorArray isString not ])
		ifTrue: [ tensorArray do: [ :each | self elementsOf: each do: oneArgBlock ] ]
		ifFalse: [ oneArgBlock value: tensorArray ]
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['instance creation'] }
TFTensor class >> fromBooleans: values [
	^ self fromNumbers: values type: self typeBoolean
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['instance creation'] }
TFTensor class >> fromBools: values shape: shape [
	^ self fromNumbers: values type: self typeBoolean shape: shape
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['instance creation'] }
TFTensor class >> fromDoubles: values [
	^ self fromNumbers: values type: self typeDouble
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['instance creation'] }
TFTensor class >> fromDoubles: values shape: shape [
	^ self fromNumbers: values type: self typeDouble shape: shape
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['instance creation'] }
TFTensor class >> fromFloats: values [
	^ self fromNumbers: values type: self typeFloat
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['instance creation'] }
TFTensor class >> fromFloats: values shape: shape [
	^ self fromNumbers: values type: self typeFloat shape: shape
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['instance creation'] }
TFTensor class >> fromInt32: value [
	^ self fromInt32s: value
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['instance creation'] }
TFTensor class >> fromInt32s: values [
	^ self fromNumbers: values type: self typeInt32
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['instance creation'] }
TFTensor class >> fromInt32s: values shape: shape [
	^ self fromNumbers: values type: self typeInt32 shape: shape
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['instance creation'] }
TFTensor class >> fromInt64: value [
	^ self fromInt64s: value
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['instance creation'] }
TFTensor class >> fromInt64s: values [
	^ self fromNumbers: values type: self typeInt64
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['instance creation'] }
TFTensor class >> fromInt64s: values shape: shape [
	^ self fromNumbers: values type: self typeInt64 shape: shape
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['instance creation'] }
TFTensor class >> fromNumbers: values type: type [
	| shape |
	shape := self shapeOf: values.
	^ self fromNumbers: values type: type shape: shape
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['instance creation'] }
TFTensor class >> fromNumbers: values type: type shape: shape [
	| answer size count |
	size := self sizeOf: values.
	count := shape totalAmountOfElements.
	count = size
		ifFalse: [ Error signal: 'Inferred size and real size don''t match.' ].
	answer := self type: type shape: shape.
	self array: values type: type into: answer data.
	^ answer
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['instance creation'] }
TFTensor class >> fromString: aString [
	| answer bytesize |
	bytesize := TensorFlowCAPI current stringEncodedSize: aString.
	answer := self type: self typeString shape: TensorShape scalar bytesize: bytesize.
	TensorFlowCAPI current
		stringEncode: aString
		to: answer data
		size: bytesize.
	^ answer
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['instance creation'] }
TFTensor class >> fromStringArray: aStringArray [

	^self fromStrings: aStringArray shape: (TensorShape vectorSized: aStringArray size)
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['instance creation'] }
TFTensor class >> fromStringArray: aStringArray shape: shape [
	| answer sizes offsets offsetSize bytesize |
	sizes := aStringArray collect: [ :each | self sizeOfString: each ].
	offsetSize := self sizeForType: self typeInt64.
	bytesize := offsetSize * aStringArray size + sizes sum.
	offsets := OrderedCollection new: sizes size.
	sizes
		inject: 0
		into: [ :prev :each | 
			offsets add: prev.
			each + prev ].
	answer := self type: self typeString shape: shape bytesize: bytesize.
	self int64Array: offsets into: answer data.
	1 to: aStringArray size do: [:index |
			| offset |
			offset := offsetSize * aStringArray size + (offsets at: index).
			TensorFlowCAPI current
				stringEncode: (aStringArray at: index)
				to: answer data + offset
				size: bytesize - offset ].
	^ answer
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['instance creation'] }
TFTensor class >> fromStrings: aStringArray [

	^self
		fromStrings: aStringArray
		shape: (self shapeOf: aStringArray) dimensionSizes allButLast asTensorShape
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['instance creation'] }
TFTensor class >> fromStrings: strings shape: shape [
	| flatten |
	flatten := self elementsOf: strings.
	^ self fromStringArray: flatten shape: shape
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['instance creation'] }
TFTensor class >> fromVariants: value [

	| shape |

	shape := self shapeOf: value.
	^self fromNumbers: value type: self typeVariant shape: shape
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['types'] }
TFTensor class >> getterBlockFor: type [

	self typeInt32 = type ifTrue: [^[:data :offset | data int32At: offset - 1]].
	self typeInt64 = type ifTrue: [^[:data :offset | data int64At: offset - 1]].
	self typeFloat = type ifTrue: [^[:data :offset | data float32At: offset - 1]].
	self typeDouble = type ifTrue: [^[:data :offset | data float64At: offset - 1]].
	self typeBoolean = type ifTrue: [^[:data :offset | data bool8At: offset - 1]].
	self typeUInt8 = type ifTrue: [^[:data :offset | data uint8At: offset - 1]].
	^self shouldBeImplemented


]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['utils'] }
TFTensor class >> int64Array: values into: anExternalAddressOrByteArray [
	self
		array: values
		type: self typeInt64
		into: anExternalAddressOrByteArray
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['instance creation'] }
TFTensor class >> new [

	^super new initialize
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['instance creation'] }
TFTensor class >> pi [
	^ Float pi asTensor
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['utils'] }
TFTensor class >> rankOf: aMultidimensionalTensor [
	^ aMultidimensionalTensor isCollection
		ifTrue: [ 1 + (self rankOf: aMultidimensionalTensor first) ]
		ifFalse: [ 0 ]
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['types'] }
TFTensor class >> setterBlockFor: type [

	self typeInt32 = type ifTrue: [^[:data :offset :value | data int32At: offset - 1 put: value]].
	self typeInt64 = type ifTrue: [^[:data :offset :value | data int64At: offset - 1 put: value]].
	self typeFloat = type
		ifTrue: [^[:data :offset :value | data float32At: offset - 1 put: value asFloat]].
	self typeDouble = type ifTrue: [^[:data :offset :value | data float64At: offset - 1 put: value]].
	self typeBoolean = type ifTrue: [^[:data :offset :value | data bool8At: offset - 1 put: value]].
	self typeUInt8 = type ifTrue: [^[:data :offset :value | data uint8At: offset - 1 put: value]].
	self typeVariant = type
		ifTrue: [
			^[:data :offset :value |
				data pointerAt: (offset - 1) * ExternalWordArray fixedSize put: value]].
	^self shouldBeImplemented
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['utils'] }
TFTensor class >> shapeOf: aMultidimensionalTensor [

	^aMultidimensionalTensor isCollection
		ifTrue: [
			aMultidimensionalTensor isEmpty
				ifTrue: [TensorShape vectorSized: 0]
				ifFalse: [
					TensorShape withDimensionsSized: (
						(Array with: aMultidimensionalTensor size) ,
							(self shapeOf: aMultidimensionalTensor first) dimensionSizes)]]
		ifFalse: [TensorShape scalar]
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['types'] }
TFTensor class >> sizeForType: aTypeNumber [

	^TensorFlowCAPI current sizeOfDataType: aTypeNumber
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['utils'] }
TFTensor class >> sizeOf: aMultidimensionalTensor [
	^ aMultidimensionalTensor isCollection
		ifTrue: [ aMultidimensionalTensor isEmpty
				ifTrue: [ 0 ]
				ifFalse: [ aMultidimensionalTensor inject: 0 into: [:prev :each | prev + (self sizeOf: each) ] ] ]
		ifFalse: [ 1 ]
		
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['utils'] }
TFTensor class >> sizeOfString: aString [
	^ TensorFlowCAPI current stringEncodedSize: aString
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['instance creation'] }
TFTensor class >> type: anInteger shape: aTensorShape [
	" I understand dimenssions are:
		#()		-> Scalar
		#(7)		-> Unidimensional array of 7 elements
		#(7 4)		-> 7x4 elements matrix
		#(2 5 9)	-> 2x5x9 elements cube
		etc.
	"

	| bytesize elementSize |
	elementSize := self sizeForType: anInteger.
	bytesize := aTensorShape totalAmountOfElements * elementSize.
	^ self type: anInteger shape: aTensorShape bytesize: bytesize
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['instance creation'] }
TFTensor class >> type: anInteger shape: anIntegerArray bytesize: bytesizeInteger [
	" I understand dimenssions are:
		#()		-> Scalar
		#(7)		-> Unidimensional array of 7 elements
		#(7 4)		-> 7x4 elements matrix
		#(2 5 9)	-> 2x5x9 elements cube
		etc.
	"

	| externalized answer |
	externalized := anIntegerArray asInt64Array.
	answer := TensorFlowCAPI current
		allocateTensorType: anInteger
		shape: externalized
		rank: anIntegerArray size
		length: bytesizeInteger.
	answer useFinalization.
	^ answer
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['types'] }
TFTensor class >> typeBFloat16 [
	^ 14
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['types'] }
TFTensor class >> typeBoolean [
	^ 10
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['types'] }
TFTensor class >> typeComplex128 [
	^ 18
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['types'] }
TFTensor class >> typeComplex64 [
	^ 8
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['types'] }
TFTensor class >> typeDouble [
	^ 2
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['types'] }
TFTensor class >> typeFloat [
	^ 1
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['types'] }
TFTensor class >> typeHalf [
	^ 19
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['types'] }
TFTensor class >> typeInt16 [
	^ 5
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['types'] }
TFTensor class >> typeInt32 [
	^ 3
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['types'] }
TFTensor class >> typeInt64 [
	^ 9
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['types'] }
TFTensor class >> typeInt8 [
	^ 6
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['types'] }
TFTensor class >> typeQInt16 [
	^ 15
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['types'] }
TFTensor class >> typeQInt32 [
	^ 13
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['types'] }
TFTensor class >> typeQInt8 [
	^ 11
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['types'] }
TFTensor class >> typeQUInt16 [
	^ 16
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['types'] }
TFTensor class >> typeQUInt8 [
	^ 12
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['types'] }
TFTensor class >> typeResource [
	^ 20
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['types'] }
TFTensor class >> typeString [
	^ 7
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['types'] }
TFTensor class >> typeUInt16 [
	^ 17
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['types'] }
TFTensor class >> typeUInt8 [
	^ 4
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['types'] }
TFTensor class >> typeVariant [
	^21
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['converting'] }
TFTensor >> allElements [
	^ self asStream contents
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['converting'] }
TFTensor >> allFloats [
	^ self allElements
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['converting'] }
TFTensor >> allInt32s [
	^ self allElements
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['converting'] }
TFTensor >> allInt64s [
	^ self allElements
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['converting'] }
TFTensor >> allStrings [
	| total answer bytes data |
	total := self size.
	answer := WriteStream on: (Array new: total).
	bytes := self dataBytes.
	1 to: total do: [ :i | 
		| offset str |
		offset := bytes uint64At: (i - 1) * 8.
		data := bytes copyFrom: 8 * total + 1 + offset to: bytes size.
		str := self library stringDecode: data.
		answer nextPut: str ].
	^ answer contents
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['converting'] }
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

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['converting'] }
TFTensor >> asNumbers [
	^ self arrayFromStream: self asStream shape: self shape
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['converting'] }
TFTensor >> asOperationOn: aTFGraph [
	^ aTFGraph const: self
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['converting'] }
TFTensor >> asStream [
	| answer |
	answer := ReadWriteStream on: (Array new: self size).
	self elementsDo: [ :each | answer nextPut: each ].
	^ answer reset
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['converting'] }
TFTensor >> asTensor [

	^ self
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['release'] }
TFTensor >> basicDelete [
	self library deleteTensor: self
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['accessing'] }
TFTensor >> byteSize [
	^ self library tensorByteSize: self
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['iterating'] }
TFTensor >> dataAndOffsetsCollect: twoArgsBlock thenDo: oneArgBlock [
	| data elementSize |
	elementSize := self elementSize.
	data := self data.
	1 to: self size do: [ :i | 
		| value |
		value := twoArgsBlock value: data value: (i - 1) * elementSize + 1.
		oneArgBlock value: value ]
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['accessing'] }
TFTensor >> dataBytes [
	^ self data byteArrayAt: 0 size: self byteSize
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['iterating'] }
TFTensor >> elementsDo: oneArgBlock [
	self dataAndOffsetsCollect: self getterBlock thenDo: oneArgBlock
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['accessing'] }
TFTensor >> elementSize [
	^ self class sizeForType: self type
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['iterating'] }
TFTensor >> getterBlock [
	^ self class getterBlockFor: self type
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['accessing'] }
TFTensor >> rank [
	^ self library tensorRank: self
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['Accessing'] }
TFTensor >> scalarOutput [

	self isScalar ifTrue: [^self allElements any].

	AssertionFailure signal: 'This tensor is not a scalar'
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['accessing'] }
TFTensor >> shape [

	| answer count |

	count := self rank.
	answer := WriteStream on: (Array new: count).
	1 to: count do: [:i | answer nextPut: (self sizeOn: i - 1)].
	^TensorShape withDimensionsSized: answer contents
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['accessing'] }
TFTensor >> size [

	^self shape totalAmountOfElements
]

{ #category : '*TensorFlowKernelApp',
 #vaCategories : ['accessing'] }
TFTensor >> sizeOn: dimension [
	^ self library tensor: self sizeOn: dimension
]
