Class {
	#name : 'TensorDataset',
	#superclass : 'Dataset',
	#instVars : [
		'currentComputation',
		'outputShapes',
		'outputTypes'
	],
	#category : 'TFDatasetModel'
}

{ #category : 'Instance Creation' }
TensorDataset class >> on: aComputation containing: aTensor [

	^self
		on: aComputation
		containing: (Array with: aTensor)
		withOutputsShaped: (Array with: aTensor outputShape)
]

{ #category : 'Instance Creation' }
TensorDataset class >> on: aTensorFlowComputation containing: aTensorCollection sliced: aBoolean withOutputsShaped: anTypeCollection [

	^self new
		initializeOn: aTensorFlowComputation
		containing: aTensorCollection
		sliced: aBoolean
		withOutputsShaped: anTypeCollection
]

{ #category : 'Instance Creation' }
TensorDataset class >> on: aComputation containing: aTensorCollection withOutputsShaped: aShapeCollection [

	^self
		on: aComputation
		containing: aTensorCollection
		sliced: false
		withOutputsShaped: aShapeCollection
]

{ #category : 'Instance Creation' }
TensorDataset class >> on: aComputation slicing: aTensorCollection withOutputShaped: aShape [

	^self on: aComputation slicing: aTensorCollection withOutputsShaped: (Array with: aShape)
]

{ #category : 'Instance Creation' }
TensorDataset class >> on: aComputation slicing: aTensorCollection withOutputsShaped: aShapeCollection [

	^self
		on: aComputation
		containing: aTensorCollection
		sliced: true
		withOutputsShaped: aShapeCollection
]

{ #category : 'Accessing' }
TensorDataset >> currentComputation [

	^currentComputation
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
TensorDataset >> initializeOn: aTensorFlowComputation containing: aTensorCollection sliced: aBoolean withOutputsShaped: aShapeCollection [

	outputShapes := aShapeCollection.
	outputTypes := aTensorCollection collect: #outputType.
	currentComputation := aTensorFlowComputation.
	value :=
		currentComputation
			newOperationOf: (aBoolean ifTrue: ['TensorSliceDataset'] ifFalse: ['TensorDataset'])
			namePrefixed: 'Dataset'
			withAll: #()
			describedBy: [:description |
				description
					addInputs: (aTensorCollection collect: [:tensor | tensor value firstOutput]);
					atOutputShapesPut: outputShapes]
]

{ #category : 'Accessing' }
TensorDataset >> outputDomains [

	^(1 to: outputTypes size)
		collect: [:i | TensorDomain of: (outputTypes at: i) withShape: (outputShapes at: i)]
]
