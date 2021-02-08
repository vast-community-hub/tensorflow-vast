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
DatasetProvider >> download: aRemoteFileUrl to: aTargetDirectory [

	aTargetDirectory exists
		ifFalse: [PublicResourceDownloader new downloadFileAt: aRemoteFileUrl to: aTargetDirectory]
]

{ #category : 'Accessing - MNIST' }
DatasetProvider >> fashionDataset [

	fashionDataset ifNil: [self initializeFashionDataset].
	^fashionDataset
]

{ #category : 'Accessing - MNIST' }
DatasetProvider >> fashionDatasetOn: aTensorFlowComputation [

	^(SampleDatasetComputationAware
		on: aTensorFlowComputation
		transformingFeaturesWith: [:features | features reshapeFlattened / 255.0]
		transformingLabelsWith: [:labels | labels]
		applying: [:dataset | dataset inBatchesOf: 32])
			bindSetsFrom: self fashionDataset
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
	baseDirectory := './datasets/fashion-mnist' asFileReference.
	baseDirectory realize ifFalse: [AssertionFailure signal: 'Folder could not be created'].

	OrderedCollection new
		add: 'train-labels-idx1-ubyte.gz';
		add: 'train-images-idx3-ubyte.gz';
		add: 't10k-labels-idx1-ubyte.gz';
		add: 't10k-images-idx3-ubyte.gz';
		do: [:fileName |
			self
				download: ('<1s><2s>' expandMacrosWith: baseUrl with: fileName)
				to: baseDirectory / fileName].

	fashionDataset :=
		SampleDataset new
			bindTrainingSetTo: (
					self
						tensorTyped: TFTensor typeFloat
						fromFileNamed: baseDirectory / 'train-images-idx3-ubyte.gz')
				withLabels: (
					self
						tensorTyped: TFTensor typeInt32
						fromFileNamed: baseDirectory / 'train-labels-idx1-ubyte.gz');
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
				to: baseDirectory / ('<1s>' expandMacrosWith: fileName)].

	handwrittenDigitsDataset :=
		SampleDataset new
			bindTrainingSetTo: (
					self
						tensorTyped: TFTensor typeFloat
						fromFileNamed: baseDirectory / 'train-images-idx3-ubyte.gz')
				withLabels: (
					self
						tensorTyped: TFTensor typeInt32
						fromFileNamed: baseDirectory / 'train-labels-idx1-ubyte.gz');
			bindTestingSetTo: (
					self
						tensorTyped: TFTensor typeFloat
						fromFileNamed: baseDirectory / 't10k-images-idx3-ubyte.gz')
				withLabels: (
					self
						tensorTyped: TFTensor typeInt32
						fromFileNamed: baseDirectory / 't10k-labels-idx1-ubyte.gz');
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

{ #category : 'Accessing',
  #vaVisibility : 'private' }
DatasetProvider >> tensorTyped: aTensorType fromFileNamed: aString [

	| file reader |

	file := aString asFileReference.
	file exists ifFalse: [AssertionFailure signal: (#'Can''t find %1' bindWith: file asString)].
	file readStreamDo: [:compressed |
		reader := IdxReader onStream: compressed contents gzipDecompress readStream.
		^TFTensor
			fromNumbers: reader next
			type: aTensorType
			shape: (TensorShape withDimensionsSized: reader dimensionSizes)]
]
