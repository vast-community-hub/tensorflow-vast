Class {
	#name : 'TFSquaredDifference',
	#superclass : 'TFLossFunction',
	#category : 'TFOperationModel'
}

{ #category : 'Instance Creation' }
TFSquaredDifference class >> between: aValue and: anotherValue [

	^self new initializeBetween: aValue and: anotherValue
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
TFSquaredDifference >> initializeBetween: aValue and: anotherValue [

	value := (aValue - anotherValue) squared


]
