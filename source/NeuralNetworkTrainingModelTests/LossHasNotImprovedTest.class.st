Class {
	#name : 'LossHasNotImprovedTest',
	#superclass : 'TestCase',
	#category : 'NeuralNetworkTrainingModelTests'
}

{ #category : 'Test' }
LossHasNotImprovedTest >> testPrintString [

	self
		assert: (LossHasNotImproved moreThan: 0.005) printString
		equals: 'Stop training when loss has not improved more than 0.005'
]
