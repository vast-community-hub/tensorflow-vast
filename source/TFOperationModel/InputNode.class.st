Class {
	#name : 'InputNode',
	#superclass : 'TensorFlowOperationAbstract',
	#instVars : [
		'currentComputation'
	],
	#category : 'TFOperationModel'
}

{ #category : 'Instance Creation' }
InputNode class >> on: aComputation named: anInputName of: aType [

	^self on: aComputation named: anInputName of: aType shaped: nil
]

{ #category : 'Instance Creation' }
InputNode class >> on: aComputation named: anInputName of: aType shaped: aShape [

	^self new initializeOn: aComputation named: anInputName of: aType shaped: aShape
]

{ #category : 'Instance Creation' }
InputNode class >> on: aComputation named: anInputName of: aType sized: aNumberOfFeatures [
	" This is useful when the placeholder should have the shape of the tensor will be fed with, 
	 as to create proper operations based on it, for example to create a reduce mean alongside all axis"
	^self
		on: aComputation
		named: anInputName
		of: aType
		shaped: (Array with: -1 with: aNumberOfFeatures)
]

{ #category : 'Accessing' }
InputNode >> currentComputation [

	^currentComputation
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
InputNode >> initializeOn: aTensorFlowComputation named: aName of: aType shaped: aShape [
	
	currentComputation := aTensorFlowComputation.
	value :=
		aTensorFlowComputation
			newOperationOf: self operationType
			namePrefixed: aName
			withAll: #()
			describedBy: [:description |
				description at: TFAttributeName dataType putType: aType.
				aShape ifNotNil: [description at: TFAttributeName shape putShape: aShape]]
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
InputNode >> operationType [

	^'Placeholder'
]
