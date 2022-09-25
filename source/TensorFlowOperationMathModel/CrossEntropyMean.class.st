Class {
	#name : 'CrossEntropyMean',
	#superclass : 'LossFunction',
	#instVars : [
		'crossEntropy'
	],
	#category : 'TensorFlowOperationMathModel'
}

{ #category : 'Instance Creation' }
CrossEntropyMean class >> of: aCrossEntropyLoss [

	^self new initializeOf: aCrossEntropyLoss
]

{ #category : 'Accessing' }
CrossEntropyMean >> backpropagatedGradient [

	^ElementWiseDivision
		of: crossEntropy backpropagatedGradient
		and: (crossEntropy shape sumElements castedTo: FloatDataType new)
]

{ #category : 'Accessing' }
CrossEntropyMean >> currentComputation [

	^crossEntropy currentComputation
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

{ #category : 'Accessing' }
CrossEntropyMean >> targetInput [

	^crossEntropy targetInput
]

{ #category : 'Accessing' }
CrossEntropyMean >> targetInputAsLabels [

	^crossEntropy targetInputAsLabels
]
