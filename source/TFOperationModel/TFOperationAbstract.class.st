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
TFOperationAbstract >> biasedBy: aBias [

	^TFAddBias to: self with: aBias
]

{ #category : 'Accessing - TF Operation',
  #vaVisibility : 'private' }
TFOperationAbstract >> binaryOperation: anOperation between: aLeftOperand and: aRightOperand [

	^aLeftOperand currentComputation
		newOperationOf: anOperation
		named: self operationName
		with: aLeftOperand
		with: aRightOperand
]

{ #category : 'Computing',
  #vaVisibility : 'private' }
TFOperationAbstract >> calculateValue [

	self subclassResponsibility
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
TFOperationAbstract >> negated [

	^TFElementWiseNegative negativeOf: self
]

{ #category : 'Accessing' }
TFOperationAbstract >> operationName [


	self subclassResponsibility
]

{ #category : 'Accessing - TF Operation' }
TFOperationAbstract >> outputOn: aGraph [

	^self value outputOn: aGraph
]

{ #category : 'Accessing',
  #vaVisibility : 'private' }
TFOperationAbstract >> print: aFormulaOrTensor formattedOn: aStream [

	aStream print: (
		(aFormulaOrTensor class = TFOperation)
			ifTrue: [aFormulaOrTensor operationName]
			ifFalse: [aFormulaOrTensor])
]

{ #category : 'Operations' }
TFOperationAbstract >> reciprocal [

	^TFReciprocal of: self
]

{ #category : 'Operations' }
TFOperationAbstract >> squared [

	^TFElementWiseSquare of: self
]

{ #category : 'Operations' }
TFOperationAbstract >> transposedDot: aMatrix [

	^TFMatrixMultiplication ofTransposed: self and: aMatrix
]

{ #category : 'Operations' }
TFOperationAbstract >> transposedDotTransposing: aMatrix [

	^TFMatrixMultiplication ofTransposed: self andTransposed: aMatrix
]

{ #category : 'Accessing - TF Operation',
  #vaVisibility : 'private' }
TFOperationAbstract >> unaryOperation: anOperation with: anOperand [

	^anOperand currentComputation
		newOperationOf: anOperation
		named: self operationName
		with: anOperand


]

{ #category : 'Accessing - TF Operation' }
TFOperationAbstract >> value [

	^value
]
