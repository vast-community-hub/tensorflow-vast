Class {
	#name : 'Dataset',
	#superclass : 'TensorFlowOperationAbstract',
	#category : 'TFDatasetModel'
}

{ #category : 'Accessing' }
Dataset >> outputShapes [

	self subclassResponsibility
]

{ #category : 'Accessing' }
Dataset >> outputTypes [

	self subclassResponsibility
]
