Extension {
	#name : 'Number'
}

{ #category : '*TFOperationModel',
 #vaCategories : ['TensorFlow-Kernel'] }
Number >> outputOn: aGraph [

	^(self asOperationOn: aGraph) firstOutput
]
