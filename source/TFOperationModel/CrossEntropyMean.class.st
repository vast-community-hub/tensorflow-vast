Class {
	#name : 'CrossEntropyMean',
	#superclass : 'LossFunction',
	#instVars : [
		'crossEntropy'
	],
	#category : 'TFOperationModel'
}

{ #category : 'Instance Creation' }
CrossEntropyMean class >> of: aCrossEntropyLoss [

	^self new initializeOf: aCrossEntropyLoss
]

{ #category : 'Accessing' }
CrossEntropyMean >> backpropagatedGradient [

	^ElementWiseDivision
		of: crossEntropy backpropagatedGradient
		and: ((ReduceSum valuesIn: crossEntropy value shape) value castTo: TFTensor typeFloat)
]

{ #category : 'Accessing' }
CrossEntropyMean >> expectedVariableName [

	^crossEntropy expectedVariableName
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
CrossEntropyMean >> initializeOf: aCrossEntropyLoss [

	crossEntropy := aCrossEntropyLoss.
	value := ReduceMean ofValuesIn: aCrossEntropyLoss
]

{ #category : 'Printing' }
CrossEntropyMean >> printOn: aStream [


	aStream nextPutAll: ('<1p> (Reduced to scalar with mean)' expandMacrosWith: crossEntropy)
]
