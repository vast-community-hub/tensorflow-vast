Extension {
	#name : 'Object'
}

{ #category : 'TensorFlow-Kernel' }
Object >> ignoreFinalization [
	#fixme. #finalization
]

{ #category : 'TensorFlow-Kernel' }
Object >> inferTensorRank [

	^0
]

{ #category : 'TensorFlow-Kernel' }
Object >> inferTensorShape [

	^TensorShape scalar
]

{ #category : 'ANSI-API' }
Object >> isA: aClass [

	"Answer a Boolean which is true if aClass, is the class or
	 a superclass of the receiver, and false otherwise."

	^(self isMemberOf: aClass) or: [self class inheritsFrom: aClass]
]

{ #category : 'TensorFlow-Kernel' }
Object >> singleElementsDo: aBlock [


	^ aBlock value: self 
]

{ #category : 'TensorFlow-Kernel' }
Object >> singleElementsInCollection [

	^1
]
