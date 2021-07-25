Extension {
	#name : 'Number'
}

{ #category : '*TFOperationModel',
 #vaCategories : ['Converting'] }
Number >> asOperationOn: aGraph [

	^self asTensor asOperationOn: aGraph
]

{ #category : '*TFOperationModel',
 #vaCategories : ['TensorFlow-Kernel'] }
Number >> outputOn: aComputation [


	^ ( self asOperationOn: aComputation ) value firstOutput
]
