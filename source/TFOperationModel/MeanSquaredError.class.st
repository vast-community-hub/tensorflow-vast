Class {
	#name : 'MeanSquaredError',
	#superclass : 'LossFunction',
	#instVars : [
		'squareDifference'
	],
	#category : 'TFOperationModel'
}

{ #category : 'Instance Creation',
  #vaVisibility : 'private' }
MeanSquaredError class >> named: anOperationName meanOf: aSquaredDifference [

	^self new initializeNamed: anOperationName meanOf: aSquaredDifference
]

{ #category : 'Instance Creation' }
MeanSquaredError class >> named: anOperationName of: aPrediction whenExpectedIs: anExpectedValue [

	^self
		named: anOperationName
		meanOf: (SquaredDifference between: aPrediction and: anExpectedValue)
]

{ #category : 'Instance Creation' }
MeanSquaredError class >> of: aLogitsTensor whenExpectedIs: anExpectedTensor [

	^self
		named: 'MSE'
		of: aLogitsTensor
		whenExpectedIs: anExpectedTensor
]

{ #category : 'Accessing' }
MeanSquaredError >> currentComputation [

	^value currentComputation
]

{ #category : 'Accessing' }
MeanSquaredError >> expectedVariableName [

	^squareDifference expectedVariableName
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
MeanSquaredError >> initializeNamed: anOperationName meanOf: aSquareDifference [

	squareDifference := aSquareDifference.
	value := ReduceMean named: anOperationName ofValuesIn: aSquareDifference
]

{ #category : 'Initialization' }
MeanSquaredError >> value [

	^value value
]
