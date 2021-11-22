Class {
	#name : 'Int64DataType',
	#superclass : 'TensorDataType',
	#category : 'TensorFlowCore'
}

{ #category : 'accessing' }
Int64DataType >> description [

	^'Int64'
]

{ #category : 'accessing' }
Int64DataType >> getElementAt: anIndex in: aByteArray [

	^aByteArray int64At: (anIndex - 1) * self dataSize
]

{ #category : 'accessing' }
Int64DataType >> put: aValue at: anIndex in: anExternalAddressOrByteArray [

	^anExternalAddressOrByteArray int64At: anIndex * self dataSize put: aValue
]

{ #category : 'accessing' }
Int64DataType >> uniqueIdentifier [


	^ 9
]
