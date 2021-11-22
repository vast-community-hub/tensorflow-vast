Extension {
	#name : 'SequenceableCollection'
}

{ #category : '*TensorFlowCore',
 #vaCategories : ['TensorFlow-Kernel'] }
SequenceableCollection >> asBooleanTensor [
	^ TFTensor fromBooleans: self
]

{ #category : '*TensorFlowCore',
 #vaCategories : ['TensorFlow-Kernel'] }
SequenceableCollection >> asFloatTensor [
	^ TFTensor fromFloats: self
]

{ #category : '*TensorFlowCore',
 #vaCategories : ['TensorFlow-Kernel'] }
SequenceableCollection >> asInt32Tensor [
	^ TFTensor fromInt32s: self
]

{ #category : '*TensorFlowCore',
 #vaCategories : ['TensorFlow-Kernel'] }
SequenceableCollection >> asInt64Tensor [
	^ TFTensor fromInt64s: self
]

{ #category : '*TensorFlowCore',
 #vaCategories : ['TensorFlow-Kernel'] }
SequenceableCollection >> asTensorShape [
	^ TensorShape withDimensionsSized: self
]

{ #category : '*TensorFlowCore',
 #vaCategories : ['TensorFlow-Kernel'] }
SequenceableCollection >> inferTensorRank [

	^1 + self first inferTensorRank
]

{ #category : '*TensorFlowCore',
 #vaCategories : ['TensorFlow-Kernel'] }
SequenceableCollection >> inferTensorShape [

	^self isEmpty
		ifTrue: [TensorShape vectorSized: 0]
		ifFalse: [
			TensorShape withDimensionsSized:
				((Array with: self size) , (self first inferTensorShape dimensionSizes))]
]
