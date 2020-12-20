Class {
	#name : 'TensorDataset',
	#superclass : 'Dataset',
	#instVars : [
		'currentComputation',
		'outputShapes',
		'outputTypes',
		'outputDomains'
	],
	#category : 'TFDatasetModel'
}

{ #category : 'Instance Creation' }
TensorDataset class >> on: aComputation containing: aTensor [

	^self on: aComputation containingAll: (Array with: aTensor)
]

{ #category : 'Instance Creation' }
TensorDataset class >> on: aComputation containingAll: aTensorCollection [

	^self on: aComputation containingAll: aTensorCollection sliced: false
]

{ #category : 'Instance Creation',
  #vaVisibility : 'private' }
TensorDataset class >> on: aTensorFlowComputation containingAll: aTensorCollection sliced: aBoolean [

	^self new initializeOn: aTensorFlowComputation containingAll: aTensorCollection sliced: aBoolean
]

{ #category : 'Instance Creation' }
TensorDataset class >> on: aComputation slicing: aTensor [

	^self on: aComputation slicingAll: (Array with: aTensor)
]

{ #category : 'Instance Creation' }
TensorDataset class >> on: aTensorFlowComputation slicingAll: aTensorCollection [

	^self new initializeOn: aTensorFlowComputation containingAll: aTensorCollection sliced: true
]

{ #category : 'Accessing' }
TensorDataset >> currentComputation [

	^currentComputation
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
TensorDataset >> initializeOn: aTensorFlowComputation containingAll: aTensorCollection sliced: aBoolean [

	| opType |

	aBoolean
		ifTrue: [
			opType := 'TensorSliceDataset'.
			outputDomains :=
				aTensorCollection collect: [:tensor | tensor outputDomain withSlicedShape]]
		ifFalse: [
			opType := 'TensorDataset'.
			outputDomains := aTensorCollection collect: #outputDomain].
	currentComputation := aTensorFlowComputation.
	value :=
		currentComputation
			newOperationOf: opType
			namePrefixed: 'Dataset'
			withAll: #()
			describedBy: [:description |
				description
					addInputs: (aTensorCollection collect: [:tensor | tensor value firstOutput]);
					atOutputShapesPut: (outputDomains collect: #shape)]
]

{ #category : 'Accessing' }
TensorDataset >> outputDomains [

	^outputDomains
]
