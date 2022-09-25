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
 #vaCategories : ['ANSI-API'] }
Object >> isA: aClass [

	"Answer a Boolean which is true if aClass, is the class or
	 a superclass of the receiver, and false otherwise."

	^(self isMemberOf: aClass) or: [self class inheritsFrom: aClass]
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
