Class {
	#name : 'TFMeanSquaredError',
	#superclass : 'TFLossFunction',
	#instVars : [
		'squareDifference'
	],
	#category : 'TFOperationModel'
}

{ #category : 'Instance Creation',
  #vaVisibility : 'private' }
TFMeanSquaredError class >> named: anOperationName meanOf: aSquaredDifference [

	^self new initializeNamed: anOperationName meanOf: aSquaredDifference
]

{ #category : 'Instance Creation' }
TFMeanSquaredError class >> named: anOperationName of: aPrediction whenExpectedIs: anExpectedValue [

	^self
		named: anOperationName
		meanOf: (TFSquaredDifference between: aPrediction and: anExpectedValue)
]

{ #category : 'Instance Creation' }
TFMeanSquaredError class >> of: aLogitsTensor whenExpectedIs: anExpectedTensor [

	^self
		named: 'MSE'
		of: aLogitsTensor
		whenExpectedIs: anExpectedTensor
]

{ #category : 'Accessing' }
TFMeanSquaredError >> expectedVariableName [

	^squareDifference expectedVariableName
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
TFMeanSquaredError >> initializeNamed: anOperationName meanOf: aSquareDifference [

	squareDifference := aSquareDifference.
	value := TFReduceMean named: anOperationName ofValuesIn: aSquareDifference
]

{ #category : 'Initialization' }
TFMeanSquaredError >> value [

	^value value
]
