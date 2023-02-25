Extension {
	#name : 'TFOperationDescription'
}

{ #category : 'attributes' }
TFOperationDescription >> atUseNesterovPut: aBoolean [

	self at: TFAttributeName useNesterov putBoolean: aBoolean
]
