Extension {
	#name : 'Number'
}

{ #category : 'Converting' }
Number >> asOperationOn: aGraph [

	^self asTensor asOperationOn: aGraph
]

{ #category : 'TensorFlow-Kernel' }
Number >> outputOn: aComputation [


	^ ( self asOperationOn: aComputation ) value firstOutput
]
