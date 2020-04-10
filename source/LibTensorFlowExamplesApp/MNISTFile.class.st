Class {
	#name : 'MNISTFile',
	#superclass : 'Object',
	#instVars : [
		'count',
		'items'
	],
	#category : 'LibTensorFlowExamplesApp'
}

{ #category : 'private' }
MNISTFile class >> download: aName [
"The following source failed to compile (all double quotes have been doubled):

	| datasetURL outputFileName |
	datasetURL := 'http://yann.lecun.com/exdb/mnist/' , aName.
	outputFileName := 'dataset/' , aName.
	FileSystem disk workingDirectory fileSystem ensureCreateDirectory: 'dataset'.
	UIManager default
		informUserDuring: [ :bar | 
			bar label: 'Downloading MNIST dataset ...'.
			[ ZnClient new
				url: datasetURL;
				signalProgress: true;
				downloadTo: outputFileName ]
				on: HTTPProgress
				do: [ :progress | 
					progress isEmpty
						ifFalse: [ bar current: progress percentage.
							progress total
								ifNotNil: [ :aTotalNumber | 
									| humanReadable |
									humanReadable := self printHumanReadableSize: aTotalNumber.
									bar label: 'Downloading ' , humanReadable , ' of MNIST dataset ... ' ] ].
					progress resume ] ].
	^ outputFileName asFileReference
"

	^ self halt: 'The source for this method failed to compile'
]

{ #category : 'instance creation' }
MNISTFile class >> fromFile: aString [

	| file filename reader |

	filename := aString , '.gz'.
	file := ('examples/' , filename) asPath.
	file exists ifFalse: [AssertionFailure signal: (#'Can''t find %1' bindWith: file asString)].
	file readStreamDo: [:compressed |
		reader := IdxReader onStream: compressed contents gzipDecompress readStream.
		^self fromReader: reader]
]

{ #category : 'instance creation' }
MNISTFile class >> fromReader: aReader [
	| answer |
	answer := self new.
	^ answer parse: aReader
]

{ #category : 'instance creation' }
MNISTFile class >> new [

	^super new initialize
]

{ #category : 'private' }
MNISTFile class >> printHumanReadableSize: aTotalNumber [
	| humanReadable length unit |
	length := ((aTotalNumber decimalDigitLength / 3) truncated) - 1 max: 0.
	humanReadable := (aTotalNumber / (1024 raisedTo: (length min: 3))) rounded.
	length = 0 ifTrue: [ unit := 'bytes' ].
	length = 1 ifTrue: [ unit := 'KB' ].
	length = 2 ifTrue: [ unit := 'MB' ].
	length = 3 ifTrue: [ unit := 'GB' ].
	^ humanReadable printString, ' ', unit
]

{ #category : 'accessing' }
MNISTFile class >> testName [
	^ self subclassResponsibility 
]

{ #category : 'instance creation' }
MNISTFile class >> testSet [
	^self fromFile: self testName
	
]

{ #category : 'instance creation' }
MNISTFile class >> trainingSet [
	^self fromFile: self trainName
	
]

{ #category : 'accessing' }
MNISTFile class >> trainName [
	^ self subclassResponsibility 
]

{ #category : 'converting' }
MNISTFile >> asTensor [
	^ self subclassResponsibility 
]

{ #category : 'accessing' }
MNISTFile >> count [
	^ count
]

{ #category : 'accessing' }
MNISTFile >> items [
	^ items
]

{ #category : 'initialization' }
MNISTFile >> parse: aReader [
	count := (aReader dimensionSizes) at:1
]
