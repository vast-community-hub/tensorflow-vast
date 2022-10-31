Class {
	#name : 'CompletedNumberOfEpochsTest',
	#superclass : 'TestCase',
	#category : 'NeuralNetworkTrainingModelTests'
}

{ #category : 'Test' }
CompletedNumberOfEpochsTest >> testPrintString [

	self
		assert: (CompletedNumberOfEpochs after: 100) printString
		equals: 'Stop training after 100 epochs'
]
