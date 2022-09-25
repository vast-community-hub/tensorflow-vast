Extension {
	#name : 'TFOutput'
}

{ #category : '*TensorFlowComputationModel',
 #vaCategories : ['accessing'] }
TFOutput >> currentComputation [

	^TensorFlowComputation on: self graph
]

{ #category : '*TensorFlowComputationModel',
 #vaCategories : ['accessing'] }
TFOutput >> outputOn: aGraph [

	^self
]

{ #category : '*TensorFlowComputationModel',
 #vaCategories : ['accessing'] }
TFOutput >> rank [

	^graph rankOf: self
]

{ #category : '*TensorFlowComputationModel',
 #vaCategories : ['accessing'] }
TFOutput >> shape [

	^self rank negative ifTrue: [TensorShape scalar] ifFalse: [graph shapeOf: self]
]
