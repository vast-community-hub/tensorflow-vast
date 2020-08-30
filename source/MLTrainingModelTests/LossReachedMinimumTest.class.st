Class {
	#name : 'LossReachedMinimumTest',
	#superclass : 'TestCase',
	#category : 'MLTrainingModelTests'
}

{ #category : 'Printing' }
LossReachedMinimumTest >> testPrintString [

	self
		assert: (LossReachedMinimum lowerThan: 0.01) printString
		equals: 'Stop training when loss has reached a value lower than 0.01'
]
