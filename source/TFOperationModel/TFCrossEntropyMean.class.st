Class {
	#name : 'TFCrossEntropyMean',
	#superclass : 'TFLossFunction',
	#instVars : [
		'crossEntropy'
	],
	#category : 'TFOperationModel'
}

{ #category : 'Instance Creation' }
TFCrossEntropyMean class >> of: aCrossEntropyLoss [

	^self new initializeOf: aCrossEntropyLoss
]

{ #category : 'Accessing' }
TFCrossEntropyMean >> backpropagatedGradient [

	^TFElementWiseDivision
		of: crossEntropy backpropagatedGradient
		and: ((TFReduceSum valuesIn: crossEntropy value shape) value castTo: TFTensor typeFloat)
]

{ #category : 'Accessing' }
TFCrossEntropyMean >> expectedVariableName [

	^crossEntropy expectedVariableName
]

{ #category : 'Initialization',
  #vaVisibility : 'private' }
TFCrossEntropyMean >> initializeOf: aCrossEntropyLoss [

	crossEntropy := aCrossEntropyLoss.
	value := TFReduceMean ofValuesIn: aCrossEntropyLoss
]

{ #category : 'Printing' }
TFCrossEntropyMean >> printOn: aStream [


	aStream nextPutAll: ('<1p> (Reduced to scalar with mean)' expandMacrosWith: crossEntropy)
]
