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

{ #category : '*TFOperationModel',
 #vaCategories : ['accessing'] }
TFOutput >> rank [

	^graph rankOf: self
]

{ #category : '*TFOperationModel',
 #vaCategories : ['accessing'] }
TFOutput >> shape [

	^self rank negative ifTrue: [TensorShape scalar] ifFalse: [graph shapeOf: self]
]
