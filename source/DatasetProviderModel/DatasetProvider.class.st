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

	FileSystemAPI current downloadFileAt: aRemoteFileUrl to: aTargetDirectory
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

	baseUrl := 'https://raw.githubusercontent.com/jvanecek/datasets/main/mnist-fashion/'.
	baseDirectory := FileSystemAPI current directoryNamed: './datasets/mnist-fashion'.

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
						tensorTyped: FloatDataType new
						fromFileNamed: baseDirectory / 'train-images-idx3-ubyte.gz')
				withLabels: (
					self
						tensorTyped: Int32DataType new
						fromFileNamed: baseDirectory / 'train-labels-idx1-ubyte.gz');
			bindValidationSetTo: (
					self
						tensorTyped: FloatDataType new
						fromFileNamed: baseDirectory / 't10k-images-idx3-ubyte.gz')
				withLabels: (
					self
						tensorTyped: Int32DataType new
						fromFileNamed: baseDirectory / 't10k-labels-idx1-ubyte.gz');
			yourself
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
DatasetProvider >> initializeHandwrittenDataset [

	| baseUrl baseDirectory |

	baseUrl := 'https://raw.githubusercontent.com/jvanecek/datasets/main/mnist-handwritten/'.
	baseDirectory := FileSystemAPI current directoryNamed: './datasets/mnist-handwritten/'.

	OrderedCollection new
		add: 'train-labels-idx1-ubyte.gz';
		add: 'train-images-idx3-ubyte.gz';
		add: 't10k-labels-idx1-ubyte.gz';
		add: 't10k-images-idx3-ubyte.gz';
		do: [:fileName |
			self
				download: ('<1s><2s>' expandMacrosWith: baseUrl with: fileName)
				to: baseDirectory / fileName].

	handwrittenDigitsDataset :=
		SampleDataset new
			bindTrainingSetTo: (
					self 
						tensorTyped: FloatDataType new
						fromFileNamed: baseDirectory / 'train-images-idx3-ubyte.gz')
				withLabels: (
					self
						tensorTyped: Int32DataType new
						fromFileNamed: baseDirectory / 'train-labels-idx1-ubyte.gz');
			bindTestingSetTo: (
					self
						tensorTyped: FloatDataType new
						fromFileNamed: baseDirectory / 't10k-images-idx3-ubyte.gz')
				withLabels: (
					self
						tensorTyped: Int32DataType new
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

	FileSystemAPI current
		readIdxFileNamed: aString
		thenDo: [ :dimensionSizes :content | 
			^TFTensor
				fromNumbers: content
				type: aTensorType
				shape: ( TensorShape withDimensionsSized: dimensionSizes )
			]
]
