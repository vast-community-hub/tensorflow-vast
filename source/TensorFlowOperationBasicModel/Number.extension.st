Extension {
	#name : 'Number'
}

{ #category : '*TensorFlowOperationBasicModel',
 #vaCategories : ['Converting'] }
Number >> asOperationOn: aGraph [

	^self asTensor asOperationOn: aGraph
]

{ #category : '*TensorFlowOperationBasicModel',
 #vaCategories : ['TensorFlow-Kernel'] }
Number >> outputOn: aComputation [


	^ ( self asOperationOn: aComputation ) value firstOutput
]
