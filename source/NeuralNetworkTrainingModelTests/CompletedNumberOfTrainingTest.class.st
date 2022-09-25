Class {
	#name : 'CompletedNumberOfTrainingTest',
	#superclass : 'TestCase',
	#category : 'NeuralNetworkTrainingModelTests'
}

{ #category : 'Test' }
CompletedNumberOfTrainingTest >> testPrintString [

	self
		assert: (CompletedNumberOfTraining after: 100) printString
		equals: 'Stop training after 100 epochs'
]
