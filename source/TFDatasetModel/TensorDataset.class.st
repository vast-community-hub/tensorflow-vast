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
		withOutputShaped: (Array with: aTensor outputShape)
]

{ #category : 'Instance Creation' }
TensorDataset class >> on: aComputation containing: aTensorCollection withOutputShaped: aTypeCollection [

	^self new
		initializeOn: aComputation
		containing: aTensorCollection
		withOutputShaped: aTypeCollection
]

{ #category : 'Accessing' }
TensorDataset >> currentComputation [

	^currentComputation
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
TensorDataset >> initializeOn: aComputation containing: aTensorCollection withOutputShaped: aShapeCollection [

	outputShapes := aShapeCollection.
	outputTypes := aTensorCollection collect: #outputType.
	currentComputation := aComputation.
	value :=
		currentComputation
			newOperationOf: 'TensorDataset'
			namePrefixed: 'TensorDataset'
			withAll: #()
			describedBy: [:description |
				description
					addInputs: (aTensorCollection collect: [:tensor | tensor value firstOutput]);
					at: TFAttributeName outputShapes putShapes: outputShapes]
]

{ #category : 'Accessing' }
TensorDataset >> outputShapes [

	^outputShapes
]

{ #category : 'Accessing' }
TensorDataset >> outputTypes [

	^outputTypes
]
