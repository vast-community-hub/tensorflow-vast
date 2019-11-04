Class {
	#name : 'TFOperationPtrArray',
	#superclass : 'ExternalWordArray',
	#category : 'TensorFlowKernelApp'
}

{
	#category : 'Not categorized'
}
TFOperationPtrArray class >> initializeAfterLoad [
	super initializeAfterLoad
]

{
	#category : 'Not categorized'
}
TFOperationPtrArray class >> value: aTFOperation [
	^ (self new: 1)
		pointerAt: #value put: aTFOperation address;
		yourself
]

{
	#category : 'Not categorized'
}
TFOperationPtrArray >> elementClass [
	^ TFOperation
]

{
	#category : 'Not categorized'
}
TFOperationPtrArray >> value [
	^ TFOperation address: (self pointerAt: #value)
]
