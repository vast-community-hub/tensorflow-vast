Class {
	#name : 'TensorSliceDataset',
	#superclass : 'Dataset',
	#instVars : [
		'currentComputation',
		'outputShapes',
		'outputTypes'
	],
	#category : 'TFDatasetModel'
}

{ #category : 'Instance Creation' }
TensorSliceDataset class >> on: aComputation containing: aTensorCollection withOutputShaped: aTypeCollection [

	^self new
		initializeOn: aComputation
		containing: aTensorCollection
		withOutputShaped: aTypeCollection
]

{ #category : 'Accessing' }
TensorSliceDataset >> currentComputation [

	^currentComputation
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
TensorSliceDataset >> initializeOn: aComputation containing: aTensorCollection withOutputShaped: aShapeCollection [

	outputShapes := aShapeCollection.
	outputTypes := aTensorCollection collect: #outputType.
	currentComputation := aComputation.
	value :=
		currentComputation
			newOperationOf: 'TensorSliceDataset'
			namePrefixed: 'TensorSliceDataset'
			withAll: #()
			describedBy: [:description |
				description
					addInputs: (aTensorCollection collect: [:tensor | tensor value firstOutput]);
					at: TFAttributeName outputShapes putShapes: outputShapes]
]

{ #category : 'Accessing' }
TensorSliceDataset >> outputShapes [

	^outputShapes
]

{ #category : 'Accessing' }
TensorSliceDataset >> outputTypes [

	^outputTypes
]
