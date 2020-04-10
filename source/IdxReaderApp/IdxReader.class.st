"
THE IDX FILE FORMAT

the IDX file format is a simple format for vectors and multidimensional matrices of various numerical types.

The basic format is

magic number 
size in dimension 0 
size in dimension 1 
size in dimension 2 
..... 
size in dimension N 
data

The magic number is an integer (MSB first). The first 2 bytes are always 0.

The third byte codes the type of the data: 
0x08: unsigned byte 
0x09: signed byte 
0x0B: short (2 bytes) 
0x0C: int (4 bytes) 
0x0D: float (4 bytes) 
0x0E: double (8 bytes)

The 4-th byte codes the number of dimensions of the vector/matrix: 1 for vectors, 2 for matrices....

The sizes in each dimension are 4-byte integers (MSB first, high endian, like in most non-Intel processors).

The data is stored like in a C array, i.e. the index in the last dimension changes the fastest. 
"
Class {
	#name : 'IdxReader',
	#superclass : 'Object',
	#instVars : [
		'aStream',
		'dataType',
		'dimensions',
		'dimensionSizes'
	],
	#classVars : [
		'Types'
	],
	#category : 'IdxReaderApp'
}

{ #category : 'instance creation' }
IdxReader class >> new [

	^super new initialize
]

{ #category : 'instance-creation' }
IdxReader class >> onStream: aReadStream [

	
	^ self new
		readStream: aReadStream;
		setUp;
		yourself
]

{ #category : 'types' }
IdxReader class >> types [
	
	Types ifNil: [ 
		Types := Dictionary new.
		Types at: 8  put: IdxUnsignedByte new.
		Types at: 9  put: IdxSignedByte new.
		Types at: 10 put: IdxShort new.
		Types at: 11 put: IdxInt new.
		Types at: 12 put: IdxFloat new.
		Types at: 13 put: IdxDouble new ].
	^ Types
]

{ #category : 'testing' }
IdxReader >> atEnd [
	
	^ aStream atEnd
]

{ #category : 'data-type' }
IdxReader >> dataSize [
	
	self hasUnsignedByteData ifTrue: [ ^ 1 ].
	self hasSignedByteData ifTrue: [ ^ 1 ].
	self hasShortData ifTrue: [ ^ 2 ].
	self hasIntData ifTrue: [ ^ 4 ].
	self hasFloatData ifTrue: [ ^ 4 ].
	self hasDoubleData ifTrue: [ ^ 8 ].
	self error: 'Unimplemented data type'
]

{ #category : 'accessing' }
IdxReader >> dimensionSizes [
	
	^ dimensionSizes
]

{ #category : 'data-type' }
IdxReader >> hasDoubleData [
	
	^ dataType isDouble
]

{ #category : 'data-type' }
IdxReader >> hasFloatData [
	
	^ dataType isFloat
]

{ #category : 'data-type' }
IdxReader >> hasIntData [
	
	^ dataType isInt
]

{ #category : 'data-type' }
IdxReader >> hasShortData [
	
	^ dataType isShort
]

{ #category : 'data-type' }
IdxReader >> hasSignedByteData [
	
	^ dataType isSignedByte
]

{ #category : 'data-type' }
IdxReader >> hasUnsignedByteData [
	
	^ dataType isUnsignedByte
]

{ #category : 'reading' }
IdxReader >> next [
	
	^ self readDimensionSize: dimensionSizes first rest: dimensionSizes allButFirst
]

{ #category : 'accessing' }
IdxReader >> numberOfDimensions [
	
	^ dimensions
]

{ #category : 'setUp' }
IdxReader >> parseHeader [

	| readDataType |

	self assert: aStream next value = 0.
	self assert: aStream next value = 0.

	readDataType := aStream next value.
	self assert: (readDataType between: 8 and: 13).
	dataType :=
		self types
			at: readDataType value
			ifAbsent: [
				self error:
					('TypeTag "%1" not supported' bindWith: (Array with: readDataType asString))].

	dimensions := aStream next value.

	dimensionSizes := (1 to: dimensions) collect: [:index | self parseNextDimensionSize]
]

{ #category : 'setUp' }
IdxReader >> parseNextDimensionSize [
	
	"Dimensions are big endian 4 byte integers"
	^ (aStream next: 4) asByteArray longAt: 1 bigEndian: true
]

{ #category : 'reading' }
IdxReader >> readData: anInteger [

	
	^ (1 to: anInteger) collect: [ :index | self readNextItem ]
]

{ #category : 'reading' }
IdxReader >> readDimensionSize: anInteger rest: aCollection [

	
	^ aCollection
		ifEmpty: [ self readData: anInteger ]
		ifNotEmpty: [ 
			(1 to: anInteger) collect: [ :index |
				self readDimensionSize: aCollection first rest: aCollection allButFirst.
			] ]
]

{ #category : 'reading' }
IdxReader >> readNextItem [
	
	^ dataType readNextFrom: aStream
]

{ #category : 'accessing' }
IdxReader >> readStream: aReadStream [

	
	aStream := aReadStream
]

{ #category : 'setUp' }
IdxReader >> setUp [
	
	self parseHeader.
]

{ #category : 'data-type' }
IdxReader >> types [
	
	^ self class types
]
