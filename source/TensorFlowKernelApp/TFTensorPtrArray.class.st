Class {
	#name : 'TFTensorPtrArray',
	#superclass : 'ExternalWordArray',
	#category : 'TensorFlowKernelApp'
}

{ #category : 'Not categorized' }
TFTensorPtrArray class >> initializeAfterLoad [
	super initializeAfterLoad
]

{ #category : 'Not categorized' }
TFTensorPtrArray class >> value: aTFTensor [
	^ (self new: 1)
		pointerAt: #value put: aTFTensor address;
		yourself
]

{ #category : 'accessing' }
TFTensorPtrArray >> elementClass [
	^ TFTensor
]

{ #category : 'accessing' }
TFTensorPtrArray >> numbersAt: index [
	| tensor |
	tensor := self at: index.
	^ tensor asNumbers
]

{ #category : 'accessing' }
TFTensorPtrArray >> value [
	^ TFTensor address: (self pointerAt: #value)
]
