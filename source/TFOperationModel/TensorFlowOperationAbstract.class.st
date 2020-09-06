Class {
	#name : 'TensorFlowOperationAbstract',
	#superclass : 'Object',
	#instVars : [
		'value'
	],
	#category : 'TFOperationModel'
}

{ #category : 'Operations' }
TensorFlowOperationAbstract >> * anOperation [

	^ElementWiseMultiplication of: self and: anOperation
]

{ #category : 'Operations' }
TensorFlowOperationAbstract >> + anOperation [

	^Sum of: self plus: anOperation
]

{ #category : 'Operations' }
TensorFlowOperationAbstract >> - anOperation [

	^Substraction of: self minus: anOperation
]

{ #category : 'Operations' }
TensorFlowOperationAbstract >> / anOperation [

	^ElementWiseDivision of: self and: anOperation
]

{ #category : 'Operations' }
TensorFlowOperationAbstract >> abs [

	^AbsoluteValue of: self
]

{ #category : 'Operations' }
TensorFlowOperationAbstract >> argMaxAcross: anAxis [

	^IndexWithMaximum in: self across: anAxis
]

{ #category : 'Operations' }
TensorFlowOperationAbstract >> argMaxOnColumns [
	" (This assumes a tensor of rank 2, i.e. matrix, to make the concept of column valid)
	For each column, applies argMax "
	^self argMaxAcross: 0
]

{ #category : 'Operations' }
TensorFlowOperationAbstract >> argMaxOnRows [
	" (This assumes a tensor of rank 2, i.e. matrix, to make the concept of row valid)
	For each row, applies argMax "
	^self argMaxAcross: 1
]

{ #category : 'Operations' }
TensorFlowOperationAbstract >> argMinAcross: anAxis [

	^IndexWithMinimum in: self across: anAxis
]

{ #category : 'Operations' }
TensorFlowOperationAbstract >> biasedBy: aBias [

	^AddBias to: self with: aBias
]

{ #category : 'Accessing' }
TensorFlowOperationAbstract >> compute [

	^self currentComputation compute: self
]

{ #category : 'Accessing' }
TensorFlowOperationAbstract >> computeWith: aPlaceholderValueMapping [

	^self currentComputation compute: self feedingInputsWith: aPlaceholderValueMapping
]

{ #category : 'Accessing' }
TensorFlowOperationAbstract >> currentComputation [

	^self value currentComputation
]

{ #category : 'Operations' }
TensorFlowOperationAbstract >> dot: aMatrix [

	^MatrixMultiplication of: self and: aMatrix
]

{ #category : 'Operations' }
TensorFlowOperationAbstract >> dotTransposing: aMatrix [

	^MatrixMultiplication of: self andTransposed: aMatrix
]

{ #category : 'Operations' }
TensorFlowOperationAbstract >> mean [

	^ReduceMean ofValuesIn: self
]

{ #category : 'Operations' }
TensorFlowOperationAbstract >> meanAlongside: anAxis [

	^ReduceMean ofValuesIn: self alongside: anAxis
]

{ #category : 'Operations' }
TensorFlowOperationAbstract >> negated [

	^ElementWiseNegative of: self
]

{ #category : 'Accessing' }
TensorFlowOperationAbstract >> operationName [

	^self value operationName
]

{ #category : 'Accessing - TF Operation' }
TensorFlowOperationAbstract >> outputDimensions [

	^self value outputDimensions
]

{ #category : 'Accessing - TF Operation' }
TensorFlowOperationAbstract >> outputOn: aGraph [

	^self value outputOn: aGraph
]

{ #category : 'Accessing' }
TensorFlowOperationAbstract >> outputShape [

	^self value outputShape
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TensorFlowOperationAbstract >> print: aFormulaOrTensor formattedOn: aStream [

	aStream print: (
		(aFormulaOrTensor class = TFOperation)
			ifTrue: [aFormulaOrTensor operationName]
			ifFalse: [aFormulaOrTensor])
]

{ #category : 'Printing' }
TensorFlowOperationAbstract >> printOn: aStream [

	aStream nextPutAll: self operationName
]

{ #category : 'Accessing' }
TensorFlowOperationAbstract >> raisedTo: theNthPower [

	^Exponentiation of: self raisedTo: theNthPower
]

{ #category : 'Operations' }
TensorFlowOperationAbstract >> reciprocal [

	^Reciprocal of: self
]

{ #category : 'Operations' }
TensorFlowOperationAbstract >> relu [

	^RectifiedLinear activating: self
]

{ #category : 'Operations' }
TensorFlowOperationAbstract >> reshapeTo: aNewShape [

	^Reshape of: self to: aNewShape
]

{ #category : 'Operations' }
TensorFlowOperationAbstract >> sigmoid [

	^Sigmoid activating: self
]

{ #category : 'Operations' }
TensorFlowOperationAbstract >> softmax [

	^Softmax activating: self
]

{ #category : 'Operations' }
TensorFlowOperationAbstract >> squared [

	^ElementWiseSquare of: self
]

{ #category : 'Operations' }
TensorFlowOperationAbstract >> sumElements [

	^ReduceSum valuesIn: self
]

{ #category : 'Operations' }
TensorFlowOperationAbstract >> sumElementsAlongside: anAxis [

	^ReduceSum valuesIn: self alongside: anAxis
]

{ #category : 'Operations' }
TensorFlowOperationAbstract >> tanh [

	^Tanh activating: self
]

{ #category : 'Operations' }
TensorFlowOperationAbstract >> transposedDot: aMatrix [

	^MatrixMultiplication ofTransposed: self and: aMatrix
]

{ #category : 'Operations' }
TensorFlowOperationAbstract >> transposedDotTransposing: aMatrix [

	^MatrixMultiplication ofTransposed: self andTransposed: aMatrix
]

{ #category : 'Accessing - TF Operation' }
TensorFlowOperationAbstract >> value [

	^value
]
