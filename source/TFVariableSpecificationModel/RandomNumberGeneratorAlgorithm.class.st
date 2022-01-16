Class {
	#name : 'RandomNumberGeneratorAlgorithm',
	#superclass : 'Object',
	#category : 'TFVariableSpecificationModel'
}

{ #category : 'Accessing' }
RandomNumberGeneratorAlgorithm >> createInitialStateOn: aTensorFlowComputation [

	self subclassResponsibility
]

{ #category : 'Accessing' }
RandomNumberGeneratorAlgorithm >> uniqueIdentifier [

	self subclassResponsibility
]
