Extension {
	#name : 'TFTensor'
}

{ #category : '*TFOperationModel',
 #vaCategories : ['Accessing'] }
TFTensor >> outputOn: aGraph [

	^(self asOperationOn: aGraph) outputOn: aGraph
]
