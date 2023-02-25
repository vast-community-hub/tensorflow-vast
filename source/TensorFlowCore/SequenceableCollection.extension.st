Extension {
	#name : 'SequenceableCollection'
}

{ #category : 'TensorFlow-Kernel' }
SequenceableCollection >> asBooleanTensor [
	^ TFTensor fromBooleans: self
]

{ #category : 'TensorFlow-Kernel' }
SequenceableCollection >> asFloatTensor [
	^ TFTensor fromFloats: self
]

{ #category : 'TensorFlow-Kernel' }
SequenceableCollection >> asInt32Tensor [
	^ TFTensor fromInt32s: self
]

{ #category : 'TensorFlow-Kernel' }
SequenceableCollection >> asInt64Tensor [
	^ TFTensor fromInt64s: self
]

{ #category : 'TensorFlow-Kernel' }
SequenceableCollection >> asTensorShape [
	^ TensorShape withDimensionsSized: self
]

{ #category : 'TensorFlow-Kernel' }
SequenceableCollection >> inferTensorRank [

	^1 + self first inferTensorRank
]

{ #category : 'TensorFlow-Kernel' }
SequenceableCollection >> inferTensorShape [

	^self isEmpty
		ifTrue: [TensorShape vectorSized: 0]
		ifFalse: [
			TensorShape withDimensionsSized:
				((Array with: self size) , (self first inferTensorShape dimensionSizes))]
]
