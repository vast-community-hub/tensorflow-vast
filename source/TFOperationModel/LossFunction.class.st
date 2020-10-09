Class {
	#name : 'LossFunction',
	#superclass : 'TensorFlowOperationAbstract',
	#category : 'TFOperationModel'
}

{ #category : 'Accessing' }
LossFunction >> targetInput [

	self subclassResponsibility
]

{ #category : 'Accessing' }
LossFunction >> targetInputAsLabels [

	self subclassResponsibility
]

{ #category : 'Accessing' }
LossFunction >> targetInputName [

	^self targetInput operationName
]
