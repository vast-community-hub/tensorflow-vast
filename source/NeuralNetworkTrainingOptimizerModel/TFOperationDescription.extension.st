Extension {
	#name : 'TFOperationDescription'
}

{ #category : '*NeuralNetworkTrainingOptimizerModel',
 #vaCategories : ['attributes'] }
TFOperationDescription >> atUseNesterovPut: aBoolean [

	self at: TFAttributeName useNesterov putBoolean: aBoolean
]
