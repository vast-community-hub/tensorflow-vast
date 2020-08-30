Class {
	#name : 'TFSquaredDifference',
	#superclass : 'TFLossFunction',
	#instVars : [
		'expectedValue'
	],
	#category : 'TFOperationModel'
}

{ #category : 'Instance Creation' }
TFSquaredDifference class >> between: aValue and: anotherValue [

	^self new initializeBetween: aValue and: anotherValue
]

{ #category : 'Initialization' }
TFSquaredDifference >> expectedVariableName [

	^expectedValue operationName
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
TFSquaredDifference >> initializeBetween: aValue and: anotherValue [
	
	expectedValue := anotherValue. 
	value := (aValue - anotherValue) squared


]

{ #category : 'Initialization' }
TFSquaredDifference >> mean [

	^TFMeanSquaredError named: 'MSE' meanOf: self
]
