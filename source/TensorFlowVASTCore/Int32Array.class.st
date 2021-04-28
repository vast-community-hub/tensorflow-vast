Class {
	#name : 'Int32Array',
	#superclass : 'ExternalWordArray',
	#category : 'TensorFlowVASTCore'
}

{ #category : 'instance creation' }
Int32Array class >> initializeAfterLoad [
	self
		members: #(value)
		types: #(int32)
]

{ #category : 'instance creation' }
Int32Array class >> value: anInteger [
	^ (self new: 1)
		int32At: #value put: anInteger;
		yourself
]

{ #category : 'accessing' }
Int32Array >> value [
	^ self int32At: 0
]
