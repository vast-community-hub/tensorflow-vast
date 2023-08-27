Class {
	#name : 'TensorFlowOperationAbstract',
	#superclass : 'Object',
	#instVars : [
		'value'
	],
	#category : 'TensorFlowOperationBasicModel'
}

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

	self subclassResponsibility
]

{ #category : 'Accessing' }
TensorFlowOperationAbstract >> operationName [

	^self value operationName
]

{ #category : 'Accessing - TF Operation' }
TensorFlowOperationAbstract >> outputDimensions [

	^self value outputDimensions
]

{ #category : 'Accessing' }
TensorFlowOperationAbstract >> outputDomain [

	^TensorDomain of: self value outputType withShape: self value outputShape
]

{ #category : 'Accessing - TF Operation' }
TensorFlowOperationAbstract >> outputOn: aGraph [

	^self value outputOn: aGraph
]

{ #category : 'Accessing' }
TensorFlowOperationAbstract >> outputShape [

	^self value outputShape
]

{ #category : 'Accessing' }
TensorFlowOperationAbstract >> outputType [

	^self value outputType
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

{ #category : 'Accessing - TF Operation' }
TensorFlowOperationAbstract >> value [
	
	value ifNil: [self error: 'value must be initialized']. 
	^value 
]
