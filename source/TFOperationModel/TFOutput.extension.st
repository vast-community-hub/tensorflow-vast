Extension {
	#name : 'TFOutput'
}

{ #category : '*TFOperationModel',
 #vaCategories : ['accessing'] }
TFOutput >> currentComputation [

	^TensorFlowComputation on: self graph
]

{ #category : '*TFOperationModel',
 #vaCategories : ['accessing'] }
TFOutput >> outputOn: aGraph [

	^self
]
