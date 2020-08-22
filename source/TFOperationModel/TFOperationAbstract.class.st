Class {
	#name : 'TFOperationAbstract',
	#superclass : 'Object',
	#instVars : [
		'value'
	],
	#category : 'TFOperationModel'
}

{ #category : 'Operations' }
TFOperationAbstract >> * anOperation [

	^TFElementWiseMultiplication of: self and: anOperation
]

{ #category : 'Operations' }
TFOperationAbstract >> + anOperation [

	^TFSum of: self plus: anOperation
]

{ #category : 'Operations' }
TFOperationAbstract >> - anOperation [

	^TFSubstraction of: self minus: anOperation
]

{ #category : 'Operations' }
TFOperationAbstract >> / anOperation [

	^TFElementWiseDivision of: self and: anOperation
]

{ #category : 'Operations' }
TFOperationAbstract >> abs [

	^TFAbsoluteValue of: self
]

{ #category : 'Operations' }
TFOperationAbstract >> argMaxAcross: anAxis [

	^TFIndexWithMaximum in: self across: anAxis
]

{ #category : 'Operations' }
TFOperationAbstract >> argMinAcross: anAxis [

	^TFIndexWithMinimum in: self across: anAxis
]

{ #category : 'Operations' }
TFOperationAbstract >> biasedBy: aBias [

	^TFAddBias to: self with: aBias
]

{ #category : 'Accessing' }
TFOperationAbstract >> compute [

	^self currentComputation compute: self
]

{ #category : 'Accessing' }
TFOperationAbstract >> computeWith: aPlaceholderValueMapping [

	^self currentComputation compute: self feedingInputsWith: aPlaceholderValueMapping
]

{ #category : 'Accessing' }
TFOperationAbstract >> currentComputation [

	^self value currentComputation
]

{ #category : 'Operations' }
TFOperationAbstract >> dot: aMatrix [

	^TFMatrixMultiplication of: self and: aMatrix
]

{ #category : 'Operations' }
TFOperationAbstract >> dotTransposing: aMatrix [

	^TFMatrixMultiplication of: self andTransposed: aMatrix
]

{ #category : 'Operations' }
TFOperationAbstract >> mean [

	^TFReduceMean ofValuesIn: self
]

{ #category : 'Operations' }
TFOperationAbstract >> meanAlongside: anAxis [

	^TFReduceMean ofValuesIn: self alongside: anAxis
]

{ #category : 'Operations' }
TFOperationAbstract >> negated [

	^TFElementWiseNegative negativeOf: self
]

{ #category : 'Accessing' }
TFOperationAbstract >> operationName [

	^self value operationName
]

{ #category : 'Accessing - TF Operation' }
TFOperationAbstract >> outputDimensions [

	^self value outputDimensions
]

{ #category : 'Accessing - TF Operation' }
TFOperationAbstract >> outputOn: aGraph [

	^self value outputOn: aGraph
]

{ #category : 'Accessing' }
TFOperationAbstract >> outputShape [

	^self value outputShape
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TFOperationAbstract >> print: aFormulaOrTensor formattedOn: aStream [

	aStream print: (
		(aFormulaOrTensor class = TFOperation)
			ifTrue: [aFormulaOrTensor operationName]
			ifFalse: [aFormulaOrTensor])
]

{ #category : 'Printing' }
TFOperationAbstract >> printOn: aStream [

	aStream nextPutAll: self operationName
]

{ #category : 'Accessing' }
TFOperationAbstract >> raisedTo: theNthPower [

	^TFExponentiation of: self raisedTo: theNthPower
]

{ #category : 'Operations' }
TFOperationAbstract >> reciprocal [

	^TFReciprocal of: self
]

{ #category : 'Operations' }
TFOperationAbstract >> relu [

	^TFReluActivation activating: self
]

{ #category : 'Operations' }
TFOperationAbstract >> reshapeTo: aNewShape [

	^TFReshape of: self to: aNewShape
]

{ #category : 'Operations' }
TFOperationAbstract >> sigmoid [

	^TFSigmoidActivation activating: self
]

{ #category : 'Operations' }
TFOperationAbstract >> softmax [

	^TFSoftmaxActivation activating: self
]

{ #category : 'Operations' }
TFOperationAbstract >> squared [

	^TFElementWiseSquare of: self
]

{ #category : 'Operations' }
TFOperationAbstract >> sumElements [

	^TFReduceSum valuesIn: self
]

{ #category : 'Operations' }
TFOperationAbstract >> sumElementsAlongside: anAxis [

	^TFReduceSum valuesIn: self alongside: anAxis
]

{ #category : 'Operations' }
TFOperationAbstract >> tanh [

	^TFTanhActivation activating: self
]

{ #category : 'Operations' }
TFOperationAbstract >> transposedDot: aMatrix [

	^TFMatrixMultiplication ofTransposed: self and: aMatrix
]

{ #category : 'Operations' }
TFOperationAbstract >> transposedDotTransposing: aMatrix [

	^TFMatrixMultiplication ofTransposed: self andTransposed: aMatrix
]

{ #category : 'Accessing - TF Operation' }
TFOperationAbstract >> value [

	^value
]
