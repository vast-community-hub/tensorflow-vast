Extension {
	#name : 'Number'
}

{ #category : '*TFOperationModel',
 #vaCategories : ['TensorFlow-Kernel'] }
Number >> outputOn: aComputation [


	^ ( self asOperationOn: aComputation ) value firstOutput
]
