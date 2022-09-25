Class {
	#name : 'RandomNumberGeneratorAlgorithm',
	#superclass : 'Object',
	#category : 'TensorFlowOperationRandomModel'
}

{ #category : 'Accessing' }
RandomNumberGeneratorAlgorithm >> createInitialStateOn: aTensorFlowComputation [

	self subclassResponsibility
]

{ #category : 'Accessing' }
RandomNumberGeneratorAlgorithm >> uniqueIdentifier [

	self subclassResponsibility
]
