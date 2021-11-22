Extension {
	#name : 'String'
}

{ #category : '*TensorFlowCore',
 #vaCategories : ['TensorFlow-Kernel'] }
String >> asAsciiZ [
	^ self asPSZ
]

{ #category : '*TensorFlowCore',
 #vaCategories : ['TensorFlow-Kernel'] }
String >> asTensor [
	^ TFTensor fromString: self
]

{ #category : '*TensorFlowCore',
 #vaCategories : ['TensorFlow-Kernel'] }
String >> inferTensorRank [

	^0
]

{ #category : '*TensorFlowCore',
 #vaCategories : ['TensorFlow-Kernel'] }
String >> inferTensorShape [

	^TensorShape scalar
]

{ #category : '*TensorFlowCore',
 #vaCategories : ['TensorFlow-Kernel'] }
String >> singleElementsDo: aBlock [


	^ aBlock value: self 
]

{ #category : '*TensorFlowCore',
 #vaCategories : ['TensorFlow-Kernel'] }
String >> singleElementsInCollection [

	^1
]
