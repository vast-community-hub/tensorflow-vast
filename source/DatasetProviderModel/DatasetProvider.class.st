Class {
	#name : 'DatasetProvider',
	#superclass : 'Object',
	#instVars : [
		'fashionDataset',
		'handwrittenDigitsDataset',
		'shakespeareText'
	],
	#classInstVars : [
		'current'
	],
	#category : 'DatasetProviderModel'
}

{ #category : 'Instance Creation' }
DatasetProvider class >> clearCurrent [

	current := nil
]

{ #category : 'Instance Creation' }
DatasetProvider class >> current [

	current ifNil: [current := super new initialize].
	^current


]

{ #category : 'Instance Creation' }
DatasetProvider class >> new [

	^self current
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
DatasetProvider >> create: aClassType fromFileNamed: aString [

	| file reader |

	file := aString asPath.
	file exists ifFalse: [AssertionFailure signal: (#'Can''t find %1' bindWith: file asString)].
	file readStreamDo: [:compressed |
		reader := IdxReader onStream: compressed contents gzipDecompress readStream.
		^aClassType fromReader: reader]
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
DatasetProvider >> download: aRemoteFileUrl to: aTargetDirectory [

	aTargetDirectory exists
		ifTrue: [aTargetDirectory readStreamDo: [:stream | ^stream contents]]
		ifFalse: [| byteMessage result |

			byteMessage := SstHttpClient fetch: aRemoteFileUrl.
			result :=
				aTargetDirectory
					writeStreamDo: [:stream | stream nextPutAll: byteMessage basicContents].
			result ifNil: [AssertionFailure signal: 'File could not be downloaded'].
			^result]
]

{ #category : 'Accessing - MNIST' }
DatasetProvider >> fashionDataset [

	fashionDataset ifNil: [self initializeFashionDataset].
	^fashionDataset
]

{ #category : 'Accessing - MNIST' }
DatasetProvider >> handwrittenDigitsDataset [

	handwrittenDigitsDataset ifNil: [self initializeHandwrittenDataset].
	^handwrittenDigitsDataset
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
DatasetProvider >> initializeFashionDataset [

	| baseUrl baseDirectory |

	baseUrl := 'https://storage.googleapis.com/tensorflow/tf-keras-datasets/'.
	baseDirectory := './datasets/mnist-fashion' asFileReference.
	baseDirectory realize ifFalse: [AssertionFailure signal: 'Folder could not be created'].

	OrderedCollection new
		add: 'train-labels-idx1-ubyte.gz';
		add: 'train-images-idx3-ubyte.gz';
		add: 't10k-labels-idx1-ubyte.gz';
		add: 't10k-images-idx3-ubyte.gz';
		do: [:fileName |
			self
				download: ('<1s><2s>' expandMacrosWith: baseUrl with: fileName)
				to: (baseDirectory extend: ('/<1s>' expandMacrosWith: fileName))].

	fashionDataset :=
		SampleDataset new
			bindTrainingSetTo: (
					(self
						create: MNISTImageFile
						fromFileNamed: (baseDirectory extend: '/train-images-idx3-ubyte.gz'))
							transformFeaturesDoing: [:item | item / 255];
							yourself)
				andLabelsTo: (
					self
						create: MNISTLabelFile
						fromFileNamed: (baseDirectory extend: '/train-labels-idx1-ubyte.gz'));
			bindValidationSetTo: (
					(self
						create: MNISTImageFile
						fromFileNamed: (baseDirectory extend: '/t10k-images-idx3-ubyte.gz'))
							transformFeaturesDoing: [:item | item / 255];
							yourself)
				andLabelsTo: (
					self
						create: MNISTLabelFile
						fromFileNamed: (baseDirectory extend: '/t10k-labels-idx1-ubyte.gz'));
			yourself
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
DatasetProvider >> initializeHandwrittenDataset [

	| baseUrl baseDirectory |

	baseUrl := 'http://yann.lecun.com/exdb/mnist/'.
	baseDirectory := './datasets/mnist-handwritten/' asFileReference.
	baseDirectory realize ifFalse: [AssertionFailure signal: 'Folder could not be created'].

	OrderedCollection new
		add: 'train-labels-idx1-ubyte.gz';
		add: 'train-images-idx3-ubyte.gz';
		add: 't10k-labels-idx1-ubyte.gz';
		add: 't10k-images-idx3-ubyte.gz';
		do: [:fileName |
			self
				download: ('<1s><2s>' expandMacrosWith: baseUrl with: fileName)
				to: (baseDirectory extend: ('/<1s>' expandMacrosWith: fileName))].

	handwrittenDigitsDataset :=
		SampleDataset new
			bindTrainingSetTo: (
					self
						create: MNISTImageFile
						fromFileNamed: (baseDirectory extend: '/train-images-idx3-ubyte.gz'))
				andLabelsTo: (
					self
						create: MNISTLabelFile
						fromFileNamed: (baseDirectory extend: '/train-labels-idx1-ubyte.gz'));
			bindTestingSetTo: (
					self
						create: MNISTImageFile
						fromFileNamed: (baseDirectory extend: '/t10k-images-idx3-ubyte.gz'))
				andLabelsTo: (
					self
						create: MNISTLabelFile
						fromFileNamed: (baseDirectory extend: '/t10k-labels-idx1-ubyte.gz'));
			yourself
]

{ #category : 'Accessing' }
DatasetProvider >> shakespeareText [

	shakespeareText ifNil: [
		shakespeareText :=
			self
				download:
					'https://storage.googleapis.com/download.tensorflow.org/data/shakespeare.txt'
				to: './datasets/shakespeare.txt' asFileReference].
	^shakespeareText
]
