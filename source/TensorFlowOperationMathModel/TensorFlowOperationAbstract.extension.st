Extension {
	#name : 'TensorFlowOperationAbstract'
}

{ #category : '*TensorFlowOperationMathModel',
 #vaCategories : ['Operations'] }
TensorFlowOperationAbstract >> * anOperation [

	^ElementWiseMultiplication of: self and: anOperation
]

{ #category : '*TensorFlowOperationMathModel',
 #vaCategories : ['Operations'] }
TensorFlowOperationAbstract >> + anOperation [

	^Sum of: self plus: anOperation
]

{ #category : '*TensorFlowOperationMathModel',
 #vaCategories : ['Operations'] }
TensorFlowOperationAbstract >> - anOperation [

	^Substraction of: self minus: anOperation
]

{ #category : '*TensorFlowOperationMathModel',
 #vaCategories : ['Operations'] }
TensorFlowOperationAbstract >> / anOperation [

	^ElementWiseDivision of: self and: anOperation
]

{ #category : '*TensorFlowOperationMathModel',
 #vaCategories : ['Operations'] }
TensorFlowOperationAbstract >> abs [

	^AbsoluteValue of: self
]

{ #category : '*TensorFlowOperationMathModel',
 #vaCategories : ['Operations'] }
TensorFlowOperationAbstract >> argMaxAcross: anAxis [

	^IndexWithMaximum in: self across: anAxis
]

{ #category : '*TensorFlowOperationMathModel',
 #vaCategories : ['Operations'] }
TensorFlowOperationAbstract >> argMaxOnColumns [
	" (This assumes a tensor of rank 2, i.e. matrix, to make the concept of column valid)
	For each column, applies argMax "
	^self argMaxAcross: 0
]

{ #category : '*TensorFlowOperationMathModel',
 #vaCategories : ['Operations'] }
TensorFlowOperationAbstract >> argMaxOnRows [
	" (This assumes a tensor of rank 2, i.e. matrix, to make the concept of row valid)
	For each row, applies argMax "
	^self argMaxAcross: 1
]

{ #category : '*TensorFlowOperationMathModel',
 #vaCategories : ['Operations'] }
TensorFlowOperationAbstract >> argMinAcross: anAxis [

	^IndexWithMinimum in: self across: anAxis
]

{ #category : '*TensorFlowOperationMathModel',
 #vaCategories : ['Operations'] }
TensorFlowOperationAbstract >> biasedBy: aBias [

	^AddBias to: self with: aBias
]

{ #category : '*TensorFlowOperationMathModel',
 #vaCategories : ['Accessing - TF Operation'] }
TensorFlowOperationAbstract >> castedTo: aDataType [

	^TypeCast of: self to: aDataType
]

{ #category : '*TensorFlowOperationMathModel',
 #vaCategories : ['Accessing - TF Operation'] }
TensorFlowOperationAbstract >> comparedWith: anOperation [

	^ElementWiseEquality between: self and: anOperation
]

{ #category : '*TensorFlowOperationMathModel',
 #vaCategories : ['Operations'] }
TensorFlowOperationAbstract >> dot: aMatrix [

	^MatrixMultiplication of: self and: aMatrix
]

{ #category : '*TensorFlowOperationMathModel',
 #vaCategories : ['Operations'] }
TensorFlowOperationAbstract >> dotTransposing: aMatrix [

	^MatrixMultiplication of: self andTransposed: aMatrix
]

{ #category : '*TensorFlowOperationMathModel',
 #vaCategories : ['Operations'] }
TensorFlowOperationAbstract >> mean [

	^ReduceMean ofValuesIn: self
]

{ #category : '*TensorFlowOperationMathModel',
 #vaCategories : ['Operations'] }
TensorFlowOperationAbstract >> meanAlongside: anAxis [

	^ReduceMean ofValuesIn: self alongside: anAxis
]

{ #category : '*TensorFlowOperationMathModel',
 #vaCategories : ['Operations'] }
TensorFlowOperationAbstract >> negated [

	^ElementWiseNegative of: self
]

{ #category : '*TensorFlowOperationMathModel',
 #vaCategories : ['Accessing'] }
TensorFlowOperationAbstract >> raisedTo: theNthPower [

	^Exponentiation of: self raisedTo: theNthPower
]

{ #category : '*TensorFlowOperationMathModel',
 #vaCategories : ['Operations'] }
TensorFlowOperationAbstract >> reciprocal [

	^Reciprocal of: self
]

{ #category : '*TensorFlowOperationMathModel',
 #vaCategories : ['Operations'] }
TensorFlowOperationAbstract >> relu [

	^ReLU activating: self
]

{ #category : '*TensorFlowOperationMathModel',
 #vaCategories : ['Accessing'] }
TensorFlowOperationAbstract >> reshapeFlattened [

	^self reshapeTo: self outputShape flattened
]

{ #category : '*TensorFlowOperationMathModel',
 #vaCategories : ['Operations'] }
TensorFlowOperationAbstract >> reshapeTo: aNewShape [

	^Reshape of: self to: aNewShape
]

{ #category : '*TensorFlowOperationMathModel',
 #vaCategories : ['Operations'] }
TensorFlowOperationAbstract >> shape [

	^ShapeOperation of: self
]

{ #category : '*TensorFlowOperationMathModel',
 #vaCategories : ['Operations'] }
TensorFlowOperationAbstract >> sigmoid [

	^Sigmoid activating: self
]

{ #category : '*TensorFlowOperationMathModel',
 #vaCategories : ['Operations'] }
TensorFlowOperationAbstract >> softmax [

	^Softmax activating: self
]

{ #category : '*TensorFlowOperationMathModel',
 #vaCategories : ['Operations'] }
TensorFlowOperationAbstract >> squared [

	^ElementWiseSquare of: self
]

{ #category : '*TensorFlowOperationMathModel',
 #vaCategories : ['Operations'] }
TensorFlowOperationAbstract >> sumElements [

	^ReduceSum valuesIn: self
]

{ #category : '*TensorFlowOperationMathModel',
 #vaCategories : ['Operations'] }
TensorFlowOperationAbstract >> sumElementsAlongside: anAxis [

	^ReduceSum valuesIn: self alongside: anAxis
]

{ #category : '*TensorFlowOperationMathModel',
 #vaCategories : ['Operations'] }
TensorFlowOperationAbstract >> tanh [

	^Tanh activating: self
]

{ #category : '*TensorFlowOperationMathModel',
 #vaCategories : ['Operations'] }
TensorFlowOperationAbstract >> transposedDot: aMatrix [

	^MatrixMultiplication ofTransposed: self and: aMatrix
]

{ #category : '*TensorFlowOperationMathModel',
 #vaCategories : ['Operations'] }
TensorFlowOperationAbstract >> transposedDotTransposing: aMatrix [

	^MatrixMultiplication ofTransposed: self andTransposed: aMatrix
]
