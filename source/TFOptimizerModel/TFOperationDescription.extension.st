Extension {
	#name : 'TFOperationDescription'
}

{ #category : '*TFOptimizerModel',
 #vaCategories : ['attributes'] }
TFOperationDescription >> atUseNesterovPut: aBoolean [

	self at: TFAttributeName useNesterov putBoolean: aBoolean
]
