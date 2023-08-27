Class {
	#name : 'ActivationFunction',
	#superclass : 'TensorFlowOperationAbstract',
	#category : 'TensorFlowOperationMathModel'
}

{ #category : 'Instance Creation' }
ActivationFunction class >> activating: aNeuron [

	^self named: 'activation' activating: aNeuron
]

{ #category : 'Instance Creation' }
ActivationFunction class >> named: anOperationName activating: aNeuron [

	self subclassResponsibility
]
