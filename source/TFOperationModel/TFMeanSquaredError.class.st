Class {
	#name : 'TFMeanSquaredError',
	#superclass : 'TFLossFunction',
	#instVars : [
		'operationName'
	],
	#category : 'TFOperationModel'
}

{ #category : 'Instance Creation' }
TFMeanSquaredError class >> named: anOperationName of: aPrediction whenExpectedIs: anExpectedValue [

	^self new initializeNamed: anOperationName of: aPrediction whenExpectedIs: anExpectedValue
]

{ #category : 'Instance Creation' }
TFMeanSquaredError class >> of: aLogitsTensor whenExpectedIs: anExpectedTensor [

	^self
		named: 'MSE'
		of: aLogitsTensor
		whenExpectedIs: anExpectedTensor
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
TFMeanSquaredError >> initializeNamed: anOperationName of: aPrediction whenExpectedIs: anExpectedValue [

	operationName := anOperationName.
	value :=
		TFReduceMean ofValuesIn:
			(TFElementWiseSquare of: (TFSubstraction of: aPrediction minus: anExpectedValue))
]
