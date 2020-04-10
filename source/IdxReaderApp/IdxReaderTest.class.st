Class {
	#name : 'IdxReaderTest',
	#superclass : 'TestCase',
	#category : 'IdxReaderApp'
}

{ #category : 'instance creation' }
IdxReaderTest class >> new [

	^super new initialize
]

{ #category : 'tests-reading' }
IdxReaderTest >> testAtEnd [

	| stream |
	stream := IdxReader onStream: (#[ 0 0 9 3 0 0 0 5 0 0 0 7 0 0 0 28 ] readStream).
	self assert: stream atEnd
]

{ #category : 'tests' }
IdxReaderTest >> testDimensionSizes [

	| stream |
	stream := IdxReader onStream: (#[ 0 0 9 3 0 0 0 5 0 0 0 7 0 0 0 28 ] readStream).
	self assert: stream dimensionSizes first equals: 5.
	self assert: stream dimensionSizes second equals: 7.
	self assert: stream dimensionSizes third equals: 28.
]

{ #category : 'tests' }
IdxReaderTest >> testFourthHeaderByteEncodesNumberOfDimensions [

	| stream |
	stream := IdxReader onStream: (#[ 0 0 9 3 0 0 0 0 0 0 0 0 0 0 0 0 ] readStream).
	self assert: stream numberOfDimensions equals: 3.
]

{ #category : 'tests' }
IdxReaderTest >> testIdxStreamShouldFailIfFirstTwoBytesAreNotZero [

	self should: [IdxReader onStream: (#[ 1 0 ] readStream)] raise: AssertionFailure.
	self should: [IdxReader onStream: (#[ 0 1 ] readStream)] raise: AssertionFailure
]

{ #category : 'tests' }
IdxReaderTest >> testIdxStreamShouldNotFailIfFirstTwoBytesAreZero [

	"This should not fail"
	IdxReader onStream: (#[ 0 0 9 0 ] readStream)
]

{ #category : 'tests-reading' }
IdxReaderTest >> testNextDouble [

	| stream matrix |
	stream := IdxReader onStream: (#[ 0 0 13 2 0 0 0 1 0 0 0 2 63 240 0 0 0 0 0 0 191 240 0 0 0 0 0 0 ] readStream).
	matrix := stream next.

	self assert: ((matrix at: 1) at: 1) equals: 1.0.
	self assert: ((matrix at: 1) at: 2) equals: -1.0.
]

{ #category : 'tests-reading' }
IdxReaderTest >> testNextFloat [

	| stream matrix |
	stream := IdxReader onStream: (#[ 0 0 12 2 0 0 0 1 0 0 0 2 63 128 0 0 191 128 0 0 ] readStream).
	matrix := stream next.
	
	self assert: ((matrix at: 1) at: 1) equals: 1.0.
	self assert: ((matrix at: 1) at: 2) equals: -1.0.
]

{ #category : 'tests-reading' }
IdxReaderTest >> testNextInt [

	| stream matrix |
	stream := IdxReader onStream: (#[ 0 0 11 2 0 0 0 1 0 0 0 2 0 0 0 1 255 255 255 255 ] readStream).
	matrix := stream next.
	
	self assert: ((matrix at: 1) at: 1) equals: 1.
	self assert: ((matrix at: 1) at: 2) equals: -1.
]

{ #category : 'tests-reading' }
IdxReaderTest >> testNextShort [

	| stream matrix |
	stream := IdxReader onStream: (#[ 0 0 10 2 0 0 0 2 0 0 0 2 0 1 1 1 255 1 255 255 ] readStream).
	matrix := stream next.
	
	self assert: ((matrix at: 1) at: 1) equals: 1.
	self assert: ((matrix at: 1) at: 2) equals: 257.
	self assert: ((matrix at: 2) at: 1) equals: -255.
	self assert: ((matrix at: 2) at: 2) equals: -1.
]

{ #category : 'tests-reading' }
IdxReaderTest >> testNextSignedByte [

	| stream matrix |
	stream := IdxReader onStream: (#[ 0 0 9 2 0 0 0 2 0 0 0 2 129 255 1 2 129 255 1 2 ] readStream).
	matrix := stream next.
	
	self assert: ((matrix at: 1) at: 1) equals: -127.
	self assert: ((matrix at: 1) at: 2) equals: -1.
	self assert: ((matrix at: 2) at: 1) equals: 1.
	self assert: ((matrix at: 2) at: 2) equals: 2.
	
	matrix := stream next.
	
	self assert: ((matrix at: 1) at: 1) equals: -127.
	self assert: ((matrix at: 1) at: 2) equals: -1.
	self assert: ((matrix at: 2) at: 1) equals: 1.
	self assert: ((matrix at: 2) at: 2) equals: 2.
]

{ #category : 'tests-reading' }
IdxReaderTest >> testNextUnsignedByte [

	| stream matrix |
	stream := IdxReader onStream: (#[ 0 0 8 2 0 0 0 2 0 0 0 2 1 2 3 4 5 6 7 8 ] readStream).
	matrix := stream next.
	
	self assert: ((matrix at: 1) at: 1) equals: 1.
	self assert: ((matrix at: 1) at: 2) equals: 2.
	self assert: ((matrix at: 2) at: 1) equals: 3.
	self assert: ((matrix at: 2) at: 2) equals: 4.
	
	matrix := stream next.
	
	self assert: ((matrix at: 1) at: 1) equals: 5.
	self assert: ((matrix at: 1) at: 2) equals: 6.
	self assert: ((matrix at: 2) at: 1) equals: 7.
	self assert: ((matrix at: 2) at: 2) equals: 8.
]

{ #category : 'tests-reading' }
IdxReaderTest >> testNotAtEnd [

	| stream |
	stream := IdxReader onStream: (#[ 0 0 9 3 0 0 0 5 0 0 0 7 0 0 0 28 1 1 1 ] readStream).
	self deny: stream atEnd
]

{ #category : 'tests-type' }
IdxReaderTest >> testThirdHeaderByteEncodesDouble [

	| stream |
	stream := IdxReader onStream: (#[ 0 0 13 0 ] readStream).
	self assert: stream hasDoubleData.
	self assert: stream dataSize equals: 8.
]

{ #category : 'tests-type' }
IdxReaderTest >> testThirdHeaderByteEncodesFloat [

	| stream |
	stream := IdxReader onStream: (#[ 0 0 12 0 ] readStream).
	self assert: stream hasFloatData.
	self assert: stream dataSize equals: 4.
]

{ #category : 'tests-type' }
IdxReaderTest >> testThirdHeaderByteEncodesInt [

	| stream |
	stream := IdxReader onStream: (#[ 0 0 11 0 ] readStream).
	self assert: stream hasIntData.
	self assert: stream dataSize equals: 4.
]

{ #category : 'tests-type' }
IdxReaderTest >> testThirdHeaderByteEncodesShort [

	| stream |
	stream := IdxReader onStream: (#[ 0 0 10 0 ] readStream).
	self assert: stream hasShortData.
	self assert: stream dataSize equals: 2.
]

{ #category : 'tests-type' }
IdxReaderTest >> testThirdHeaderByteEncodesSignedByte [

	| stream |
	stream := IdxReader onStream: (#[ 0 0 9 0 ] readStream).
	self assert: stream hasSignedByteData.
	self assert: stream dataSize equals: 1.
]

{ #category : 'tests-type' }
IdxReaderTest >> testThirdHeaderByteEncodesUnsignedByte [

	| stream |
	stream := IdxReader onStream: (#[ 0 0 8 0 ] readStream).
	self assert: stream hasUnsignedByteData.
	self assert: stream dataSize equals: 1.
]
