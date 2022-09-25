Class {
	#name : 'InputTensor',
	#superclass : 'TensorFlowOperationAbstract',
	#instVars : [
		'currentComputation'
	],
	#category : 'TensorFlowOperationBasicModel'
}

{ #category : 'Instance Creation' }
InputTensor class >> on: aComputation named: anInputName of: aType [

	^self on: aComputation named: anInputName of: aType shaped: nil
]

{ #category : 'Instance Creation' }
InputTensor class >> on: aComputation named: anInputName of: aType shaped: aShape [

	^self new initializeOn: aComputation named: anInputName of: aType shaped: aShape
]

{ #category : 'Instance Creation' }
InputTensor class >> on: aComputation named: anInputName of: aType sized: aNumberOfFeatures [
	" This is useful when the placeholder should have the shape of the tensor will be fed with, 
	 as to create proper operations based on it, for example to create a reduce mean alongside all axis"
	^self
		on: aComputation
		named: anInputName
		of: aType
		shaped: (TensorShape unknownBatchSizeWith: aNumberOfFeatures)
]

{ #category : 'Accessing' }
InputTensor >> currentComputation [

	^currentComputation
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
InputTensor >> initializeOn: aTensorFlowComputation named: aName of: aType shaped: aShape [

	currentComputation := aTensorFlowComputation.
	value :=
		aTensorFlowComputation
			newOperationOf: self operationType
			namePrefixed: aName
			withAll: #()
			describedBy: [:description |
				description atDataTypePut: aType.
				aShape ifNotNil: [description atShapePut: aShape]]
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
InputTensor >> operationType [

	^'Placeholder'
]
