Class {
	#name : 'SquaredDifference',
	#superclass : 'LossFunction',
	#instVars : [
		'expectedValue'
	],
	#category : 'TFOperationModel'
}

{ #category : 'Instance Creation' }
SquaredDifference class >> between: aValue and: anotherValue [

	^self new initializeBetween: aValue and: anotherValue
]

{ #category : 'Accessing' }
SquaredDifference >> currentComputation [

	^value currentComputation
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
SquaredDifference >> initializeBetween: aValue and: anotherValue [
	
	expectedValue := anotherValue. 
	value := (aValue - anotherValue) squared


]

{ #category : 'Initialization' }
SquaredDifference >> mean [

	^MeanSquaredError named: 'MSE' meanOf: self
]

{ #category : 'Initialization' }
SquaredDifference >> targetInput [

	^expectedValue
]

{ #category : 'Accessing' }
SquaredDifference >> targetInputAsLabels [

	^expectedValue argMaxOnRows
]
