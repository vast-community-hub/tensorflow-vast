Class {
	#name : 'TFMeanSquaredError',
	#superclass : 'TFLossFunction',
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

	value := TFReduceMean named: anOperationName ofValuesIn: (aPrediction - anExpectedValue) squared
]

{ #category : 'Initialization' }
TFMeanSquaredError >> value [

	^value value
]
