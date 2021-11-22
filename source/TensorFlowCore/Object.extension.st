Extension {
	#name : 'Object'
}

{ #category : '*TensorFlowCore',
 #vaCategories : ['TensorFlow-Kernel'] }
Object >> ignoreFinalization [
	#fixme. #finalization
]

{ #category : '*TensorFlowCore',
 #vaCategories : ['TensorFlow-Kernel'] }
Object >> inferTensorRank [

	^0
]

{ #category : '*TensorFlowCore',
 #vaCategories : ['TensorFlow-Kernel'] }
Object >> inferTensorShape [

	^TensorShape scalar
]

{ #category : '*TensorFlowCore',
 #vaCategories : ['TensorFlow-Kernel'] }
Object >> singleElementsDo: aBlock [


	^ aBlock value: self 
]

{ #category : '*TensorFlowCore',
 #vaCategories : ['TensorFlow-Kernel'] }
Object >> singleElementsInCollection [

	^1
]
