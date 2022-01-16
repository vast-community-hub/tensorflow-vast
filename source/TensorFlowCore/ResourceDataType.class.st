Class {
	#name : 'ResourceDataType',
	#superclass : 'TensorDataType',
	#category : 'TensorFlowCore'
}

{ #category : 'accessing' }
ResourceDataType >> description [

	^'Resource'
]

{ #category : 'accessing' }
ResourceDataType >> getElementAt: anIndex in: anExternalAddressOrByteArray [
	" Not sure if should be reading 64bit integer, but anyway to access the elements 
	 stored in the resource should be using ResourceVariableNode>>#underlayingValue "

	^anExternalAddressOrByteArray int64At: (anIndex - 1) * self dataSize
]

{ #category : 'accessing' }
ResourceDataType >> put: aValue at: anIndex in: anExternalAddressOrByteArray [
	" Not sure if should be reading 64bit integer, but anyway to access the elements 
	 stored in the resource should be using ResourceVariableNode>>#underlayingValue " 
	 
	^anExternalAddressOrByteArray int64At: anIndex * self dataSize put: aValue
]

{ #category : 'accessing' }
ResourceDataType >> uniqueIdentifier [

	^20
]
