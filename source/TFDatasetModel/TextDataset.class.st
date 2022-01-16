Class {
	#name : 'TextDataset',
	#superclass : 'DatasetComputationAware',
	#instVars : [
		'currentComputation'
	],
	#category : 'TFDatasetModel'
}

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TextDataset class >> noCompression [

	^''
]

{ #category : 'Instance Creation' }
TextDataset class >> on: aComputation readingFrom: aFileName compressedWith: aCompressionType withBufferSized: aBufferSize [

	^self new
		initializeOn: aComputation
		readingFrom: aFileName
		compressedWith: aCompressionType
		withBufferSized: aBufferSize
]

{ #category : 'Instance Creation' }
TextDataset class >> on: aComputation readingFrom: aFileName withBufferSized: aBufferSize [

	^self
		on: aComputation
		readingFrom: aFileName
		compressedWith: self noCompression
		withBufferSized: aBufferSize
]

{ #category : 'Accessing' }
TextDataset >> currentComputation [

	^currentComputation
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
TextDataset >> initializeOn: aComputation readingFrom: aFileName compressedWith: aCompressionType withBufferSized: aBufferSize [

	currentComputation := aComputation.
	value :=
		aComputation
			newOperationOf: 'TextLineDataset'
			namePrefixed: 'TextLineDataset'
			withAll: (
				OrderedCollection new
					add: (TFTensor fromStrings: (Array with: aFileName));
					add: (
						TFTensor
							fromStrings: (Array with: aCompressionType)
							shape: TensorShape scalar);
					add: aBufferSize asInt64Tensor;
					yourself)
			describedBy: [:description | ]
]

{ #category : 'Accessing' }
TextDataset >> outputDomains [

	^Array with: (TensorDomain of: StringDataType new withShape: TensorShape scalar)
]
