Extension {
	#name : 'String'
}

{ #category : 'TensorFlow-Kernel' }
String >> asAsciiZ [
	^ self asPSZ
]

{ #category : 'TensorFlow-Kernel' }
String >> asTensor [

	^TFString with: self
]

{ #category : 'TensorFlow-Kernel' }
String >> inferTensorRank [

	^0
]

{ #category : 'TensorFlow-Kernel' }
String >> inferTensorShape [

	^TensorShape scalar
]

{ #category : 'TensorFlow-Kernel' }
String >> singleElementsDo: aBlock [


	^ aBlock value: self 
]

{ #category : 'TensorFlow-Kernel' }
String >> singleElementsInCollection [

	^1
]
