Extension {
	#name : 'TensorFlowOperationAbstract'
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

{ #category : 'Accessing - TF Operation' }
TensorFlowOperationAbstract >> castedTo: aDataType [

	^TypeCast of: self to: aDataType
]

{ #category : 'Accessing - TF Operation' }
TensorFlowOperationAbstract >> comparedWith: anOperation [

	^ElementWiseEquality between: self and: anOperation
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
TensorFlowOperationAbstract >> raisedTo: theNthPower [

	^Exponentiation of: self raisedTo: theNthPower
]

{ #category : 'Operations' }
TensorFlowOperationAbstract >> reciprocal [

	^Reciprocal of: self
]

{ #category : 'Operations' }
TensorFlowOperationAbstract >> relu [

	^ReLU activating: self
]

{ #category : 'Accessing' }
TensorFlowOperationAbstract >> reshapeFlattened [

	^self reshapeTo: self outputShape flattened
]

{ #category : 'Operations' }
TensorFlowOperationAbstract >> reshapeTo: aNewShape [

	^Reshape of: self to: aNewShape
]

{ #category : 'Operations' }
TensorFlowOperationAbstract >> shape [

	^ShapeOperation of: self
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
