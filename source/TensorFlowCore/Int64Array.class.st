Class {
	#name : 'Int64Array',
	#superclass : 'ExternalWordArray',
	#category : 'TensorFlowCore'
}

{ #category : 'instance creation' }
Int64Array class >> initializeAfterLoad [
	self
		members: #(value)
		types: #(int64)
]

{ #category : 'instance creation' }
Int64Array class >> value: anInteger [
	^ (self new: 1)
		int64At: #value put: anInteger;
		yourself
]

{ #category : 'accessing' }
Int64Array >> value [
	^ self int64At: 0
]
