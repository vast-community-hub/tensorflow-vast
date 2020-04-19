Class {
	#name : 'TFOperationAbstract',
	#superclass : 'Object',
	#instVars : [
		'value'
	],
	#category : 'TFOperationModel'
}

{ #category : 'Accessing - Operation',
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

{ #category : 'Accessing - Operation' }
TFOperationAbstract >> negated [

	^TFElementWiseNegative negativeOf: self
]

{ #category : 'Accessing' }
TFOperationAbstract >> operationName [


	self subclassResponsibility
]

{ #category : 'Accessing - Operation' }
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

{ #category : 'Accessing - Operation',
  #vaVisibility : 'private' }
TFOperationAbstract >> unaryOperation: anOperation with: anOperand [

	^anOperand currentComputation
		newOperationOf: anOperation
		named: self operationName
		with: anOperand


]

{ #category : 'Accessing - Operation' }
TFOperationAbstract >> value [

	^value
]
