Extension {
	#name : 'TFOutput'
}

{ #category : 'accessing' }
TFOutput >> currentComputation [

	^TensorFlowComputation on: self graph
]

{ #category : 'accessing' }
TFOutput >> outputOn: aGraph [

	^self
]

{ #category : 'accessing' }
TFOutput >> rank [

	^graph rankOf: self
]

{ #category : 'accessing' }
TFOutput >> shape [

	^self rank negative ifTrue: [TensorShape scalar] ifFalse: [graph shapeOf: self]
]
